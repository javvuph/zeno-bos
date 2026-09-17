part of '../isar_customer_repository.dart';

extension IsarCustomerRepositoryPipelinePart on IsarCustomerRepository {
  Future<List<Quotation>> getQuotationsImpl() async {
    final results = await quoteCol.where().findAll();
    return results
        .map((e) => Quotation(
              id: e.uuid,
              quotationNumber: e.quotationNumber,
              customerId: e.customerId,
              opportunityId: e.opportunityId,
              items: e.items
                      ?.map((i) => QuotationItem(
                            id: '',
                            productId: i.productId,
                            sku: i.sku,
                            name: i.description,
                            quantity: i.quantity,
                            unitPrice: i.unitPrice,
                            totalAmount: i.subtotal,
                          ))
                      .toList() ??
                  <QuotationItem>[],
              subTotal: e.subTotal,
              totalDiscount: e.totalDiscount,
              totalTax: e.totalTax,
              grandTotal: e.grandTotal,
              status: QuotationStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => QuotationStatus.draft),
              revision: e.revision,
              expiryDate: e.expiryDate,
              representativeId: e.representativeId,
              branchId: e.branchId,
              companyId: e.companyId,
              createdAt: e.createdAt,
            ))
        .toList();
  }

  Future<void> saveQuotationImpl(Quotation quotation) async {
    final existing =
        await quoteCol.filter().uuidEqualTo(quotation.id).findFirst();
    final entry = (existing ?? QuotationCollection())
      ..uuid = quotation.id
      ..quotationNumber = quotation.quotationNumber
      ..customerId = quotation.customerId
      ..opportunityId = quotation.opportunityId
      ..subTotal = quotation.subTotal
      ..totalDiscount = quotation.totalDiscount
      ..totalTax = quotation.totalTax
      ..grandTotal = quotation.grandTotal
      ..status = quotation.status.name
      ..revision = quotation.revision
      ..expiryDate = quotation.expiryDate
      ..representativeId = quotation.representativeId
      ..branchId = quotation.branchId
      ..companyId = quotation.companyId
      ..createdAt = quotation.createdAt
      ..items = quotation.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..sku = i.sku
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = 0.0
            ..unitPrice = i.unitPrice
            ..taxRate = 0.0
            ..subtotal = i.totalAmount)
          .toList();

    await db.isar.writeTxn(() async {
      await quoteCol.put(entry);
    });
  }

  Future<List<Opportunity>> getOpportunitiesImpl() async {
    final results = await oppCol.where().findAll();
    return results
        .map((e) => Opportunity(
              id: e.uuid,
              title: e.title,
              customerId: e.customerId,
              expectedRevenue: e.expectedRevenue,
              probability: e.probability,
              stage: OpportunityStage.values.firstWhere(
                  (s) => s.name == e.stage,
                  orElse: () => OpportunityStage.prospecting),
              expectedCloseDate: e.expectedCloseDate,
              leadSource: e.leadSource,
              competitorName: e.competitorName,
              lostReason: e.lostReason,
              representativeId: e.representativeId,
              createdAt: e.createdAt,
            ))
        .toList();
  }

  Future<void> saveOpportunityImpl(Opportunity opportunity) async {
    final existing =
        await oppCol.filter().uuidEqualTo(opportunity.id).findFirst();
    final entry = (existing ?? OpportunityCollection())
      ..uuid = opportunity.id
      ..title = opportunity.title
      ..customerId = opportunity.customerId
      ..expectedRevenue = opportunity.expectedRevenue
      ..probability = opportunity.probability
      ..stage = opportunity.stage.name
      ..expectedCloseDate = opportunity.expectedCloseDate
      ..leadSource = opportunity.leadSource
      ..competitorName = opportunity.competitorName
      ..lostReason = opportunity.lostReason
      ..representativeId = opportunity.representativeId
      ..createdAt = opportunity.createdAt;

    await db.isar.writeTxn(() async {
      await oppCol.put(entry);
    });
  }

  Future<List<SalesOrder>> getSalesOrdersImpl() async {
    final results = await orderCol.where().findAll();
    return results
        .map((e) => SalesOrder(
              id: e.uuid,
              orderNumber: e.orderNumber,
              customerId: e.customerId,
              quotationId: e.quotationId,
              items: e.items
                      ?.map((i) => SalesOrderItem(
                            id: '',
                            productId: i.productId,
                            sku: i.sku,
                            name: i.description,
                            quantity: i.quantity,
                            fulfilledQuantity: i.fulfilledQuantity,
                            unitPrice: i.unitPrice,
                            totalAmount: i.subtotal,
                          ))
                      .toList() ??
                  <SalesOrderItem>[],
              subTotal: e.subTotal,
              totalDiscount: e.totalDiscount,
              totalTax: e.totalTax,
              grandTotal: e.totalAmount,
              status: SalesOrderStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => SalesOrderStatus.draft),
              orderDate: e.date,
              expectedDeliveryDate: e.expectedDeliveryDate,
              shippingAddressId: e.shippingAddressId,
              billingAddressId: e.billingAddressId,
              representativeId: e.representativeId,
              branchId: e.branchId,
              companyId: e.companyId,
            ))
        .toList();
  }

  Future<void> saveSalesOrderImpl(SalesOrder order) async {
    final existing = await orderCol.filter().uuidEqualTo(order.id).findFirst();
    final entry = (existing ?? SalesOrderCollection())
      ..uuid = order.id
      ..orderNumber = order.orderNumber
      ..customerId = order.customerId
      ..quotationId = order.quotationId
      ..subTotal = order.subTotal
      ..totalDiscount = order.totalDiscount
      ..totalTax = order.totalTax
      ..totalAmount = order.grandTotal
      ..status = order.status.name
      ..date = order.orderDate
      ..expectedDeliveryDate = order.expectedDeliveryDate
      ..shippingAddressId = order.shippingAddressId
      ..billingAddressId = order.billingAddressId
      ..representativeId = order.representativeId
      ..branchId = order.branchId
      ..companyId = order.companyId
      ..warehouseId = 'MAIN-WH'
      ..currency = 'USD'
      ..exchangeRate = 1.0
      ..updatedAt = DateTime.now()
      ..items = order.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..sku = i.sku
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = i.fulfilledQuantity
            ..unitPrice = i.unitPrice
            ..taxRate = 0.0
            ..subtotal = i.totalAmount)
          .toList();

    await db.isar.writeTxn(() async {
      await orderCol.put(entry);
    });
  }
}
