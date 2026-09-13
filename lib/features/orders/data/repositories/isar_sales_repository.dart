import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import '../../domain/repositories/i_sales_repository.dart';
import '../../domain/models/sales_order.dart';
import '../../domain/models/sales_order_status.dart';
import '../../domain/models/sales_quotation.dart';
import '../../domain/models/shipment.dart';
import '../../domain/models/sales_invoice.dart';
import '../../domain/models/rma_credit.dart';
import 'package:isar/isar.dart';

class IsarSalesRepository implements ISalesRepository {
  final DatabaseService db;
  IsarSalesRepository(this.db);

  IsarCollection<SalesOrderCollection> get orderCol =>
      db.isar.salesOrderCollections;
  IsarCollection<InvoiceCollection> get invCol => db.isar.invoiceCollections;

  @override
  Future<List<SalesOrder>> getOrders() async {
    final List<SalesOrderCollection> results = await orderCol.where().findAll();
    return results.map<SalesOrder>((e) => _toDomain(e)).toList();
  }

  @override
  Future<SalesOrder?> getOrderById(String id) async {
    final SalesOrderCollection? e =
        await orderCol.filter().uuidEqualTo(id).findFirst();
    if (e == null) return null;
    return _toDomain(e);
  }

  @override
  Future<void> saveOrder(SalesOrder order) async {
    final existing = await orderCol.filter().uuidEqualTo(order.id).findFirst();

    final s = (existing ?? SalesOrderCollection())
      ..uuid = order.id
      ..orderNumber = order.id
      ..customerId = order.customerId
      ..quotationId = order.quotationId
      ..warehouseId = order.warehouseId
      ..date = order.orderDate
      ..status = order.status.name
      ..totalAmount = order.totalAmount
      ..totalTax = order.totalTax
      ..currency = order.currency
      ..exchangeRate = order.exchangeRate;

    await db.isar.writeTxn(() async {
      await orderCol.put(s);
    });
  }

  @override
  Future<void> deleteOrder(String id) async {
    await db.isar.writeTxn(() async {
      await orderCol.filter().uuidEqualTo(id).deleteAll();
    });
  }

  @override
  Future<List<SalesQuotation>> getQuotations() async => [];

  @override
  Future<void> saveQuotation(SalesQuotation quotation) async {}

  @override
  Future<List<Shipment>> getShipments(String orderId) async => [];

  @override
  Future<void> saveShipment(Shipment shipment) async {}

  @override
  Future<List<SalesInvoice>> getInvoices() async {
    final List<InvoiceCollection> results = await invCol.where().findAll();
    return results
        .map<SalesInvoice>((e) => SalesInvoice(
              id: e.uuid,
              orderId: e.orderId,
              customerId: '', // Needs join or fetch
              invoiceNumber: e.invoiceNumber,
              date: e.date,
              dueDate: e.dueDate,
              items: [],
              subtotal: e.totalAmount,
              taxTotal: 0.0,
              totalAmount: e.totalAmount,
              currency: 'USD',
              status: InvoiceStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => InvoiceStatus.unpaid),
            ))
        .toList();
  }

  @override
  Future<void> saveInvoice(SalesInvoice invoice) async {
    final i = InvoiceCollection()
      ..uuid = invoice.id
      ..invoiceNumber = invoice.invoiceNumber
      ..orderId = invoice.orderId
      ..date = invoice.date
      ..dueDate = invoice.dueDate
      ..status = invoice.status.name
      ..totalAmount = invoice.totalAmount
      ..balanceDue = invoice.totalAmount;

    await db.isar.writeTxn(() async {
      await invCol.put(i);
    });
  }

  @override
  Future<void> createRMA(SalesReturn rma) async {}

  SalesOrder _toDomain(SalesOrderCollection e) {
    return SalesOrder(
      id: e.uuid,
      customerId: e.customerId,
      quotationId: e.quotationId,
      warehouseId: e.warehouseId,
      orderDate: e.date,
      status: SalesOrderStatus.values.firstWhere((s) => s.name == e.status,
          orElse: () => SalesOrderStatus.draft),
      items: [], // Item mapping would go here
      totalAmount: e.totalAmount,
      totalTax: e.totalTax,
      currency: e.currency,
      exchangeRate: e.exchangeRate,
    );
  }
}
