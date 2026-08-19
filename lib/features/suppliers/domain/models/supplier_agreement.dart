class SupplierAgreement {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String? contractUrl;
  final bool isActive;

  const SupplierAgreement({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    this.contractUrl,
    this.isActive = true,
  });
}
