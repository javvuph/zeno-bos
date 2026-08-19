import '../models/account.dart';
import '../models/journal_entry.dart';
import '../models/fiscal_year.dart';
import '../models/fiscal_period.dart';
import '../models/accounts_payable.dart';
import '../models/payment.dart';
import '../models/bank_account.dart';
import '../models/bank_transaction.dart';
import '../models/expense_entry.dart';
import '../models/expense_claim.dart';
import '../models/budget.dart';
import '../models/cost_center.dart';
import '../models/fixed_asset.dart';
import '../models/asset_maintenance.dart';
import '../models/tax_rule.dart';
import '../models/tax_return.dart';
import '../models/closing_task.dart';

abstract class IFinanceRepository {
  // Account Management
  Future<List<Account>> getChartOfAccounts();
  Future<void> saveAccount(Account account);

  // Ledger / Journals
  Future<void> postJournalEntry(JournalEntry entry);
  Future<List<JournalEntry>> getLedgerEntries(
      String accountId, DateTime start, DateTime end);
  Future<List<JournalEntry>> getAllJournalEntries();

  // Fiscal / Config
  Future<List<FiscalYear>> getFiscalYears();
  Future<void> closeFiscalYear(String id);
  Future<List<FiscalPeriod>> getFiscalPeriods();
  Future<void> updatePeriodStatus(String periodId, FiscalPeriodStatus status);

  // Analytics / Reporting
  Future<double> getAccountBalance(String accountId);

  // Payables & Payments (Phase 7.1)
  Future<List<AccountsPayable>> getAccountsPayable();
  Future<void> saveAccountsPayable(AccountsPayable payable);
  Future<List<Payment>> getPayments();
  Future<void> savePayment(Payment payment);

  // Banking & Cash Management (Phase 7.3)
  Future<List<BankAccount>> getBankAccounts();
  Future<void> saveBankAccount(BankAccount account);
  Future<List<BankTransaction>> getBankTransactions(String accountId);
  Future<void> recordBankTransaction(BankTransaction transaction);

  // Expenses & Claims (Phase 7.5)
  Future<List<ExpenseEntry>> getExpenses();
  Future<void> saveExpense(ExpenseEntry expense);
  Future<List<ExpenseClaim>> getExpenseClaims();
  Future<void> saveExpenseClaim(ExpenseClaim claim);

  // Budget & Cost Centers (Phase 7.6)
  Future<List<Budget>> getBudgets();
  Future<void> saveBudget(Budget budget);
  Future<List<CostCenter>> getCostCenters();
  Future<void> saveCostCenter(CostCenter costCenter);

  // Fixed Assets (Phase 7.7)
  Future<List<FixedAsset>> getFixedAssets();
  Future<void> saveFixedAsset(FixedAsset asset);
  Future<List<AssetMaintenance>> getAssetMaintenance(String assetId);
  Future<void> recordAssetMaintenance(AssetMaintenance maintenance);

  // Tax Management (Phase 7.8)
  Future<List<TaxRule>> getTaxRules();
  Future<void> saveTaxRule(TaxRule rule);
  Future<List<TaxReturn>> getTaxReturns();
  Future<void> saveTaxReturn(TaxReturn taxReturn);

  // Financial Closing (Phase 7.9)
  Future<List<ClosingTask>> getClosingChecklist(String periodId);
  Future<void> updateClosingTask(ClosingTask task);
}
