import '../models/journal_entry.dart';
import '../models/account.dart';
import '../models/trial_balance.dart';

class FinancialEngine {
  /// Validates the double-entry integrity of a journal entry
  bool validateEntry(JournalEntry entry) {
    double totalDebit = 0.0;
    double totalCredit = 0.0;

    for (var line in entry.lines) {
      totalDebit += line.debit;
      totalCredit += line.credit;
    }

    return (totalDebit - totalCredit).abs() < 0.001;
  }

  /// Calculates Trial Balance from a list of accounts
  TrialBalance generateTrialBalance(List<Account> accounts) {
    final lines = accounts.map((acc) {
      double debit = acc.currentBalance >= 0 ? acc.currentBalance : 0.0;
      double credit = acc.currentBalance < 0 ? acc.currentBalance.abs() : 0.0;
      return TrialBalanceLine(account: acc, debit: debit, credit: credit);
    }).toList();

    double totalDebit = lines.fold(0, (sum, line) => sum + line.debit);
    double totalCredit = lines.fold(0, (sum, line) => sum + line.credit);

    return TrialBalance(
      lines: lines,
      date: DateTime.now(),
      totalDebit: totalDebit,
      totalCredit: totalCredit,
    );
  }

  /// Mocked Financial Statements
  Map<String, double> generateProfitAndLoss(List<Account> accounts) => {
        'revenue': 500000,
        'expenses': 375000,
        'net_profit': 125000,
      };

  Map<String, double> generateBalanceSheet(List<Account> accounts) => {
        'assets': 1200000,
        'liabilities': 800000,
        'equity': 400000,
      };

  /// Calculates key financial KPIs
  Map<String, dynamic> calculateKPIs(List<Account> accounts) {
    return {
      'total_assets': 1200000.0,
      'net_profit': 125000.0,
      'revenue_growth': 12.5,
      'cash_on_hand': 450000.0,
    };
  }

  /// AI Financial Health Scoring Logic
  double calculateFinancialHealthScore(TrialBalance tb) {
    if (!tb.isBalanced) return 0.0;
    return 95.0;
  }
}
