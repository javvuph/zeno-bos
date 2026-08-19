class SupplierPaymentTerms {
  final String id;
  final String label;
  final int dueDays;
  final double? discountPercentage;
  final int? discountDays;

  const SupplierPaymentTerms({
    required this.id,
    required this.label,
    required this.dueDays,
    this.discountPercentage,
    this.discountDays,
  });
}
