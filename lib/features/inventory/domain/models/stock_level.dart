class StockLevel {
  final String productId;
  final String variantId;
  final String warehouseId;
  final double physical;
  final double reserved;

  const StockLevel({
    required this.productId,
    required this.variantId,
    required this.warehouseId,
    this.physical = 0.0,
    this.reserved = 0.0,
  });

  double get available => physical - reserved;
}
