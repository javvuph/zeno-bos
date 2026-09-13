class DebitNote {
  final String id;
  final String supplierId;
  final String referenceId; // Purchase Return or Invoice ID
  final double amount;
  final String currency;
  final DateTime date;
  final String reason;

  const DebitNote({
    required this.id,
    required this.supplierId,
    required this.referenceId,
    required this.amount,
    required this.currency,
    required this.date,
    required this.reason,
  });
}
