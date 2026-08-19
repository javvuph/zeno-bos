class SerialNumber {
  final String id;
  final String productId;
  final String variantId;
  final String serial;
  final String? batchId;
  final String status; // 'available', 'sold', 'damaged', etc.

  const SerialNumber({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.serial,
    this.batchId,
    this.status = 'available',
  });
}
