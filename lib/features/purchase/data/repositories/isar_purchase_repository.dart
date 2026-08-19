import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/models/purchase_requisition.dart';
import '../../domain/models/grn.dart';
import '../../domain/models/purchase_invoice.dart';
import '../../domain/models/rfq.dart';
import '../../domain/models/supplier_quotation.dart';
import '../../domain/models/purchase_item.dart';
import 'package:isar/isar.dart';

class IsarPurchaseRepository implements IPurchaseRepository {
  final DatabaseService db;
  IsarPurchaseRepository(this.db);

  @override
  Future<List<PurchaseRequisition>> getRequisitions() async {
    final col = db.isar.collection<PurchaseRequisitionCollection>();
    final results = await col.where().findAll();
    return results
        .map<PurchaseRequisition>((e) => PurchaseRequisition(
              id: e.uuid,
              requestedById: e.requestedById,
              requestedDate: e.requestedDate,
              requiredDate: e.requestedDate,
              status: PRStatus.values.firstWhere(
                  (element) => element.name == e.status,
                  orElse: () => PRStatus.draft),
              items: e.items
                      ?.map((i) => PurchaseItem(
                            productId: i.productId,
                            variantId: i.variantId ?? '',
                            name: i.description,
                            quantity: i.quantity,
                            receivedQuantity: i.fulfilledQuantity,
                            unitId: 'unit',
                            unitPrice: i.unitPrice,
                            taxRate: i.taxRate,
                            discount: i.discount,
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  @override
  Future<void> saveRequisition(PurchaseRequisition pr) async {
    final col = db.isar.collection<PurchaseRequisitionCollection>();
    final entry = PurchaseRequisitionCollection()
      ..uuid = pr.id
      ..requestedById = pr.requestedById
      ..requestedDate = pr.requestedDate
      ..status = pr.status.name
      ..items = pr.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..variantId = i.variantId
            ..sku = ''
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = i.receivedQuantity
            ..unitPrice = i.unitPrice
            ..taxRate = i.taxRate
            ..discount = i.discount
            ..subtotal = i.subtotal)
          .toList();

    await db.isar.writeTxn(() async {
      await col.put(entry);
    });
  }

  @override
  Future<List<RFQ>> getRFQs() async {
    final col = db.isar.collection<RFQCollection>();
    final results = await col.where().findAll();
    return results
        .map<RFQ>((e) => RFQ(
              id: e.uuid,
              title: e.uuid, // Using UUID as title if missing
              category: 'General',
              requestedById: 'admin',
              department: 'Procurement',
              items: e.items
                      ?.map((i) => PurchaseItem(
                            productId: i.productId,
                            variantId: i.variantId ?? '',
                            name: i.description,
                            quantity: i.quantity,
                            receivedQuantity: i.fulfilledQuantity,
                            unitId: 'unit',
                            unitPrice: i.unitPrice,
                            taxRate: i.taxRate,
                            discount: i.discount,
                          ))
                      .toList() ??
                  [],
              invitedSupplierIds: e.supplierIds ?? [],
              createdAt: e.createdAt,
              closingDate: e.expiryDate,
              status: RFQStatus.values.firstWhere(
                  (element) => element.name == e.status,
                  orElse: () => RFQStatus.draft),
              priority: RFQPriority.medium,
            ))
        .toList();
  }

  @override
  Future<void> saveRFQ(RFQ rfq) async {
    final col = db.isar.collection<RFQCollection>();
    final entry = RFQCollection()
      ..uuid = rfq.id
      ..expiryDate = rfq.closingDate
      ..status = rfq.status.name
      ..supplierIds = rfq.invitedSupplierIds
      ..items = rfq.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..variantId = i.variantId
            ..sku = ''
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = i.receivedQuantity
            ..unitPrice = i.unitPrice
            ..taxRate = i.taxRate
            ..discount = i.discount
            ..subtotal = i.subtotal)
          .toList();

    await db.isar.writeTxn(() async {
      await col.put(entry);
    });
  }

  @override
  Future<List<SupplierQuotation>> getQuotations(String rfqId) async {
    final col = db.isar.collection<SupplierQuotationCollection>();
    final results = await col.filter().rfqIdEqualTo(rfqId).findAll();
    return results
        .map<SupplierQuotation>((e) => SupplierQuotation(
              id: e.uuid,
              rfqId: e.rfqId,
              supplierId: e.supplierId,
              currency: e.currency,
              quotationDate: e.quotationDate,
              validityDate: e.quotationDate,
              subtotal: e.totalAmount,
              totalAmount: e.totalAmount,
              leadTimeDays: 7,
              paymentTerms: 'Net 30',
              warrantyTerms: '1 Year',
              qualityRating: 0,
              pastPerformanceScore: 0,
              deliveryReliabilityScore: 0,
              aiScore: 0,
              isSelected: e.isSelected,
              items: e.items
                      ?.map((i) => PurchaseItem(
                            productId: i.productId,
                            variantId: i.variantId ?? '',
                            name: i.description,
                            quantity: i.quantity,
                            receivedQuantity: i.fulfilledQuantity,
                            unitId: 'unit',
                            unitPrice: i.unitPrice,
                            taxRate: i.taxRate,
                            discount: i.discount,
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  @override
  Future<void> saveQuotation(SupplierQuotation quotation) async {
    final col = db.isar.collection<SupplierQuotationCollection>();
    final entry = SupplierQuotationCollection()
      ..uuid = quotation.id
      ..rfqId = quotation.rfqId
      ..supplierId = quotation.supplierId
      ..quotationDate = quotation.quotationDate
      ..totalAmount = quotation.totalAmount
      ..currency = quotation.currency
      ..isSelected = quotation.isSelected
      ..items = quotation.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..variantId = i.variantId
            ..sku = ''
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = i.receivedQuantity
            ..unitPrice = i.unitPrice
            ..taxRate = i.taxRate
            ..discount = i.discount
            ..subtotal = i.subtotal)
          .toList();

    await db.isar.writeTxn(() async {
      await col.put(entry);
    });
  }

  @override
  Future<List<PurchaseOrder>> getPurchaseOrders() async {
    final col = db.isar.collection<PurchaseOrderCollection>();
    final results = await col.where().findAll();
    return results.map<PurchaseOrder>((e) => _toDomain(e)).toList();
  }

  @override
  Future<PurchaseOrder?> getPOById(String id) async {
    final col = db.isar.collection<PurchaseOrderCollection>();
    final e = await col.filter().uuidEqualTo(id).findFirst();
    if (e == null) return null;
    return _toDomain(e);
  }

  @override
  Future<void> savePO(PurchaseOrder po) async {
    final col = db.isar.collection<PurchaseOrderCollection>();
    final existing = await col.filter().uuidEqualTo(po.id).findFirst();

    final entry = (existing ?? PurchaseOrderCollection())
      ..uuid = po.id
      ..orderNumber = po.poNumber
      ..supplierId = po.supplierId
      ..buyerId = po.buyerId
      ..date = po.orderDate
      ..expectedDeliveryDate = po.expectedDeliveryDate
      ..status = po.status.name
      ..approvalStatus = po.approvalStatus.name
      ..warehouseId = po.warehouseId
      ..branchId = po.branchId
      ..totalAmount = po.totalAmount
      ..totalTax = po.totalTax
      ..currency = po.currency
      ..exchangeRate = po.exchangeRate
      ..priority = po.priority
      ..auditTrail = po.auditTrail
      ..items = po.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..variantId = i.variantId
            ..sku = ''
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = i.receivedQuantity
            ..unitPrice = i.unitPrice
            ..taxRate = i.taxRate
            ..discount = i.discount
            ..subtotal = i.subtotal)
          .toList();

    if (existing == null) entry.createdAt = DateTime.now();

    await db.isar.writeTxn(() async {
      await col.put(entry);
    });
  }

  @override
  Future<List<GRN>> getGRNs() async {
    final col = db.isar.collection<GRNCollection>();
    final results = await col.where().findAll();
    return results
        .map<GRN>((e) => GRN(
              id: e.uuid,
              poId: e.poId,
              supplierId: e.supplierId,
              warehouseId: e.warehouseId,
              branchId: 'B-NORTH', // Defaulting since missing in collection
              receivedDate: e.receivedDate,
              receivedById: 'admin',
              status: GRNStatus.values.firstWhere(
                  (element) => element.name == e.status,
                  orElse: () => GRNStatus.expected),
              receivedItems: e.items
                      ?.map((i) => GRNItem(
                            orderItem: PurchaseItem(
                                productId: i.productId,
                                variantId: i.variantId ?? '',
                                name: i.name,
                                quantity: i.quantityOrdered,
                                unitId: 'unit'),
                            receivedQuantity: i.quantityReceived,
                            acceptedQuantity: i.quantityAccepted,
                            rejectedQuantity: i.quantityRejected,
                            batchId: i.batchId,
                            serialNumbers: i.serialNumbers ?? [],
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  @override
  Future<void> saveGRN(GRN grn) async {
    final col = db.isar.collection<GRNCollection>();
    final existing = await col.filter().uuidEqualTo(grn.id).findFirst();

    final entry = (existing ?? GRNCollection())
      ..uuid = grn.id
      ..poId = grn.poId
      ..supplierId = grn.supplierId
      ..warehouseId = grn.warehouseId
      ..receivedDate = grn.receivedDate
      ..status = grn.status.name
      ..items = grn.receivedItems
          .map((i) => GRNItemEmbedded()
            ..productId = i.orderItem.productId
            ..variantId = i.orderItem.variantId
            ..name = i.orderItem.name
            ..quantityOrdered = i.orderItem.quantity
            ..quantityReceived = i.receivedQuantity
            ..quantityAccepted = i.acceptedQuantity
            ..quantityRejected = i.rejectedQuantity
            ..batchId = i.batchId
            ..serialNumbers = i.serialNumbers)
          .toList();

    if (existing == null) entry.createdAt = DateTime.now();

    await db.isar.writeTxn(() async {
      await col.put(entry);
    });
  }

  @override
  Future<List<PurchaseInvoice>> getInvoices() async {
    final col = db.isar.collection<InvoiceCollection>();
    final results = await col.where().findAll();
    return results
        .map<PurchaseInvoice>((e) => PurchaseInvoice(
              id: e.uuid,
              poId: e.orderId,
              supplierId: '',
              invoiceNumber: e.invoiceNumber,
              invoiceDate: e.date,
              dueDate: e.dueDate,
              totalAmount: e.totalAmount,
              currency: 'USD',
              status: InvoiceStatus.values.firstWhere(
                  (element) => element.name == e.status,
                  orElse: () => InvoiceStatus.unpaid),
              items: [],
              subtotal: e.totalAmount,
              taxTotal: 0.0,
            ))
        .toList();
  }

  @override
  Future<void> saveInvoice(PurchaseInvoice invoice) async {
    final col = db.isar.collection<InvoiceCollection>();
    final entry = InvoiceCollection()
      ..uuid = invoice.id
      ..invoiceNumber = invoice.invoiceNumber
      ..orderId = invoice.poId
      ..date = invoice.invoiceDate
      ..dueDate = invoice.dueDate
      ..totalAmount = invoice.totalAmount
      ..status = invoice.status.name
      ..balanceDue = invoice.totalAmount;

    await db.isar.writeTxn(() async {
      await col.put(entry);
    });
  }

  PurchaseOrder _toDomain(PurchaseOrderCollection e) {
    return PurchaseOrder(
      id: e.uuid,
      poNumber: e.orderNumber,
      supplierId: e.supplierId,
      buyerId: e.buyerId,
      orderDate: e.date,
      expectedDeliveryDate: e.expectedDeliveryDate ?? e.date,
      currency: e.currency,
      exchangeRate: e.exchangeRate,
      status: POStatus.values.firstWhere((element) => element.name == e.status,
          orElse: () => POStatus.draft),
      approvalStatus: POApprovalStatus.values.firstWhere(
          (element) => element.name == e.approvalStatus,
          orElse: () => POApprovalStatus.draft),
      warehouseId: e.warehouseId,
      branchId: e.branchId,
      totalAmount: e.totalAmount,
      totalTax: e.totalTax,
      priority: e.priority,
      auditTrail: e.auditTrail,
      items: e.items
              ?.map((i) => PurchaseItem(
                    productId: i.productId,
                    variantId: i.variantId ?? '',
                    name: i.description,
                    quantity: i.quantity,
                    receivedQuantity: i.fulfilledQuantity,
                    unitId: 'unit',
                    unitPrice: i.unitPrice,
                    taxRate: i.taxRate,
                    discount: i.discount,
                  ))
              .toList() ??
          [],
    );
  }
}
