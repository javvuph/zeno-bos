class SupplierTaxProfile {
  final String taxId; // GST/VAT/TIN
  final String taxRegName;
  final String taxCode;
  final double defaultTaxRate;

  const SupplierTaxProfile({
    required this.taxId,
    required this.taxRegName,
    required this.taxCode,
    this.defaultTaxRate = 0.0,
  });
}
