class SupplierRating {
  final double overallScore; // 0.0 to 1.0
  final double qualityScore;
  final double deliveryScore;
  final double valueScore;
  final int perfectOrderCount;
  final int totalOrderCount;

  const SupplierRating({
    this.overallScore = 0.0,
    this.qualityScore = 0.0,
    this.deliveryScore = 0.0,
    this.valueScore = 0.0,
    this.perfectOrderCount = 0,
    this.totalOrderCount = 0,
  });
}
