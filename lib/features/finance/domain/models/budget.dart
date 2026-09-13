enum BudgetStatus { draft, active, revised, frozen, closed }

class Budget {
  final String id;
  final String code;
  final String name;
  final String fiscalYearId;
  final String? costCenterId;
  final String? departmentId;
  final String? projectId;
  final double allocatedAmount;
  final double utilizedAmount;
  final BudgetStatus status;
  final String ownerId;
  final DateTime createdAt;

  const Budget({
    required this.id,
    required this.code,
    required this.name,
    required this.fiscalYearId,
    this.costCenterId,
    this.departmentId,
    this.projectId,
    required this.allocatedAmount,
    this.utilizedAmount = 0.0,
    this.status = BudgetStatus.draft,
    required this.ownerId,
    required this.createdAt,
  });

  double get remainingAmount => allocatedAmount - utilizedAmount;
  double get variancePercentage =>
      allocatedAmount > 0 ? (utilizedAmount / allocatedAmount) * 100 : 0.0;
  bool get isOverBudget => utilizedAmount > allocatedAmount;

  Budget copyWith({
    double? utilizedAmount,
    BudgetStatus? status,
  }) {
    return Budget(
      id: id,
      code: code,
      name: name,
      fiscalYearId: fiscalYearId,
      costCenterId: costCenterId,
      departmentId: departmentId,
      projectId: projectId,
      allocatedAmount: allocatedAmount,
      utilizedAmount: utilizedAmount ?? this.utilizedAmount,
      status: status ?? this.status,
      ownerId: ownerId,
      createdAt: createdAt,
    );
  }
}
