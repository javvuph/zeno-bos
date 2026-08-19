import 'sales_item.dart';

class SalesQuotation {
  final String id;
  final String customerId;
  final DateTime date;
  final DateTime expiryDate;
  final List<SalesItem> items;
  final String currency;
  final double totalAmount;
  final String? terms;

  const SalesQuotation({
    required this.id,
    required this.customerId,
    required this.date,
    required this.expiryDate,
    required this.items,
    required this.currency,
    required this.totalAmount,
    this.terms,
  });
}
