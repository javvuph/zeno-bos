part of '../isar_finance_repository.dart';

extension IsarFinanceRepositoryExpensesBudgetsPart on IsarFinanceRepository {
  Future<List<ExpenseEntry>> getExpensesImpl() async {
    final results = await expenseCol.where().findAll();
    return results
        .map((e) => ExpenseEntry(
              id: e.uuid,
              employeeId: e.employeeId,
              date: e.date,
              category: ExpenseCategory.values.firstWhere(
                  (c) => c.name == e.category,
                  orElse: () => ExpenseCategory.other),
              amount: e.amount,
              taxAmount: e.taxAmount,
              currency: e.currency,
              description: e.description,
              receiptUrl: e.receiptUrl,
              claimId: e.claimId,
              departmentId: e.departmentId,
              status: ExpenseStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => ExpenseStatus.draft),
            ))
        .toList();
  }

  Future<void> saveExpenseImpl(ExpenseEntry expense) async {
    final existing =
        await expenseCol.filter().uuidEqualTo(expense.id).findFirst();
    final entry = (existing ?? ExpenseCollection())
      ..uuid = expense.id
      ..employeeId = expense.employeeId
      ..date = expense.date
      ..category = expense.category.name
      ..amount = expense.amount
      ..taxAmount = expense.taxAmount
      ..currency = expense.currency
      ..description = expense.description
      ..receiptUrl = expense.receiptUrl
      ..claimId = expense.claimId
      ..departmentId = expense.departmentId;

    await db.isar.writeTxn(() async {
      await expenseCol.put(entry);
    });
  }

  Future<List<ExpenseClaim>> getExpenseClaimsImpl() async {
    final results = await claimCol.where().findAll();
    return results
        .map((e) => ExpenseClaim(
              id: e.uuid,
              employeeId: e.employeeId,
              title: e.title,
              submissionDate: e.submissionDate,
              entries: [], // Needs deep loading in real app
              status: ExpenseStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => ExpenseStatus.draft),
              totalAmount: e.totalAmount,
              approvedById: e.approvedById,
            ))
        .toList();
  }

  Future<void> saveExpenseClaimImpl(ExpenseClaim claim) async {
    final existing = await claimCol.filter().uuidEqualTo(claim.id).findFirst();
    final entry = (existing ?? ExpenseClaimCollection())
      ..uuid = claim.id
      ..employeeId = claim.employeeId
      ..title = claim.title
      ..submissionDate = claim.submissionDate
      ..status = claim.status.name
      ..totalAmount = claim.totalAmount
      ..approvedById = claim.approvedById;

    await db.isar.writeTxn(() async {
      await claimCol.put(entry);
    });
  }

  Future<List<Budget>> getBudgetsImpl() async {
    final results = await budgetCol.where().findAll();
    return results
        .map((e) => Budget(
              id: e.uuid,
              code: e.code,
              name: e.name,
              fiscalYearId: e.fiscalYearId,
              costCenterId: e.costCenterId,
              departmentId: e.departmentId,
              projectId: e.projectId,
              allocatedAmount: e.allocatedAmount,
              utilizedAmount: e.utilizedAmount,
              status: BudgetStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => BudgetStatus.draft),
              ownerId: e.ownerId,
              createdAt: DateTime.now(),
            ))
        .toList();
  }

  Future<void> saveBudgetImpl(Budget budget) async {
    final existing =
        await budgetCol.filter().uuidEqualTo(budget.id).findFirst();
    final entry = (existing ?? BudgetCollection())
      ..uuid = budget.id
      ..code = budget.code
      ..name = budget.name
      ..fiscalYearId = budget.fiscalYearId
      ..costCenterId = budget.costCenterId
      ..departmentId = budget.departmentId
      ..projectId = budget.projectId
      ..allocatedAmount = budget.allocatedAmount
      ..utilizedAmount = budget.utilizedAmount
      ..status = budget.status.name
      ..ownerId = budget.ownerId;

    await db.isar.writeTxn(() async {
      await budgetCol.put(entry);
    });
  }

  Future<List<CostCenter>> getCostCentersImpl() async {
    final results = await ccCol.where().findAll();
    return results
        .map((e) => CostCenter(
              id: e.uuid,
              code: e.code,
              name: e.name,
              type: CostCenterType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => CostCenterType.costCenter),
              parentId: e.parentId,
              managerId: e.managerId,
              isActive: e.isActive,
            ))
        .toList();
  }

  Future<void> saveCostCenterImpl(CostCenter costCenter) async {
    final existing =
        await ccCol.filter().uuidEqualTo(costCenter.id).findFirst();
    final entry = (existing ?? CostCenterCollection())
      ..uuid = costCenter.id
      ..code = costCenter.code
      ..name = costCenter.name
      ..type = costCenter.type.name
      ..parentId = costCenter.parentId
      ..managerId = costCenter.managerId
      ..isActive = costCenter.isActive;

    await db.isar.writeTxn(() async {
      await ccCol.put(entry);
    });
  }
}
