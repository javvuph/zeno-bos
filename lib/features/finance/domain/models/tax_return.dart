enum TaxReturnStatus { draft, prepared, filed, cancelled }

class TaxReturn {
  final String id;
  final String periodId;
  final String type; // GSTR-1, GSTR-3B, VAT-200
  final DateTime filingDate;
  final double totalTaxableValue;
  final double totalTaxAmount;
  final double inputTaxCredit;
  final TaxReturnStatus status;
  final String? filingReference;

  const TaxReturn({
    required this.id,
    required this.periodId,
    required this.type,
    required this.filingDate,
    required this.totalTaxableValue,
    required this.totalTaxAmount,
    this.inputTaxCredit = 0.0,
    this.status = TaxReturnStatus.draft,
    this.filingReference,
  });
}
