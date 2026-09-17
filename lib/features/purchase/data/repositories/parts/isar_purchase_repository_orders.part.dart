part of '../isar_purchase_repository.dart';

extension IsarPurchaseRepositoryOrdersPart on IsarPurchaseRepository {
  Future<List<PurchaseRequisition>> getRequisitionsImpl() async {
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

  Future<void> saveRequisitionImpl(PurchaseRequisition pr) async {
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

  Future<List<RFQ>> getRFQsImpl() async {
    final col = db.isar.collection<RFQCollection>();
    final results = await col.where().findAll();
    return results
        .map<RFQ>((e) => RFQ(
              id: e.uuid,
              title: e.uuid,
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

  Future<void> saveRFQImpl(RFQ rfq) async {
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

  Future<List<SupplierQuotation>> getQuotationsImpl(String rfqId) async {
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

  Future<void> saveQuotationImpl(SupplierQuotation quotation) async {
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

  Future<List<PurchaseOrder>> getPurchaseOrdersImpl() async {
    final col = db.isar.collection<PurchaseOrderCollection>();
    final results = await col.where().findAll();
    return results.map<PurchaseOrder>((e) => _toDomain(e)).toList();
  }

  Future<PurchaseOrder?> getPOByIdImpl(String id) async {
    final col = db.isar.collection<PurchaseOrderCollection>();
    final e = await col.filter().uuidEqualTo(id).findFirst();
    if (e == null) return null;
    return _toDomain(e);
  }

  Future<void> savePOImpl(PurchaseOrder po) async {
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
}
