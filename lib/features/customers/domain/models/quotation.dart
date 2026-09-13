import 'quotation_status.dart';
import 'quotation_item.dart';

class Quotation {
  final String id;
  final String quotationNumber;
  final String customerId;
  final String? opportunityId;
  final List<QuotationItem> items;
  final double subTotal;
  final double totalDiscount;
  final double totalTax;
  final double grandTotal;
  final QuotationStatus status;
  final int revision;
  final DateTime expiryDate;
  final String? representativeId;
  final String? branchId;
  final String? companyId;
  final DateTime createdAt;

  const Quotation({
    required this.id,
    required this.quotationNumber,
    required this.customerId,
    this.opportunityId,
    required this.items,
    required this.subTotal,
    required this.totalDiscount,
    required this.totalTax,
    required this.grandTotal,
    this.status = QuotationStatus.draft,
    this.revision = 1,
    required this.expiryDate,
    this.representativeId,
    this.branchId,
    this.companyId,
    required this.createdAt,
  });

  double get marginPercent {
    if (grandTotal == 0) return 0;
    // Mocked cost logic
    double cost = subTotal * 0.7;
    return ((grandTotal - cost) / grandTotal) * 100;
  }
}
