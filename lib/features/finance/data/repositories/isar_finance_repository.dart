import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/finance_collections.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/account.dart';
import '../../domain/models/journal_entry.dart';
import '../../domain/models/journal_line.dart';
import '../../domain/models/fiscal_year.dart';
import '../../domain/models/fiscal_period.dart';
import '../../domain/models/accounts_payable.dart';
import '../../domain/models/payment.dart';
import '../../domain/models/payment_status.dart';
import '../../domain/models/bank_account.dart';
import '../../domain/models/bank_transaction.dart';
import '../../domain/models/expense_entry.dart';
import '../../domain/models/expense_claim.dart';
import '../../domain/models/expense_status.dart';
import '../../domain/models/budget.dart';
import '../../domain/models/cost_center.dart';
import '../../domain/models/fixed_asset.dart';
import '../../domain/models/asset_status.dart';
import '../../domain/models/asset_maintenance.dart';
import '../../domain/models/tax_rule.dart';
import '../../domain/models/tax_return.dart';
import '../../domain/models/closing_task.dart';
import 'package:isar/isar.dart';

class IsarFinanceRepository implements IFinanceRepository {
  final DatabaseService db;
  IsarFinanceRepository(this.db);

  IsarCollection<AccountCollection> get accCol =>
      db.isar.collection<AccountCollection>();
  IsarCollection<JournalEntryCollection> get journalCol =>
      db.isar.collection<JournalEntryCollection>();
  IsarCollection<AccountsPayableCollection> get payableCol =>
      db.isar.collection<AccountsPayableCollection>();
  IsarCollection<PaymentCollection> get paymentCol =>
      db.isar.collection<PaymentCollection>();
  IsarCollection<BankTransactionCollection> get bankTxCol =>
      db.isar.collection<BankTransactionCollection>();
  IsarCollection<BankAccountCollection> get bankAccCol =>
      db.isar.collection<BankAccountCollection>();
  IsarCollection<ExpenseCollection> get expenseCol =>
      db.isar.collection<ExpenseCollection>();
  IsarCollection<ExpenseClaimCollection> get claimCol =>
      db.isar.collection<ExpenseClaimCollection>();
  IsarCollection<BudgetCollection> get budgetCol =>
      db.isar.collection<BudgetCollection>();
  IsarCollection<CostCenterCollection> get ccCol =>
      db.isar.collection<CostCenterCollection>();
  IsarCollection<FixedAssetCollection> get assetCol =>
      db.isar.collection<FixedAssetCollection>();
  IsarCollection<AssetMaintenanceCollection> get maintenanceCol =>
      db.isar.collection<AssetMaintenanceCollection>();
  IsarCollection<TaxRuleCollection> get taxRuleCol =>
      db.isar.collection<TaxRuleCollection>();
  IsarCollection<TaxReturnCollection> get taxReturnCol =>
      db.isar.collection<TaxReturnCollection>();
  IsarCollection<ClosingTaskCollection> get closingTaskCol =>
      db.isar.collection<ClosingTaskCollection>();
  IsarCollection<FiscalPeriodCollection> get periodCol =>
      db.isar.collection<FiscalPeriodCollection>();

  @override
  Future<List<Account>> getChartOfAccounts() async {
    final results = await accCol.where().findAll();
    return results
        .map((e) => Account(
              id: e.uuid,
              code: e.code,
              name: e.name,
              category: AccountCategory.values.firstWhere(
                  (c) => c.name == e.category,
                  orElse: () => AccountCategory.asset),
              type: AccountType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => AccountType.cash),
              parentId: e.parentId,
              currency: e.currency,
              isActive: e.isActive,
              isSystemAccount: e.isSystemAccount,
              currentBalance: e.currentBalance,
            ))
        .toList();
  }

  @override
  Future<void> saveAccount(Account account) async {
    final existing = await accCol.filter().uuidEqualTo(account.id).findFirst();
    final a = (existing ?? AccountCollection())
      ..uuid = account.id
      ..code = account.code
      ..name = account.name
      ..category = account.category.name
      ..type = account.type.name
      ..currency = account.currency
      ..parentId = account.parentId
      ..isActive = account.isActive
      ..isSystemAccount = account.isSystemAccount;

    await db.isar.writeTxn(() async {
      await accCol.put(a);
    });
  }

  @override
  Future<void> postJournalEntry(JournalEntry entry) async {
    final j = JournalEntryCollection()
      ..uuid = entry.id
      ..referenceNumber = entry.referenceNumber
      ..date = entry.date
      ..description = entry.description
      ..status = entry.status.name
      ..sourceModule = entry.sourceModule
      ..sourceDocumentId = entry.sourceDocumentId
      ..lines = entry.lines
          .map((l) => JournalLineEmbedded()
            ..accountId = l.accountId
            ..debit = l.debit
            ..credit = l.credit
            ..memo = l.memo)
          .toList();

    await db.isar.writeTxn(() async {
      await journalCol.put(j);

      // Update account balances
      for (var line in entry.lines) {
        final acc =
            await accCol.filter().uuidEqualTo(line.accountId).findFirst();
        if (acc != null) {
          acc.currentBalance += (line.debit - line.credit);
          await accCol.put(acc);
        }
      }
    });
  }

  @override
  Future<List<JournalEntry>> getLedgerEntries(
      String accountId, DateTime start, DateTime end) async {
    final results = await journalCol
        .filter()
        .dateBetween(start, end)
        .and()
        .linesElement((q) => q.accountIdEqualTo(accountId))
        .findAll();

    return results
        .map((e) => JournalEntry(
              id: e.uuid,
              referenceNumber: e.referenceNumber,
              date: e.date,
              description: e.description,
              createdById: 'admin',
              sourceModule: e.sourceModule,
              sourceDocumentId: e.sourceDocumentId,
              status: JournalEntryStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => JournalEntryStatus.posted),
              lines: e.lines
                      ?.map((l) => JournalLine(
                            accountId: l.accountId,
                            debit: l.debit,
                            credit: l.credit,
                            memo: l.memo,
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  @override
  Future<List<JournalEntry>> getAllJournalEntries() async {
    final results = await journalCol.where().findAll();
    return results
        .map((e) => JournalEntry(
              id: e.uuid,
              referenceNumber: e.referenceNumber,
              date: e.date,
              description: e.description,
              createdById: 'admin',
              sourceModule: e.sourceModule,
              sourceDocumentId: e.sourceDocumentId,
              status: JournalEntryStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => JournalEntryStatus.posted),
              lines: e.lines
                      ?.map((l) => JournalLine(
                            accountId: l.accountId,
                            debit: l.debit,
                            credit: l.credit,
                            memo: l.memo,
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  @override
  Future<List<FiscalYear>> getFiscalYears() async => [];

  @override
  Future<void> closeFiscalYear(String id) async {}

  @override
  Future<List<FiscalPeriod>> getFiscalPeriods() async {
    final results = await periodCol.where().findAll();
    return results
        .map((e) => FiscalPeriod(
              id: e.uuid,
              name: e.name,
              startDate: e.startDate,
              endDate: e.endDate,
              status: FiscalPeriodStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => FiscalPeriodStatus.open),
              isAdjustmentPeriod: e.isAdjustmentPeriod,
            ))
        .toList();
  }

  @override
  Future<void> updatePeriodStatus(
      String periodId, FiscalPeriodStatus status) async {
    final existing = await periodCol.filter().uuidEqualTo(periodId).findFirst();
    if (existing != null) {
      existing.status = status.name;
      await db.isar.writeTxn(() async {
        await periodCol.put(existing);
      });
    }
  }

  @override
  Future<double> getAccountBalance(String accountId) async {
    final acc = await accCol.filter().uuidEqualTo(accountId).findFirst();
    return acc?.currentBalance ?? 0.0;
  }

  @override
  Future<List<AccountsPayable>> getAccountsPayable() async {
    final results = await payableCol.where().findAll();
    return results
        .map((e) => AccountsPayable(
              id: e.uuid,
              supplierId: e.supplierId,
              vendorBillId: e.vendorBillId,
              invoiceNumber: e.invoiceNumber,
              amount: e.amount,
              dueDate: e.dueDate,
              status: PaymentStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => PaymentStatus.pending),
            ))
        .toList();
  }

  @override
  Future<void> saveAccountsPayable(AccountsPayable payable) async {
    final existing =
        await payableCol.filter().uuidEqualTo(payable.id).findFirst();
    final entry = (existing ?? AccountsPayableCollection())
      ..uuid = payable.id
      ..supplierId = payable.supplierId
      ..vendorBillId = payable.vendorBillId
      ..invoiceNumber = payable.invoiceNumber
      ..amount = payable.amount
      ..dueDate = payable.dueDate
      ..status = payable.status.name;

    await db.isar.writeTxn(() async {
      await payableCol.put(entry);
    });
  }

  @override
  Future<List<Payment>> getPayments() async {
    final results = await paymentCol.where().findAll();
    return results
        .map((e) => Payment(
              id: e.uuid,
              payableId: e.payableId,
              supplierId: '', // Mocked
              amount: e.amount,
              currency: 'USD',
              method: PaymentMethod.values.firstWhere((m) => m.name == e.method,
                  orElse: () => PaymentMethod.bankTransfer),
              paymentDate: e.paymentDate,
            ))
        .toList();
  }

  @override
  Future<void> savePayment(Payment payment) async {
    final entry =
        (await paymentCol.filter().uuidEqualTo(payment.id).findFirst()) ??
            PaymentCollection();
    entry.uuid = payment.id;
    entry.payableId = payment.payableId;
    entry.amount = payment.amount;
    entry.paymentDate = payment.paymentDate;
    entry.method = payment.method.name;

    await db.isar.writeTxn(() async {
      await paymentCol.put(entry);
    });
  }

  @override
  Future<List<BankAccount>> getBankAccounts() async {
    final results = await bankAccCol.where().findAll();
    return results
        .map((e) => BankAccount(
              id: e.uuid,
              name: e.name,
              accountNumber: e.accountNumber,
              bankName: e.bankName,
              branchName: e.branchName,
              type: BankAccountType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => BankAccountType.current),
              currency: e.currency,
              currentBalance: e.currentBalance,
              availableBalance: e.availableBalance,
              isActive: e.isActive,
              swiftCode: e.swiftCode,
              ifscCode: e.ifscCode,
            ))
        .toList();
  }

  @override
  Future<void> saveBankAccount(BankAccount account) async {
    final existing =
        await bankAccCol.filter().uuidEqualTo(account.id).findFirst();
    final a = (existing ?? BankAccountCollection())
      ..uuid = account.id
      ..name = account.name
      ..accountNumber = account.accountNumber
      ..bankName = account.bankName
      ..branchName = account.branchName
      ..type = account.type.name
      ..currency = account.currency
      ..currentBalance = account.currentBalance
      ..availableBalance = account.availableBalance
      ..isActive = account.isActive
      ..swiftCode = account.swiftCode
      ..ifscCode = account.ifscCode;

    await db.isar.writeTxn(() async {
      await bankAccCol.put(a);
    });
  }

  @override
  Future<List<BankTransaction>> getBankTransactions(String accountId) async {
    final results =
        await bankTxCol.filter().bankAccountIdEqualTo(accountId).findAll();
    return results
        .map((e) => BankTransaction(
              id: e.uuid,
              bankAccountId: e.bankAccountId,
              date: e.date,
              description: e.description,
              amount: e.amount,
              type: BankTransactionType.values.firstWhere(
                  (t) => t.name == e.type,
                  orElse: () => BankTransactionType.deposit),
              status: BankTransactionStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => BankTransactionStatus.cleared),
              referenceNumber: e.referenceNumber,
              counterPartyName: e.counterPartyName,
            ))
        .toList();
  }

  @override
  Future<void> recordBankTransaction(BankTransaction transaction) async {
    final existing =
        await bankTxCol.filter().uuidEqualTo(transaction.id).findFirst();
    final tx = (existing ?? BankTransactionCollection())
      ..uuid = transaction.id
      ..bankAccountId = transaction.bankAccountId
      ..date = transaction.date
      ..description = transaction.description
      ..amount = transaction.amount
      ..type = transaction.type.name
      ..status = transaction.status.name
      ..referenceNumber = transaction.referenceNumber
      ..counterPartyName = transaction.counterPartyName;

    await db.isar.writeTxn(() async {
      await bankTxCol.put(tx);
    });
  }

  @override
  Future<List<ExpenseEntry>> getExpenses() async {
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

  @override
  Future<void> saveExpense(ExpenseEntry expense) async {
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

  @override
  Future<List<ExpenseClaim>> getExpenseClaims() async {
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

  @override
  Future<void> saveExpenseClaim(ExpenseClaim claim) async {
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

  @override
  Future<List<Budget>> getBudgets() async {
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

  @override
  Future<void> saveBudget(Budget budget) async {
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

  @override
  Future<List<CostCenter>> getCostCenters() async {
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

  @override
  Future<void> saveCostCenter(CostCenter costCenter) async {
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

  @override
  Future<List<FixedAsset>> getFixedAssets() async {
    final results = await assetCol.where().findAll();
    return results
        .map((e) => FixedAsset(
              id: e.uuid,
              assetCode: e.assetCode,
              name: e.name,
              categoryId: e.categoryId,
              groupId: e.groupId,
              acquisitionDate: e.acquisitionDate,
              purchaseValue: e.purchaseValue,
              currentBookValue: e.currentBookValue,
              residualValue: e.residualValue,
              depreciationMethod: DepreciationMethod.values.firstWhere(
                  (m) => m.name == e.depreciationMethod,
                  orElse: () => DepreciationMethod.straightLine),
              usefulLifeMonths: e.usefulLifeMonths,
              locationId: e.locationId,
              custodianId: e.custodianId,
              status: AssetStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => AssetStatus.active),
              insurancePolicyNumber: e.insurancePolicyNumber,
              insuranceExpiry: e.insuranceExpiry,
              warrantyExpiry: e.warrantyExpiry,
              isCapitalized: e.isCapitalized,
              capitalizationDate: e.capitalizationDate,
            ))
        .toList();
  }

  @override
  Future<void> saveFixedAsset(FixedAsset asset) async {
    final existing = await assetCol.filter().uuidEqualTo(asset.id).findFirst();
    final entry = (existing ?? FixedAssetCollection())
      ..uuid = asset.id
      ..assetCode = asset.assetCode
      ..name = asset.name
      ..categoryId = asset.categoryId
      ..groupId = asset.groupId
      ..acquisitionDate = asset.acquisitionDate
      ..purchaseValue = asset.purchaseValue
      ..currentBookValue = asset.currentBookValue
      ..residualValue = asset.residualValue
      ..depreciationMethod = asset.depreciationMethod.name
      ..usefulLifeMonths = asset.usefulLifeMonths
      ..locationId = asset.locationId
      ..custodianId = asset.custodianId
      ..status = asset.status.name
      ..insurancePolicyNumber = asset.insurancePolicyNumber
      ..insuranceExpiry = asset.insuranceExpiry
      ..warrantyExpiry = asset.warrantyExpiry
      ..isCapitalized = asset.isCapitalized
      ..capitalizationDate = asset.capitalizationDate;

    await db.isar.writeTxn(() async {
      await assetCol.put(entry);
    });
  }

  @override
  Future<List<AssetMaintenance>> getAssetMaintenance(String assetId) async {
    final results =
        await maintenanceCol.filter().assetIdEqualTo(assetId).findAll();
    return results
        .map((e) => AssetMaintenance(
              id: e.uuid,
              assetId: e.assetId,
              maintenanceDate: e.maintenanceDate,
              description: e.description,
              cost: e.cost,
              status: MaintenanceStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => MaintenanceStatus.scheduled),
              vendorName: e.vendorName,
            ))
        .toList();
  }

  @override
  Future<void> recordAssetMaintenance(AssetMaintenance maintenance) async {
    final existing =
        await maintenanceCol.filter().uuidEqualTo(maintenance.id).findFirst();
    final entry = (existing ?? AssetMaintenanceCollection())
      ..uuid = maintenance.id
      ..assetId = maintenance.assetId
      ..maintenanceDate = maintenance.maintenanceDate
      ..description = maintenance.description
      ..cost = maintenance.cost
      ..status = maintenance.status.name
      ..vendorName = maintenance.vendorName;

    await db.isar.writeTxn(() async {
      await maintenanceCol.put(entry);
    });
  }

  @override
  Future<List<TaxRule>> getTaxRules() async {
    final results = await taxRuleCol.where().findAll();
    return results
        .map((e) => TaxRule(
              id: e.uuid,
              code: e.code,
              name: e.name,
              country: e.country,
              state: e.state,
              type: TaxType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => TaxType.gst),
              category: TaxCategory.values.firstWhere(
                  (c) => c.name == e.category,
                  orElse: () => TaxCategory.custom),
              rate: e.rate,
              effectiveDate: e.effectiveDate,
              expiryDate: e.expiryDate,
              isReverseCharge: e.isReverseCharge,
            ))
        .toList();
  }

  @override
  Future<void> saveTaxRule(TaxRule rule) async {
    final existing = await taxRuleCol.filter().uuidEqualTo(rule.id).findFirst();
    final entry = (existing ?? TaxRuleCollection())
      ..uuid = rule.id
      ..code = rule.code
      ..name = rule.name
      ..country = rule.country
      ..state = rule.state
      ..type = rule.type.name
      ..category = rule.category.name
      ..rate = rule.rate
      ..effectiveDate = rule.effectiveDate
      ..expiryDate = rule.expiryDate
      ..isReverseCharge = rule.isReverseCharge;

    await db.isar.writeTxn(() async {
      await taxRuleCol.put(entry);
    });
  }

  @override
  Future<List<TaxReturn>> getTaxReturns() async {
    final results = await taxReturnCol.where().findAll();
    return results
        .map((e) => TaxReturn(
              id: e.uuid,
              periodId: e.periodId,
              type: e.type,
              filingDate: e.filingDate,
              totalTaxableValue: e.totalTaxableValue,
              totalTaxAmount: e.totalTaxAmount,
              inputTaxCredit: e.inputTaxCredit,
              status: TaxReturnStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => TaxReturnStatus.draft),
              filingReference: e.filingReference,
            ))
        .toList();
  }

  @override
  Future<void> saveTaxReturn(TaxReturn taxReturn) async {
    final existing =
        await taxReturnCol.filter().uuidEqualTo(taxReturn.id).findFirst();
    final entry = (existing ?? TaxReturnCollection())
      ..uuid = taxReturn.id
      ..periodId = taxReturn.periodId
      ..type = taxReturn.type
      ..filingDate = taxReturn.filingDate
      ..totalTaxableValue = taxReturn.totalTaxableValue
      ..totalTaxAmount = taxReturn.totalTaxAmount
      ..inputTaxCredit = taxReturn.inputTaxCredit
      ..status = taxReturn.status.name
      ..filingReference = taxReturn.filingReference;

    await db.isar.writeTxn(() async {
      await taxReturnCol.put(entry);
    });
  }

  @override
  Future<List<ClosingTask>> getClosingChecklist(String periodId) async {
    final results =
        await closingTaskCol.filter().periodIdEqualTo(periodId).findAll();
    return results
        .map((e) => ClosingTask(
              id: e.uuid,
              title: e.title,
              description: e.description,
              category: e.category,
              status: ClosingTaskStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => ClosingTaskStatus.pending),
              isMandatory: e.isMandatory,
              assignedTo: e.assignedTo,
              completedAt: e.completedAt,
            ))
        .toList();
  }

  @override
  Future<void> updateClosingTask(ClosingTask task) async {
    final existing =
        await closingTaskCol.filter().uuidEqualTo(task.id).findFirst();
    if (existing != null) {
      existing.status = task.status.name;
      existing.completedAt = task.completedAt;
      await db.isar.writeTxn(() async {
        await closingTaskCol.put(existing);
      });
    }
  }
}
