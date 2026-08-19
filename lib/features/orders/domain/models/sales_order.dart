import 'sales_item.dart';
import 'sales_order_status.dart';

class SalesOrder {
  final String id;
  final String? quotationId;
  final String customerId;
  final List<SalesItem> items;
  final String warehouseId;
  final String currency;
  final double exchangeRate;
  final DateTime orderDate;
  final SalesOrderStatus status;
  final bool isBackOrder;
  final double totalTax;
  final double totalAmount;
  final Map<String, dynamic> aiInsights;

  const SalesOrder({
    required this.id,
    this.quotationId,
    required this.customerId,
    required this.items,
    required this.warehouseId,
    required this.currency,
    this.exchangeRate = 1.0,
    required this.orderDate,
    this.status = SalesOrderStatus.confirmed,
    this.isBackOrder = false,
    this.totalTax = 0.0,
    this.totalAmount = 0.0,
    this.aiInsights = const {},
  });
}
