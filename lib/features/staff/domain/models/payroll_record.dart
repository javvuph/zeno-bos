class PayrollRecord {
  final String id;
  final String employeeId;
  final String month; // e.g., '2026-08'
  final double grossAmount;
  final double netAmount;
  final double taxes;
  final bool isPaid;
  final DateTime? paymentDate;

  const PayrollRecord({
    required this.id,
    required this.employeeId,
    required this.month,
    required this.grossAmount,
    required this.netAmount,
    required this.taxes,
    this.isPaid = false,
    this.paymentDate,
  });
}
