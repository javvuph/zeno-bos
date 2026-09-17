part of '../isar_purchase_repository.dart';

extension IsarPurchaseRepositoryGrnInvoicePart on IsarPurchaseRepository {
  Future<List<GRN>> getGRNsImpl() async {
    final col = db.isar.collection<GRNCollection>();
    final results = await col.where().findAll();
    return results
        .map<GRN>((e) => GRN(
              id: e.uuid,
              poId: e.poId,
              supplierId: e.supplierId,
              warehouseId: e.warehouseId,
              branchId: 'B-NORTH',
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

  Future<void> saveGRNImpl(GRN grn) async {
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

  Future<List<PurchaseInvoice>> getInvoicesImpl() async {
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

  Future<void> saveInvoiceImpl(PurchaseInvoice invoice) async {
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
