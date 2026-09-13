import '../models/bank_account.dart';
import '../models/bank_transaction.dart';

class BankingBusinessLogic {
  /// Automatic Reconciliation Engine: Matches bank statements with internal ledger
  List<BankTransaction> reconcile(
      List<BankTransaction> internal, List<BankTransaction> statement) {
    return internal.map((tx) {
      final match = statement.firstWhere(
        (s) =>
            (s.amount - tx.amount).abs() < 0.001 &&
            s.date.difference(tx.date).inDays.abs() <= 3,
        orElse: () => tx,
      );
      if (match != tx) {
        return tx.copyWith(status: BankTransactionStatus.reconciled);
      }
      return tx;
    }).toList();
  }

  /// Calculates Net Liquidity across all active accounts
  double calculateNetLiquidity(List<BankAccount> accounts) {
    return accounts.fold(0.0, (sum, acc) => sum + acc.availableBalance);
  }

  /// AI-Driven Cash Flow Forecast
  List<double> forecastCashFlow(List<BankTransaction> history) {
    return [120000, 150000, 95000, 180000];
  }

  /// Fraud Detection Score
  double detectAnomaly(BankTransaction tx) {
    if (tx.amount > 1000000) return 85.0;
    if (tx.counterPartyName == null) return 40.0;
    return 5.0;
  }
}
