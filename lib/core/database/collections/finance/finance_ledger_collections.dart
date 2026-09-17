part of '../finance_collections.dart';

@collection
class AccountCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String code;

  @Index(caseSensitive: false)
  late String name;

  @Index()
  late String category; // asset, liability, equity, income, expense

  @Index()
  late String type;

  String? parentId;
  late String currency;
  bool isActive = true;
  bool isSystemAccount = false;

  double currentBalance = 0.0;
}

@collection
class JournalEntryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String referenceNumber;

  @Index()
  late DateTime date;

  late String description;

  @Index()
  late String status; // draft, posted, cancelled

  late String sourceModule;
  String? sourceDocumentId;

  List<JournalLineEmbedded>? lines;

  DateTime createdAt = DateTime.now();
}

@embedded
class JournalLineEmbedded {
  late String accountId;
  late double debit;
  late double credit;
  String? costCenterId;
  String? memo;
}

@collection
class BankAccountCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  @Index(unique: true)
  late String accountNumber;

  late String bankName;
  late String branchName;
  late String type;
  late String currency;
  late double currentBalance;
  late double availableBalance;
  late bool isActive;
  String? swiftCode;
  String? ifscCode;
}

@collection
class BankTransactionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String bankAccountId;

  @Index()
  late DateTime date;

  late String description;
  late double amount;
  late String type;
  late String status;
  String? referenceNumber;
  String? counterPartyName;
}

@collection
class ExpenseCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String employeeId;

  @Index()
  late DateTime date;

  late String category;
  late double amount;
  late double taxAmount;
  late String currency;
  late String description;
  String? receiptUrl;
  String? claimId;
  String? departmentId;
  late String status;
}

@collection
class ExpenseClaimCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String employeeId;

  late String title;
  late DateTime submissionDate;
  late String status;
  late double totalAmount;
  String? approvedById;
}

@collection
class AccountsPayableCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String supplierId;

  @Index()
  late String vendorBillId;

  late String invoiceNumber;
  late double amount;
  late DateTime dueDate;

  @Index()
  late String status; // PaymentStatus
}

@collection
class PaymentCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String payableId;

  late double amount;
  late DateTime paymentDate;
  late String method;
}
