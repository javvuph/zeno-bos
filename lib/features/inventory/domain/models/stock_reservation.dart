class StockReservation {
  final String id;
  final String productId;
  final String variantId;
  final String? warehouseId;
  final double quantity;
  final String referenceId; // Sales Order ID
  final DateTime expiryDate;
  final bool isFulfilled;

  const StockReservation({
    required this.id,
    required this.productId,
    required this.variantId,
    this.warehouseId,
    required this.quantity,
    required this.referenceId,
    required this.expiryDate,
    this.isFulfilled = false,
  });
}
