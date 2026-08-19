import 'sales_order_status.dart';
import 'sales_order_item.dart';

class SalesOrder {
  final String id;
  final String orderNumber;
  final String customerId;
  final String? quotationId;
  final List<SalesOrderItem> items;
  final double subTotal;
  final double totalDiscount;
  final double totalTax;
  final double grandTotal;
  final SalesOrderStatus status;
  final DateTime orderDate;
  final DateTime? expectedDeliveryDate;
  final String? shippingAddressId;
  final String? billingAddressId;
  final String? representativeId;
  final String? branchId;
  final String? companyId;
  final Map<String, dynamic> metadata;
  final double aiHealthScore;

  const SalesOrder({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    this.quotationId,
    required this.items,
    required this.subTotal,
    required this.totalDiscount,
    required this.totalTax,
    required this.grandTotal,
    this.status = SalesOrderStatus.draft,
    required this.orderDate,
    this.expectedDeliveryDate,
    this.shippingAddressId,
    this.billingAddressId,
    this.representativeId,
    this.branchId,
    this.companyId,
    this.metadata = const {},
    this.aiHealthScore = 100.0,
  });

  bool get isFulfilled => items.every((i) => i.pendingQuantity <= 0);

  SalesOrder copyWith({
    SalesOrderStatus? status,
    List<SalesOrderItem>? items,
    double? aiHealthScore,
    Map<String, dynamic>? metadata,
  }) {
    return SalesOrder(
      id: id,
      orderNumber: orderNumber,
      customerId: customerId,
      quotationId: quotationId,
      items: items ?? this.items,
      subTotal: subTotal,
      totalDiscount: totalDiscount,
      totalTax: totalTax,
      grandTotal: grandTotal,
      status: status ?? this.status,
      orderDate: orderDate,
      expectedDeliveryDate: expectedDeliveryDate,
      shippingAddressId: shippingAddressId,
      billingAddressId: billingAddressId,
      representativeId: representativeId,
      branchId: branchId,
      companyId: companyId,
      metadata: metadata ?? this.metadata,
      aiHealthScore: aiHealthScore ?? this.aiHealthScore,
    );
  }
}
