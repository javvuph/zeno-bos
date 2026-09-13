class JournalLine {
  final String accountId;
  final double debit;
  final double credit;
  final String? costCenterId;
  final String? memo;
  final Map<String, dynamic> metadata; // For AI and external references

  const JournalLine({
    required this.accountId,
    this.debit = 0.0,
    this.credit = 0.0,
    this.costCenterId,
    this.memo,
    this.metadata = const {},
  });

  bool get isBalanced => (debit - credit).abs() < 0.0001;
}
