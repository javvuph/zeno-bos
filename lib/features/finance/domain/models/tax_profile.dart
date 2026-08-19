class TaxProfile {
  final String id;
  final String code;
  final String name;
  final double rate;
  final String? purchaseAccountId;
  final String? salesAccountId;

  const TaxProfile({
    required this.id,
    required this.code,
    required this.name,
    required this.rate,
    this.purchaseAccountId,
    this.salesAccountId,
  });
}
