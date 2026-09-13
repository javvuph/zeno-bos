enum TaxType { gst, vat, salesTax, tds, tcs, withholding }

enum TaxCategory { sgst, cgst, igst, vat, cess, custom }

class TaxRule {
  final String id;
  final String code;
  final String name;
  final String country;
  final String? state;
  final TaxType type;
  final TaxCategory category;
  final double rate;
  final DateTime effectiveDate;
  final DateTime? expiryDate;
  final bool isReverseCharge;
  final bool isRecoverable;
  final String? accountId;

  const TaxRule({
    required this.id,
    required this.code,
    required this.name,
    required this.country,
    this.state,
    required this.type,
    required this.category,
    required this.rate,
    required this.effectiveDate,
    this.expiryDate,
    this.isReverseCharge = false,
    this.isRecoverable = true,
    this.accountId,
  });
}
