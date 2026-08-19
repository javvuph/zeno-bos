class Company {
  final String id;
  final String name;
  final String taxId;
  final String gst;
  final String pan;
  final String address;
  final String logoUrl;
  final String website;
  final String currency;
  final String timezone;
  final String financialYear; // e.g. "April - March"
  final String businessHours;
  final Map<String, dynamic> preferences;
  final bool isDefault;

  const Company({
    required this.id,
    required this.name,
    required this.taxId,
    this.gst = '',
    this.pan = '',
    this.address = '',
    this.logoUrl = '',
    this.website = '',
    this.currency = 'USD',
    this.timezone = 'UTC',
    this.financialYear = 'Jan - Dec',
    this.businessHours = '09:00 - 18:00',
    this.preferences = const {},
    this.isDefault = false,
  });
}

class Branch {
  final String id;
  final String companyId;
  final String name;
  final String code;
  final String address;
  final String phone;
  final String? costCenterId;
  final List<String> departmentIds;
  final List<String> terminalIds;
  final List<String> warehouseIds;
  final bool isActive;

  const Branch({
    required this.id,
    required this.companyId,
    required this.name,
    required this.code,
    required this.address,
    required this.phone,
    this.costCenterId,
    this.departmentIds = const [],
    this.terminalIds = const [],
    this.warehouseIds = const [],
    this.isActive = true,
  });
}

class CostCenter {
  final String id;
  final String name;
  final String code;
  final String? parentId;

  const CostCenter(
      {required this.id,
      required this.name,
      required this.code,
      this.parentId});
}

class Department {
  final String id;
  final String name;
  final String code;

  const Department({required this.id, required this.name, required this.code});
}

class Terminal {
  final String id;
  final String branchId;
  final String name;
  final String macAddress;

  const Terminal(
      {required this.id,
      required this.branchId,
      required this.name,
      required this.macAddress});
}

class GlobalWarehouse {
  final String id;
  final String branchId;
  final String name;
  final String code;
  final bool isMain;

  const GlobalWarehouse({
    required this.id,
    required this.branchId,
    required this.name,
    required this.code,
    this.isMain = false,
  });
}
