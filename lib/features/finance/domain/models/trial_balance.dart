import 'account.dart';

class TrialBalance {
  final List<TrialBalanceLine> lines;
  final DateTime date;
  final double totalDebit;
  final double totalCredit;

  const TrialBalance({
    required this.lines,
    required this.date,
    required this.totalDebit,
    required this.totalCredit,
  });

  double get difference => (totalDebit - totalCredit).abs();
  bool get isBalanced => difference < 0.001;
}

class TrialBalanceLine {
  final Account account;
  final double debit;
  final double credit;

  const TrialBalanceLine({
    required this.account,
    required this.debit,
    required this.credit,
  });
}
