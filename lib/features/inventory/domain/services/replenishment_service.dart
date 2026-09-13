class ReplenishmentService {
  double calculateSalesVelocity(List<double> historicalDailySales) {
    if (historicalDailySales.isEmpty) return 0;
    return historicalDailySales.reduce((a, b) => a + b) / historicalDailySales.length;
  }

  double recommendOrderQuantity({
    required double currentStock,
    required double avgDailySales,
    required int leadTimeDays,
    required double safetyStock,
    double inTransit = 0,
    double openPoQty = 0,
    int moq = 1,
    int orderMultiple = 1,
  }) {
    double reorderPoint = (avgDailySales * leadTimeDays) + safetyStock;
    double netAvailable = currentStock + inTransit + openPoQty;

    if (netAvailable > reorderPoint) return 0;

    double needed = reorderPoint - netAvailable;
    
    // Apply MOQ
    if (needed < moq) needed = moq.toDouble();
    
    // Apply Order Multiple (Round up to nearest multiple)
    if (orderMultiple > 1) {
      needed = ((needed / orderMultiple).ceil() * orderMultiple).toDouble();
    }

    return needed;
  }

  double recommendVariantOrderQuantity({
    required double currentVariantStock,
    required double variantSalesVelocity,
    required int leadTimeDays,
    required double safetyStock,
    double inTransit = 0,
  }) {
    double reorderPoint = (variantSalesVelocity * leadTimeDays) + safetyStock;
    if (currentVariantStock + inTransit > reorderPoint) return 0;
    return reorderPoint - (currentVariantStock + inTransit);
  }
}
