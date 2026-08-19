import 'purchase_item.dart';

class SupplierQuotation {
  final String id;
  final String rfqId;
  final String supplierId;
  final List<PurchaseItem> items;
  final String currency;
  final double exchangeRate;
  final DateTime quotationDate;
  final DateTime validityDate;

  // Financials
  final double subtotal;
  final double discountAmount;
  final double taxAmount;
  final double freightCost;
  final double totalAmount;

  // Comparison Metrics
  final int leadTimeDays;
  final String paymentTerms;
  final String warrantyTerms;

  // Scores (0-100)
  final double qualityRating;
  final double pastPerformanceScore;
  final double deliveryReliabilityScore;
  final double aiScore;

  final bool isSelected;
  final String? vendorNotes;

  const SupplierQuotation({
    required this.id,
    required this.rfqId,
    required this.supplierId,
    required this.items,
    required this.currency,
    this.exchangeRate = 1.0,
    required this.quotationDate,
    required this.validityDate,
    required this.subtotal,
    this.discountAmount = 0.0,
    this.taxAmount = 0.0,
    this.freightCost = 0.0,
    required this.totalAmount,
    required this.leadTimeDays,
    required this.paymentTerms,
    required this.warrantyTerms,
    this.qualityRating = 0.0,
    this.pastPerformanceScore = 0.0,
    this.deliveryReliabilityScore = 0.0,
    this.aiScore = 0.0,
    this.isSelected = false,
    this.vendorNotes,
  });

  double get overallScore =>
      (qualityRating + pastPerformanceScore + deliveryReliabilityScore) / 3;

  SupplierQuotation copyWith({
    bool? isSelected,
    double? aiScore,
  }) {
    return SupplierQuotation(
      id: id,
      rfqId: rfqId,
      supplierId: supplierId,
      items: items,
      currency: currency,
      exchangeRate: exchangeRate,
      quotationDate: quotationDate,
      validityDate: validityDate,
      subtotal: subtotal,
      discountAmount: discountAmount,
      taxAmount: taxAmount,
      freightCost: freightCost,
      totalAmount: totalAmount,
      leadTimeDays: leadTimeDays,
      paymentTerms: paymentTerms,
      warrantyTerms: warrantyTerms,
      qualityRating: qualityRating,
      pastPerformanceScore: pastPerformanceScore,
      deliveryReliabilityScore: deliveryReliabilityScore,
      aiScore: aiScore ?? this.aiScore,
      isSelected: isSelected ?? this.isSelected,
      vendorNotes: vendorNotes,
    );
  }
}
