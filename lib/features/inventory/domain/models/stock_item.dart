class StockItem {
  final String id;
  final String productId;
  final String variantId;
  final String warehouseId;
  final String? locationId; // The specific Bin ID
  final String? batchId;
  final String? serialNumberId;

  const StockItem({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.warehouseId,
    this.locationId,
    this.batchId,
    this.serialNumberId,
  });
}
