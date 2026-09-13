import 'package:isar/isar.dart';

part 'admin_collections.g.dart';

@collection
class CompanyCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late String taxId;
  late String gst;
  late String pan;
  late String address;
  late String currency;
  late String timezone;

  bool isDefault = false;
}

@collection
class BranchCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String companyId;

  @Index(caseSensitive: false)
  late String name;

  @Index(unique: true)
  late String code;

  late String address;
  late String phone;

  bool isActive = true;
}

@collection
class UserCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String email;

  late String displayName;
  late String status;

  List<String>? roleIds;
  List<String>? branchPermissions;
}

@collection
class RoleCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String name;

  late String description;
  bool isSystemRole = false;

  late String permissionMatrixJson; // Store List<Permission> as JSON string
}

@collection
class BusinessSettingsCollection {
  Id id = Isar.autoIncrement;

  late String currencyCode;
  late String languageCode;
  late String timeZone;
  late String environment;
  bool maintenanceMode = false;

  late double defaultSalesTax;
  late double defaultPurchaseTax;

  late String numberSeriesJson;
  late String securityPolicyJson;
  late String licenseInfoJson;
  late String featureFlagsJson;
}

@collection
class AuditLogCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String module;

  @Index()
  late DateTime timestamp;

  late String action;
  late String userId;
  late String details;
}

@collection
class SecurityLogCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late DateTime timestamp;

  late String eventType;
  late String userId;
  late String ipAddress;
  late String severity;
}
