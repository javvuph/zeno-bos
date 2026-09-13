class ReorderRule {
  final String id;
  final String productId;
  final String variantId;
  final String warehouseId;
  final double minStock;
  final double reorderPoint;
  final double preferredQuantity;

  const ReorderRule({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.warehouseId,
    required this.minStock,
    required this.reorderPoint,
    required this.preferredQuantity,
  });
}
