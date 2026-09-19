import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import 'package:zeno/core/database/collections/inventory_collections.dart';
import 'package:zeno/core/database/collections/crm_collections.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/inventory/domain/repositories/i_inventory_repository.dart';
import 'package:zeno/features/inventory/domain/models/stock_transaction.dart';
import 'package:zeno/features/inventory/domain/services/recipe_deduction_service.dart';
import 'package:zeno/features/orders/domain/services/kot_engine.dart';
import 'package:zeno/core/database/collections/fnb_collections.dart';
import '../../domain/services/billing_finance_service.dart';
import '../../domain/models/payment.dart';
import '../../domain/repositories/i_billing_repository.dart';
import '../../domain/models/bill.dart';
import '../../domain/models/bill_item.dart';
import '../../domain/models/billing_customer.dart';
import '../../domain/models/tax_details.dart';
import 'package:isar/isar.dart';

class IsarBillingRepository implements IBillingRepository {
  final DatabaseService db;
  IsarBillingRepository(this.db);

  @override
  Future<void> saveBill(Bill bill) async {
    final order = SalesOrderCollection()
      ..uuid = bill.id
      ..orderNumber = bill.id
      ..customerId = bill.customer?.id ?? 'Walk-in'
      ..warehouseId = 'POS-WH'
      ..date = bill.timestamp
      ..status = bill.status.toLowerCase()
      ..totalAmount = bill.grandTotal
      ..subTotal = bill.subtotal
      ..totalDiscount = bill.totalDiscount
      ..totalTax = bill.totalTax
      ..exchangeRate = 1.0
      ..currency = 'INR'
      ..items = bill.items
          .map((item) => TransactionItem()
            ..productId = item.productId
            ..description = item.productName
            ..quantity = item.quantity.toDouble()
            ..unitPrice = item.unitPrice
            ..taxRate =
                item.taxes.isNotEmpty ? item.taxes.first.percentage : 0.0
            ..subtotal = item.totalAmount)
          .toList()
      ..payments = bill.payments
          .map((p) => PaymentEmbedded()
            ..transactionId = p.transactionId
            ..method = p.method.name
            ..amount = p.amount
            ..timestamp = p.timestamp
            ..status = p.status)
          .toList();

    // Validate variant stock before persisting a completed sale. This keeps
    // the billing flow from completing a sale that would push a saved
    // colour/size variant below zero stock.
    if (bill.status == 'Completed') {
      await _validateVariantStockForCompletion(bill);
    }

    await db.isar.writeTxn(() async {
      await db.isar.collection<SalesOrderCollection>().put(order);

      if (bill.status == 'Completed') {
        final bool isRefund = bill.grandTotal < 0;
        final invoice = InvoiceCollection()
          ..uuid = 'INV-${bill.id}'
          ..invoiceNumber = 'INV-${bill.id}'
          ..orderId = bill.id
          ..date = DateTime.now()
          ..dueDate = DateTime.now()
          ..status = isRefund ? 'refunded' : 'paid'
          ..totalAmount = bill.grandTotal
          ..balanceDue = 0.0;
        await db.isar.collection<InvoiceCollection>().put(invoice);
      }
    });

    if (bill.status == 'Completed') {
      await _handleCompletionSideEffects(bill);
    }
  }

  Future<void> _validateVariantStockForCompletion(Bill bill) async {
    if (bill.items.isEmpty) return;

    final products = await db.isar
        .collection<ProductCollection>()
        .filter()
        .isDeletedEqualTo(false)
        .findAll();

    for (final item in bill.items) {
      // Returns increase variant stock, so only positive sale quantities need
      // an availability check.
      if (item.quantity <= 0 || item.variant.isEmpty) continue;

      ProductVariantEmbed? matchedVariant;
      for (final product in products) {
        final variants = product.variants ?? const <ProductVariantEmbed>[];
        for (final variant in variants) {
          if (variant.uuid == item.productId || variant.sku == item.sku) {
            matchedVariant = variant;
            break;
          }
        }
        if (matchedVariant != null) break;
      }

      if (matchedVariant == null) {
        throw StateError(
          'Variant not found for ${item.productName} (${item.sku}).',
        );
      }

      if (matchedVariant.stockLevel < item.quantity.toDouble()) {
        throw StateError(
          'Insufficient stock for ${item.productName} ${item.variant}. '
          'Available: ${matchedVariant.stockLevel.round()}, '
          'requested: ${item.quantity}.',
        );
      }
    }
  }

  Future<void> _handleCompletionSideEffects(Bill bill) async {
    // 1. Inventory Deduction
    final invRepo = sl<IInventoryRepository>();
    final List<StockTransaction> transactions = [];

    for (var item in bill.items) {
      final bool isItemReturn = item.quantity < 0;

      if (item.variant.isNotEmpty) {
        // Variant stock is stored on the saved ProductCollection variant.
        // Update that exact variant instead of the parent product stock.
        final products = await db.isar
            .collection<ProductCollection>()
            .filter()
            .isDeletedEqualTo(false)
            .findAll();

        for (final product in products) {
          final variant = product.variants
              ?.where((v) =>
                  v.uuid == item.productId || v.sku == item.sku)
              .cast<ProductVariantEmbed?>()
              .firstWhere((v) => v != null, orElse: () => null);

          if (variant != null) {
            variant.stockLevel =
                variant.stockLevel - item.quantity.toDouble();
            await db.isar.writeTxn(() async {
              await db.isar.collection<ProductCollection>().put(product);
            });
            break;
          }
        }
      } else {
        transactions.add(StockTransaction(
          id: 'POS-${isItemReturn ? 'IN' : 'OUT'}-${bill.id}-${item.productId}',
          stockItemId: item.productId,
          quantityDelta: -item.quantity.toDouble(),
          type: isItemReturn ? TransactionType.inReturn : TransactionType.outSale,
          referenceId: bill.id,
          timestamp: DateTime.now(),
          userId: 'current_user',
        ));
      }
    }

    if (transactions.isNotEmpty) {
      await invRepo.recordTransactions(transactions);
    }

    // 2. Finance
    final finService = sl<BillingFinanceService>();
    await finService.recordSale(bill.id, bill.grandTotal, bill.totalTax);

    // 2.1 Recipe Deduction
    final recipeService = sl<RecipeDeductionService>();
    for (var item in bill.items) {
      if (item.quantity > 0) {
        await recipeService.deductIngredientsForSale(item.productId, item.quantity.toDouble());
      }
    }

    // 2.2 KOT Generation
    final kotEngine = sl<KotEngine>();
    final List<KotItemEmbedded> kotItems = bill.items.map((i) {
      final k = KotItemEmbedded();
      k.productId = i.productId;
      k.name = i.productName;
      k.quantity = i.quantity.toDouble();
      k.notes = i.notes;
      return k;
    }).toList();
    await kotEngine.generateKotsFromOrder(bill.id, kotItems);

    // 3. Customer
    if (bill.customer != null) {
      final customer = await db.isar.collection<CustomerCollection>()
          .filter()
          .uuidEqualTo(bill.customer!.id)
          .findFirst();
      if (customer != null) {
        await db.isar.writeTxn(() async {
          customer.lifetimeSpent += bill.grandTotal;
          customer.loyaltyPoints += (bill.grandTotal / 10).floor();
          customer.lastPurchaseAt = bill.timestamp;
          customer.updatedAt = DateTime.now();
          await db.isar.collection<CustomerCollection>().put(customer);
        });
      }
    }
  }

  @override
  Future<Bill?> getBill(String id) async {
    final order = await db.isar.collection<SalesOrderCollection>().filter().uuidEqualTo(id).findFirst();
    if (order == null) return null;

    return Bill(
      id: order.uuid, timestamp: order.date, status: order.status,
      grandTotal: order.totalAmount, totalTax: order.totalTax,
      items: order.items?.map((i) => BillItem(
        productId: i.productId, productName: i.description, sku: '', variant: '',
        unitPrice: i.unitPrice, quantity: i.quantity.toInt(), totalAmount: i.subtotal,
        taxes: [TaxDetails(label: 'Tax', percentage: i.taxRate, amount: (i.subtotal * i.taxRate) / 100)],
      )).toList() ?? [],
      payments: order.payments?.map((p) => Payment(
        transactionId: p.transactionId ?? '',
        method: PaymentMethod.values.firstWhere((e) => e.name == p.method, orElse: () => PaymentMethod.cash),
        amount: p.amount, timestamp: p.timestamp, status: p.status,
      )).toList() ?? [],
    );
  }

  @override
  Future<List<Bill>> getHeldBills() async {
    final heldOrders = await db.isar.collection<SalesOrderCollection>().filter().statusEqualTo('held').findAll();
    return heldOrders.map((order) => Bill(id: order.uuid, timestamp: order.date, status: 'Held', grandTotal: order.totalAmount, totalTax: order.totalTax)).toList();
  }

  @override
  Future<BillingCustomer?> findCustomer(String query) async {
    final customer = await db.isar.collection<CustomerCollection>().filter().nameContains(query, caseSensitive: false).or().phoneContains(query).findFirst();
    if (customer == null) return null;
    return BillingCustomer(id: customer.uuid, name: customer.name, phone: customer.phone, loyaltyTier: 'Retail');
  }

  @override
  Future<BillItem?> findProduct(String query) async {
    final normalized = query.trim();
    if (normalized.isEmpty) return null;

    final products = await db.isar
        .collection<ProductCollection>()
        .filter()
        .isDeletedEqualTo(false)
        .findAll();

    // Exact parent product SKU/barcode.
    for (final p in products) {
      if (p.sku == normalized || p.barcode == normalized) {
        return BillItem(
          productId: p.uuid,
          productName: p.name,
          sku: p.sku,
          variant: '',
          unitPrice: p.basePrice,
          totalAmount: p.basePrice,
          taxes: [TaxDetails(label: 'GST', percentage: p.taxRate, amount: 0)],
        );
      }
    }

    // Exact saved variant SKU/barcode/ID.
    for (final p in products) {
      final variants = p.variants ?? const <ProductVariantEmbed>[];
      for (final v in variants) {
        if (v.sku != normalized &&
            v.barcode != normalized &&
            v.uuid != normalized) {
          continue;
        }

        final variantLabel = [
          if ((v.color ?? '').trim().isNotEmpty) v.color!.trim(),
          if ((v.size ?? '').trim().isNotEmpty) v.size!.trim(),
        ].join(' / ');

        final price = p.basePrice + (v.priceAdjustment ?? 0.0);
        return BillItem(
          // Variant UUID is the line identity, preventing two variants
          // of the same parent product from merging into one line.
          productId: v.uuid ?? normalized,
          productName: p.name,
          sku: v.sku ?? '',
          variant: variantLabel,
          unitPrice: price,
          totalAmount: price,
          taxes: [TaxDetails(label: 'GST', percentage: p.taxRate, amount: 0)],
        );
      }
    }

    // Normal product-name search.
    for (final p in products) {
      if (p.name.toLowerCase().contains(normalized.toLowerCase())) {
        return BillItem(
          productId: p.uuid,
          productName: p.name,
          sku: p.sku,
          variant: '',
          unitPrice: p.basePrice,
          totalAmount: p.basePrice,
          taxes: [TaxDetails(label: 'GST', percentage: p.taxRate, amount: 0)],
        );
      }
    }

    return null;
  }

  @override
  Future<void> saveHeldBill(Bill bill) async => await saveBill(bill.copyWith(status: 'Held'));
}
