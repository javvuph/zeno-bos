enum CostCenterType { department, project, costCenter, profitCenter }

class CostCenter {
  final String id;
  final String code;
  final String name;
  final CostCenterType type;
  final String? parentId;
  final String managerId;
  final bool isActive;

  const CostCenter({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    this.parentId,
    required this.managerId,
    this.isActive = true,
  });
}
