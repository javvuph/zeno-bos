part of '../transaction_collections.dart';

@collection
class SalesOrderCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String orderNumber;

  @Index()
  late String customerId;

  String? quotationId;

  @Index()
  late String warehouseId;

  @Index()
  late DateTime date;

  @Index()
  late String status;

  late double totalAmount;
  late double subTotal;
  late double totalDiscount;
  late double totalTax;
  late String currency;
  late double exchangeRate;

  DateTime? expectedDeliveryDate;
  String? shippingAddressId;
  String? billingAddressId;
  String? representativeId;
  String? branchId;
  String? companyId;

  List<TransactionItem>? items;
  List<PaymentEmbedded>? payments;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

@collection
class InvoiceCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String invoiceNumber;

  @Index()
  late String orderId;

  @Index()
  late DateTime date;

  @Index()
  late DateTime dueDate;

  @Index()
  late String status; // unpaid, partially_paid, paid, overdue

  late double totalAmount;
  late double balanceDue;

  bool isDeleted = false;
}

@collection
class QuotationCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String quotationNumber;

  @Index()
  late String customerId;

  String? opportunityId;
  late double subTotal;
  late double totalDiscount;
  late double totalTax;
  late double grandTotal;
  late String status;
  late int revision;
  late DateTime expiryDate;
  String? representativeId;
  String? branchId;
  String? companyId;
  DateTime createdAt = DateTime.now();

  List<TransactionItem>? items;
}

@collection
class OpportunityCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String title;

  @Index()
  late String customerId;

  late double expectedRevenue;
  late double probability;
  late String stage;
  late DateTime expectedCloseDate;
  String? leadSource;
  String? competitorName;
  String? lostReason;
  String? representativeId;
  DateTime createdAt = DateTime.now();
}
