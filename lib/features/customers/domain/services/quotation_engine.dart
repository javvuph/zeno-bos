import '../models/quotation.dart';

class QuotationEngine {
  /// Validates if a discount exceeds the allowed threshold for the representative (Mock)
  bool validateDiscount(double discountPercent, String repTier) {
    if (repTier == 'Manager') return discountPercent <= 30.0;
    return discountPercent <= 15.0;
  }

  /// Calculates the next revision version
  int getNextRevision(int currentRevision) => currentRevision + 1;

  /// Creates a new revision of an existing quotation
  Quotation createRevision(Quotation original) {
    return Quotation(
      id: original.id, // Keeps same ID if overwriting or different if branching
      quotationNumber: original.quotationNumber,
      customerId: original.customerId,
      items: original.items,
      subTotal: original.subTotal,
      totalDiscount: original.totalDiscount,
      totalTax: original.totalTax,
      grandTotal: original.grandTotal,
      status: original.status,
      revision: getNextRevision(original.revision),
      expiryDate: original.expiryDate,
      representativeId: original.representativeId,
      branchId: original.branchId,
      companyId: original.companyId,
      createdAt: DateTime.now(),
    );
  }

  /// Calculates individual item totals
  double calculateItemTotal(
      double qty, double price, double discount, double taxRate) {
    double base = qty * price;
    double net = base - discount;
    return net * (1 + (taxRate / 100));
  }
}
