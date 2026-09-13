import 'package:isar/isar.dart';

part 'crm_collections.g.dart';

@collection
class CustomerCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String customerCode;

  late String type; // individual, business, walkIn, corporate

  @Index(caseSensitive: false)
  late String name;

  String? companyName;
  String? taxId;

  @Index(unique: true)
  late String email;

  @Index(unique: true)
  late String phone;

  String? whatsapp;

  late String tier;
  String? categoryId;
  String? segmentId;
  String? territoryId;
  String? salesRepId;
  List<String> groupIds = [];

  List<CustomerAddressEmbedded>? addresses;
  List<CustomerContactEmbedded>? contacts;

  double outstandingBalance = 0.0;
  double creditLimit = 0.0;
  bool isCreditBlocked = false;

  int loyaltyPoints = 0;
  double lifetimeSpent = 0.0;

  String? aiProfileJson; // JSON blob for scores
  List<String> tags = [];

  String? branchId;
  String? companyId;

  @Index()
  bool isDeleted = false;

  DateTime? lastPurchaseAt;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

@embedded
class CustomerAddressEmbedded {
  late String uuid;
  late String label;
  late String addressLine1;
  String? addressLine2;
  late String city;
  late String state;
  late String zipCode;
  late String country;
  late String type;
  late bool isDefault;
}

@embedded
class CustomerContactEmbedded {
  late String uuid;
  late String name;
  late String role;
  late String email;
  late String phone;
  late bool isPrimary;
}

@collection
class CustomerGroupCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  String? parentId;
  String? description;
  String? color;
}

@collection
class CustomerCategoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String code;

  late String name;
}

@collection
class SalesTerritoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String code;

  late String name;
  late String region;
  String? parentId;
}

@collection
class CustomerInteractionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String customerId;

  late String type;
  late String summary;
  String? details;
  late DateTime timestamp;
  late String userId;
}

@collection
class LeadCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  String? companyName;

  @Index()
  late String email;

  @Index()
  late String phone;

  String? source;
  late String status;
  late double score;
  String? representativeId;
  String? territoryId;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  String? aiInsightsJson;
}

@collection
class ActivityCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String title;
  String? description;
  late String type;
  late String priority;
  late String status;

  @Index()
  late DateTime scheduledAt;

  DateTime? completedAt;

  @Index()
  late String assignedToId;

  @Index()
  String? customerId;

  String? leadId;
  String? opportunityId;
  String? ticketId;
  String? salesOrderId;
  late bool reminderEnabled;
  DateTime? reminderAt;
}

@collection
class CampaignCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String title;

  String? description;
  late String type;
  late String status;
  late double budget;
  late double actualCost;
  late double expectedRevenue;
  late int audienceCount;
  late int conversionCount;

  @Index()
  late DateTime startDate;

  DateTime? endDate;
  List<String> targetSegments = [];
  String? analyticsJson;
}

@collection
class TicketCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String ticketNumber;

  late String subject;
  String? description;

  @Index()
  late String customerId;

  late String priority;
  late String status;
  late String category;
  String? assignedToId;
  DateTime createdAt = DateTime.now();
  DateTime? resolvedAt;
  late DateTime slaDeadline;
  late bool isSlaBreached;
  List<String> resolutionNotes = [];
}

@collection
class SupplierCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String supplierCode;

  late String type;

  @Index(caseSensitive: false)
  late String name;

  String? legalName;
  late String category;

  @Index(unique: true)
  late String email;

  @Index(unique: true)
  late String phone;

  late String currency;
  String? address;
  String? city;

  bool isPreferred = false;
  double creditLimit = 0.0;
  int averageLeadTime = 0;
  double ratingScore = 0.0;

  @Index()
  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}
