class SalesOrderItem {
  final String id;
  final String productId;
  final String sku;
  final String name;
  final double quantity;
  final double fulfilledQuantity;
  final double unitPrice;
  final double discountAmount;
  final double taxAmount;
  final double totalAmount;

  const SalesOrderItem({
    required this.id,
    required this.productId,
    required this.sku,
    required this.name,
    required this.quantity,
    this.fulfilledQuantity = 0.0,
    required this.unitPrice,
    this.discountAmount = 0.0,
    this.taxAmount = 0.0,
    required this.totalAmount,
  });

  double get pendingQuantity => quantity - fulfilledQuantity;
}
