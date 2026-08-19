import 'vendor_bill_status.dart'; // Moving enum to its own file or using existing

class VendorBill {
  final String id;
  final String supplierId;
  final String invoiceNumber;
  final String? poId;
  final String? grnId;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final String currency;
  final double exchangeRate;

  // Financials
  final double subtotal;
  final double gstAmount;
  final double freightCost;
  final double additionalCharges;
  final double totalAmount;
  final double balanceDue;

  final VendorBillStatus status;
  final String? approvalNotes;
  final List<VendorBillItem> items;

  // 3-Way Match & AI
  final double aiMatchScore;
  final List<String> matchDiscrepancies;
  final bool is3WayMatched;

  const VendorBill({
    required this.id,
    required this.supplierId,
    required this.invoiceNumber,
    this.poId,
    this.grnId,
    required this.invoiceDate,
    required this.dueDate,
    required this.currency,
    this.exchangeRate = 1.0,
    required this.subtotal,
    this.gstAmount = 0.0,
    this.freightCost = 0.0,
    this.additionalCharges = 0.0,
    required this.totalAmount,
    required this.balanceDue,
    this.status = VendorBillStatus.draft,
    this.approvalNotes,
    required this.items,
    this.aiMatchScore = 0.0,
    this.matchDiscrepancies = const [],
    this.is3WayMatched = false,
  });

  VendorBill copyWith({
    VendorBillStatus? status,
    String? approvalNotes,
    double? balanceDue,
    double? aiMatchScore,
    List<String>? matchDiscrepancies,
    bool? is3WayMatched,
  }) {
    return VendorBill(
      id: id,
      supplierId: supplierId,
      invoiceNumber: invoiceNumber,
      poId: poId,
      grnId: grnId,
      invoiceDate: invoiceDate,
      dueDate: dueDate,
      currency: currency,
      exchangeRate: exchangeRate,
      subtotal: subtotal,
      gstAmount: gstAmount,
      freightCost: freightCost,
      additionalCharges: additionalCharges,
      totalAmount: totalAmount,
      balanceDue: balanceDue ?? this.balanceDue,
      status: status ?? this.status,
      approvalNotes: approvalNotes ?? this.approvalNotes,
      items: items,
      aiMatchScore: aiMatchScore ?? this.aiMatchScore,
      matchDiscrepancies: matchDiscrepancies ?? this.matchDiscrepancies,
      is3WayMatched: is3WayMatched ?? this.is3WayMatched,
    );
  }
}

class VendorBillItem {
  final String productId;
  final String name;
  final double quantity;
  final double unitPrice;
  final double taxRate;
  final double taxAmount;
  final double totalAmount;

  const VendorBillItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
    required this.taxAmount,
    required this.totalAmount,
  });
}
