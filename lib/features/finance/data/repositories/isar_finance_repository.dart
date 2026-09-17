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

part 'parts/isar_finance_repository_ledger.part.dart';
part 'parts/isar_finance_repository_payables_bank.part.dart';
part 'parts/isar_finance_repository_expenses_budgets.part.dart';
part 'parts/isar_finance_repository_assets_tax.part.dart';

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
  Future<List<Account>> getChartOfAccounts() => getChartOfAccountsImpl();

  @override
  Future<void> saveAccount(Account account) => saveAccountImpl(account);

  @override
  Future<void> postJournalEntry(JournalEntry entry) => postJournalEntryImpl(entry);

  @override
  Future<List<JournalEntry>> getLedgerEntries(
          String accountId, DateTime start, DateTime end) =>
      getLedgerEntriesImpl(accountId, start, end);

  @override
  Future<List<JournalEntry>> getAllJournalEntries() => getAllJournalEntriesImpl();

  @override
  Future<List<FiscalYear>> getFiscalYears() async => [];

  @override
  Future<void> closeFiscalYear(String id) async {}

  @override
  Future<List<FiscalPeriod>> getFiscalPeriods() => getFiscalPeriodsImpl();

  @override
  Future<void> updatePeriodStatus(
          String periodId, FiscalPeriodStatus status) =>
      updatePeriodStatusImpl(periodId, status);

  @override
  Future<double> getAccountBalance(String accountId) =>
      getAccountBalanceImpl(accountId);

  @override
  Future<List<AccountsPayable>> getAccountsPayable() => getAccountsPayableImpl();

  @override
  Future<void> saveAccountsPayable(AccountsPayable payable) =>
      saveAccountsPayableImpl(payable);

  @override
  Future<List<Payment>> getPayments() => getPaymentsImpl();

  @override
  Future<void> savePayment(Payment payment) => savePaymentImpl(payment);

  @override
  Future<List<BankAccount>> getBankAccounts() => getBankAccountsImpl();

  @override
  Future<void> saveBankAccount(BankAccount account) => saveBankAccountImpl(account);

  @override
  Future<List<BankTransaction>> getBankTransactions(String accountId) =>
      getBankTransactionsImpl(accountId);

  @override
  Future<void> recordBankTransaction(BankTransaction transaction) =>
      recordBankTransactionImpl(transaction);

  @override
  Future<List<ExpenseEntry>> getExpenses() => getExpensesImpl();

  @override
  Future<void> saveExpense(ExpenseEntry expense) => saveExpenseImpl(expense);

  @override
  Future<List<ExpenseClaim>> getExpenseClaims() => getExpenseClaimsImpl();

  @override
  Future<void> saveExpenseClaim(ExpenseClaim claim) => saveExpenseClaimImpl(claim);

  @override
  Future<List<Budget>> getBudgets() => getBudgetsImpl();

  @override
  Future<void> saveBudget(Budget budget) => saveBudgetImpl(budget);

  @override
  Future<List<CostCenter>> getCostCenters() => getCostCentersImpl();

  @override
  Future<void> saveCostCenter(CostCenter costCenter) => saveCostCenterImpl(costCenter);

  @override
  Future<List<FixedAsset>> getFixedAssets() => getFixedAssetsImpl();

  @override
  Future<void> saveFixedAsset(FixedAsset asset) => saveFixedAssetImpl(asset);

  @override
  Future<List<AssetMaintenance>> getAssetMaintenance(String assetId) =>
      getAssetMaintenanceImpl(assetId);

  @override
  Future<void> recordAssetMaintenance(AssetMaintenance maintenance) =>
      recordAssetMaintenanceImpl(maintenance);

  @override
  Future<List<TaxRule>> getTaxRules() => getTaxRulesImpl();

  @override
  Future<void> saveTaxRule(TaxRule rule) => saveTaxRuleImpl(rule);

  @override
  Future<List<TaxReturn>> getTaxReturns() => getTaxReturnsImpl();

  @override
  Future<void> saveTaxReturn(TaxReturn taxReturn) => saveTaxReturnImpl(taxReturn);

  @override
  Future<List<ClosingTask>> getClosingChecklist(String periodId) =>
      getClosingChecklistImpl(periodId);

  @override
  Future<void> updateClosingTask(ClosingTask task) => updateClosingTaskImpl(task);
}
