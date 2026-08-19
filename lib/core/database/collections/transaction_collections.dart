import 'package:isar/isar.dart';

part 'transaction_collections.g.dart';

@collection
class PurchaseOrderCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String orderNumber;

  @Index()
  late String supplierId;

  @Index()
  late String buyerId;

  @Index()
  late DateTime date;

  late DateTime? expectedDeliveryDate;

  @Index()
  late String
      status; // draft, pendingApproval, approved, ordered, partiallyReceived, received, cancelled, closed

  late String approvalStatus;

  late String warehouseId;
  late String branchId;

  late double totalAmount;
  late double totalTax;
  late String currency;
  late double exchangeRate;

  late int priority;

  List<TransactionItem>? items;
  List<String> auditTrail = [];

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
}

@collection
class PurchaseRequisitionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String requestedById;

  @Index()
  late DateTime requestedDate;

  @Index()
  late String status;

  List<TransactionItem>? items;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
}

@collection
class RFQCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late DateTime expiryDate;

  @Index()
  late String status;

  List<String>? supplierIds;
  List<TransactionItem>? items;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
}

@collection
class SupplierQuotationCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String rfqId;

  @Index()
  late String supplierId;

  @Index()
  late String quotationNumber;

  @Index()
  late DateTime quotationDate;

  late double totalAmount;
  late String currency;
  late bool isSelected;
  late String status;
  late int revision;

  List<TransactionItem>? items;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
}

@collection
class GRNCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String poId;

  @Index()
  late String supplierId;

  @Index()
  late String warehouseId;

  @Index()
  late DateTime receivedDate;

  @Index()
  late String status;

  List<GRNItemEmbedded>? items;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
}

@embedded
class GRNItemEmbedded {
  late String productId;
  String? variantId;
  late String name;
  late double quantityOrdered;
  late double quantityReceived;
  late double quantityAccepted;
  late double quantityRejected;
  String? batchId;
  List<String>? serialNumbers;
}

@embedded
class TransactionItem {
  late String productId;
  String? variantId;
  late String sku;
  late String description;
  late double quantity;
  late double fulfilledQuantity;
  late double unitPrice;
  late double taxRate;
  double? discount;
  late double subtotal;
}

@embedded
class PaymentEmbedded {
  String? transactionId;
  late String method;
  late double amount;
  late DateTime timestamp;
  late String status;
}

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
