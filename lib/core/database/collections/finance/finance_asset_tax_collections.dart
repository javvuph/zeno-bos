part of '../finance_collections.dart';

@collection
class BudgetCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String code;

  late String name;
  late String fiscalYearId;
  String? costCenterId;
  String? departmentId;
  String? projectId;
  late double allocatedAmount;
  late double utilizedAmount;
  late String status;
  late String ownerId;
}

@collection
class CostCenterCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String code;

  @Index(caseSensitive: false)
  late String name;

  late String type;
  String? parentId;
  late String managerId;
  bool isActive = true;
}

@collection
class FixedAssetCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String assetCode;

  @Index(caseSensitive: false)
  late String name;

  late String categoryId;
  late String groupId;

  @Index()
  late DateTime acquisitionDate;

  late double purchaseValue;
  late double currentBookValue;
  late double residualValue;

  late String depreciationMethod; // straight_line, wdv
  late int usefulLifeMonths;

  String? locationId;
  String? custodianId;

  @Index()
  late String status; // active, under_maintenance, disposed, written_off

  String? insurancePolicyNumber;
  DateTime? insuranceExpiry;
  DateTime? warrantyExpiry;

  late bool isCapitalized;
  DateTime? capitalizationDate;
}

@collection
class AssetMaintenanceCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String assetId;

  late DateTime maintenanceDate;
  late String description;
  late double cost;
  late String status; // scheduled, completed
  String? vendorName;
}

@collection
class TaxRuleCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String code;

  late String name;
  late String country;
  String? state;
  late String type;
  late String category;
  late double rate;
  late DateTime effectiveDate;
  DateTime? expiryDate;
  late bool isReverseCharge;
}

@collection
class TaxReturnCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String periodId;

  late String type;
  late DateTime filingDate;
  late double totalTaxableValue;
  late double totalTaxAmount;
  late double inputTaxCredit;
  late String status;
  String? filingReference;
}

@collection
class ClosingTaskCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String periodId;

  late String title;
  late String description;
  late String category;
  late String status;
  late bool isMandatory;
  String? assignedTo;
  DateTime? completedAt;
}

@collection
class FiscalPeriodCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String name;
  late DateTime startDate;
  late DateTime endDate;
  late String status;
  late bool isAdjustmentPeriod;
}
