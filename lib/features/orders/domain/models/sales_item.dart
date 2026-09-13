class SalesItem {
  final String productId;
  final String variantId;
  final String sku;
  final String description;
  final double quantity;
  final double fulfilledQuantity;
  final String unit;
  final double unitPrice;
  final double taxRate;
  final double? discount;

  const SalesItem({
    required this.productId,
    required this.variantId,
    required this.sku,
    required this.description,
    required this.quantity,
    this.fulfilledQuantity = 0.0,
    required this.unit,
    required this.unitPrice,
    this.taxRate = 0.0,
    this.discount,
  });

  double get subtotal => quantity * unitPrice;
  double get taxAmount => subtotal * (taxRate / 100);
  double get total => subtotal + taxAmount - (discount ?? 0.0);

  double get pendingQuantity => quantity - fulfilledQuantity;

  SalesItem copyWith({
    double? fulfilledQuantity,
  }) {
    return SalesItem(
      productId: productId,
      variantId: variantId,
      sku: sku,
      description: description,
      quantity: quantity,
      fulfilledQuantity: fulfilledQuantity ?? this.fulfilledQuantity,
      unit: unit,
      unitPrice: unitPrice,
      taxRate: taxRate,
      discount: discount,
    );
  }
}
