import '../models/account.dart';
import '../models/account_type.dart';
import '../models/journal_entry.dart';
import '../models/journal_line.dart';
import '../models/accounts_payable.dart';
import '../models/payment_status.dart';
import '../models/fiscal_period.dart';
import '../models/bank_account.dart';
import '../models/bank_transaction.dart';
import '../models/expense_entry.dart';
import '../models/expense_claim.dart';
import '../models/expense_status.dart';
import '../models/budget.dart';
import '../models/cost_center.dart';
import '../models/asset_maintenance.dart';
import '../models/tax_rule.dart';
import '../models/tax_return.dart';
import '../models/hsn_code.dart';
import '../models/closing_task.dart';
import '../models/fixed_asset.dart';
import '../models/asset_status.dart';

class FinanceMasterDataService {
  List<Account> getMockAccounts() => [
        const Account(
          id: 'acc_1001',
          code: '1001',
          name: 'Operating Cash',
          category: AccountCategory.asset,
          type: AccountType.cash,
          currency: 'INR',
          currentBalance: 45200.0,
        ),
        const Account(
          id: 'acc_2001',
          code: '2001',
          name: 'Accounts Payable',
          category: AccountCategory.liability,
          type: AccountType.payable,
          currency: 'INR',
          currentBalance: 12500.0,
        ),
        const Account(
          id: 'acc_4001',
          code: '4001',
          name: 'Sales Revenue',
          category: AccountCategory.income,
          type: AccountType.revenue,
          currency: 'INR',
          currentBalance: 145000.0,
        ),
      ];

  List<JournalEntry> getMockEntries() => [
        JournalEntry(
          id: 'JE-2026-001',
          referenceNumber: 'REF-8821',
          date: DateTime.now(),
          description: 'Monthly Office Rent - Aug 2026',
          createdById: 'user_fin_01',
          sourceModule: 'finance',
          status: JournalEntryStatus.posted,
          lines: [
            const JournalLine(
                accountId: 'acc_expenses_rent', debit: 15000, credit: 0),
            const JournalLine(
                accountId: 'acc_operating_cash', debit: 0, credit: 15000),
          ],
        ),
        JournalEntry(
          id: 'JE-2026-002',
          referenceNumber: 'REF-8822',
          date: DateTime.now().subtract(const Duration(hours: 5)),
          description: 'Sale of Inventory - Order #9910',
          createdById: 'user_sales_04',
          sourceModule: 'sales',
          status: JournalEntryStatus.posted,
          lines: [
            const JournalLine(
                accountId: 'acc_accounts_receivable', debit: 4200, credit: 0),
            const JournalLine(
                accountId: 'acc_sales_revenue', debit: 0, credit: 4200),
          ],
        ),
      ];

  List<FiscalPeriod> getMockPeriods() => [
        FiscalPeriod(
          id: 'p_2026_08',
          name: 'AUG-2026',
          startDate: DateTime(2026, 8, 1),
          endDate: DateTime(2026, 8, 31),
          status: FiscalPeriodStatus.open,
        ),
      ];

  List<AccountsPayable> getMockPayables() => [
        AccountsPayable(
          id: 'AP-001',
          supplierId: 'SUP-001',
          vendorBillId: 'VB-001',
          invoiceNumber: 'INV-12345',
          amount: 5000.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          status: PaymentStatus.pending,
        ),
      ];

  List<BankAccount> getMockBankAccounts() => [
        const BankAccount(
          id: 'BA-001',
          name: 'Primary Operating',
          accountNumber: 'XXXX-9901',
          bankName: 'Federal Trust Bank',
          branchName: 'DOWNTOWN-HQ',
          type: BankAccountType.current,
          currency: 'INR',
          currentBalance: 850400.0,
          availableBalance: 842000.0,
        ),
        const BankAccount(
          id: 'BA-002',
          name: 'Main Vault',
          accountNumber: 'CASH-VAULT-01',
          bankName: 'Internal',
          branchName: 'CENTRAL',
          type: BankAccountType.vault,
          currency: 'INR',
          currentBalance: 120500.0,
          availableBalance: 120500.0,
        ),
      ];

  List<BankTransaction> getMockBankTransactions() => [
        BankTransaction(
          id: 'BTX-001',
          bankAccountId: 'BA-001',
          date: DateTime.now(),
          description: 'Transfer from POS Terminal 01',
          amount: 45000.0,
          type: BankTransactionType.deposit,
          status: BankTransactionStatus.cleared,
          counterPartyName: 'Internal POS',
        ),
        BankTransaction(
          id: 'BTX-002',
          bankAccountId: 'BA-001',
          date: DateTime.now().subtract(const Duration(hours: 4)),
          description: 'Supplier Payment: Global Tech',
          amount: 11800.0,
          type: BankTransactionType.withdrawal,
          status: BankTransactionStatus.reconciled,
          counterPartyName: 'Global Tech Ltd',
        ),
      ];

  List<ExpenseEntry> getMockExpenses() => [
        ExpenseEntry(
          id: 'EXP-2026-001',
          employeeId: 'EMP-FIN-01',
          date: DateTime.now().subtract(const Duration(days: 1)),
          category: ExpenseCategory.meal,
          amount: 1850.0,
          taxAmount: 92.5,
          currency: 'INR',
          description: 'Team Lunch - Project Alpha Kickoff',
          receiptUrl: 'https://cdn.zeno.com/receipts/r1.jpg',
          status: ExpenseStatus.pendingApproval,
          aiAnomalyScore: 12.0,
        ),
        ExpenseEntry(
          id: 'EXP-2026-002',
          employeeId: 'EMP-SAL-04',
          date: DateTime.now(),
          category: ExpenseCategory.travel,
          amount: 12400.0,
          taxAmount: 620.0,
          currency: 'INR',
          description: 'Flight to Mumbai - Client Meeting',
          status: ExpenseStatus.draft,
          aiAnomalyScore: 4.5,
        ),
      ];

  List<ExpenseClaim> getMockClaims() => [
        ExpenseClaim(
          id: 'CLM-2026-001',
          employeeId: 'EMP-FIN-01',
          title: 'August Travel Expenses',
          submissionDate: DateTime.now().subtract(const Duration(days: 3)),
          entries: [],
          status: ExpenseStatus.pendingApproval,
          totalAmount: 14250.0,
        ),
      ];

  List<Budget> getMockBudgets() => [
        Budget(
          id: 'BDG-2026-FIN',
          code: 'BDG-001',
          name: 'Finance Dept Annual Ops',
          fiscalYearId: 'FY-2026',
          departmentId: 'DEPT-FIN',
          allocatedAmount: 1200000.0,
          utilizedAmount: 450000.0,
          status: BudgetStatus.active,
          ownerId: 'EMP-FIN-01',
          createdAt: DateTime(2026, 1, 1),
        ),
        Budget(
          id: 'BDG-2026-IT',
          code: 'BDG-045',
          name: 'IT Cloud Infrastructure',
          fiscalYearId: 'FY-2026',
          departmentId: 'DEPT-IT',
          allocatedAmount: 500000.0,
          utilizedAmount: 520000.0,
          status: BudgetStatus.revised,
          ownerId: 'EMP-IT-04',
          createdAt: DateTime(2026, 1, 1),
        ),
      ];

  List<CostCenter> getMockCostCenters() => [
        const CostCenter(
          id: 'CC-FIN-OP',
          code: 'CC-101',
          name: 'Finance Operations',
          type: CostCenterType.costCenter,
          managerId: 'EMP-FIN-01',
        ),
        const CostCenter(
          id: 'CC-SAL-MK',
          code: 'CC-202',
          name: 'Marketing Campaigns',
          type: CostCenterType.profitCenter,
          managerId: 'EMP-MKT-02',
        ),
      ];

  List<AssetMaintenance> getMockAssetHistory() => [
        AssetMaintenance(
          id: 'MNT-001',
          assetId: 'AST-002',
          maintenanceDate: DateTime.now().subtract(const Duration(days: 5)),
          description: 'Annual Service & Oil Filter Change',
          cost: 12500.0,
          status: MaintenanceStatus.completed,
          vendorName: 'Reliable Power Systems',
        ),
      ];

  List<FixedAsset> getMockAssets() => [
        FixedAsset(
          id: 'AST-001',
          assetCode: 'MAC-PRO-01',
          name: 'MacBook Pro 16 - Finance Head',
          categoryId: 'IT-HW',
          groupId: 'Laptops',
          acquisitionDate: DateTime(2025, 3, 15),
          purchaseValue: 245000.0,
          currentBookValue: 198000.0,
          status: AssetStatus.active,
          usefulLifeMonths: 48,
          custodianId: 'EMP-FIN-01',
          aiHealthScore: 92.0,
        ),
        FixedAsset(
          id: 'AST-002',
          assetCode: 'GEN-SET-01',
          name: 'Diesel Generator 25KVA',
          categoryId: 'PLANT-MECH',
          groupId: 'Power Backup',
          acquisitionDate: DateTime(2024, 11, 20),
          purchaseValue: 850000.0,
          currentBookValue: 712000.0,
          status: AssetStatus.underMaintenance,
          usefulLifeMonths: 120,
          locationId: 'LOC-MAIN-PLANT',
          aiHealthScore: 64.0,
        ),
      ];

  List<TaxRule> getMockTaxRules() => [
        TaxRule(
          id: 'TR-001',
          code: 'GST-18',
          name: 'Standard GST 18%',
          country: 'India',
          type: TaxType.gst,
          category: TaxCategory.igst,
          rate: 18.0,
          effectiveDate: DateTime(2024, 1, 1),
        ),
        TaxRule(
          id: 'TR-002',
          code: 'VAT-05',
          name: 'UAE VAT 5%',
          country: 'UAE',
          type: TaxType.vat,
          category: TaxCategory.vat,
          rate: 5.0,
          effectiveDate: DateTime(2024, 1, 1),
        ),
      ];

  List<HSNCode> getMockHsnCodes() => [
        const HSNCode(
            code: '8471',
            description: 'Automatic data processing machines',
            category: 'Hardware',
            defaultGstRate: 18.0),
        const HSNCode(
            code: '9983',
            description: 'IT Design and Development Services',
            category: 'Services',
            defaultGstRate: 18.0),
      ];

  List<TaxReturn> getMockTaxReturns() => [
        TaxReturn(
          id: 'RET-2026-07',
          periodId: 'p_2026_07',
          type: 'GSTR-3B',
          filingDate: DateTime(2026, 7, 20),
          totalTaxableValue: 850400.0,
          totalTaxAmount: 153072.0,
          inputTaxCredit: 42500.0,
          status: TaxReturnStatus.filed,
          filingReference: 'ACK-99210-GST',
        ),
      ];

  List<ClosingTask> getMockClosingTasks() => [
        const ClosingTask(
          id: 'TASK-001',
          title: 'Bank Reconciliation',
          description: 'Match HDFC Bank statement for August.',
          category: 'Banking',
          status: ClosingTaskStatus.completed,
        ),
        const ClosingTask(
          id: 'TASK-002',
          title: 'Depreciation Posting',
          description: 'Calculate and post monthly depreciation.',
          category: 'Assets',
          status: ClosingTaskStatus.inProgress,
        ),
        const ClosingTask(
          id: 'TASK-003',
          title: 'GST Input Credit Review',
          description: 'Verify 2B reconciliation with internal GST ledger.',
          category: 'Tax',
          status: ClosingTaskStatus.pending,
        ),
      ];
}
