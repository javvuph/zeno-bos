class PurchaseItem {
  final String productId;
  final String variantId;
  final String name;
  final double quantity;
  final double receivedQuantity;
  final String unitId;
  final double unitPrice;
  final double taxRate;
  final double? discount;

  const PurchaseItem({
    required this.productId,
    required this.variantId,
    required this.name,
    required this.quantity,
    this.receivedQuantity = 0.0,
    required this.unitId,
    this.unitPrice = 0.0,
    this.taxRate = 0.0,
    this.discount,
  });

  double get pendingQuantity => quantity - receivedQuantity;
  double get subtotal => quantity * unitPrice;
  double get taxAmount => subtotal * (taxRate / 100);
  double get total => subtotal + taxAmount - (discount ?? 0.0);

  PurchaseItem copyWith({
    double? receivedQuantity,
    double? quantity,
  }) {
    return PurchaseItem(
      productId: productId,
      variantId: variantId,
      name: name,
      quantity: quantity ?? this.quantity,
      receivedQuantity: receivedQuantity ?? this.receivedQuantity,
      unitId: unitId,
      unitPrice: unitPrice,
      taxRate: taxRate,
      discount: discount,
    );
  }
}
