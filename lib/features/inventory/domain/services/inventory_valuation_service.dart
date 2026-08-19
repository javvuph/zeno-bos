import '../models/batch.dart';

enum ValuationMethod { fifo, wac }

class InventoryValuationService {
  double calculateFIFO(List<Batch> batches, double currentStock) {
    double totalValue = 0;
    double remainingToValue = currentStock;

    // Sort batches by manufacturing date (newest first for valuation of remaining stock)
    final sortedBatches = List<Batch>.from(batches)..sort((a, b) => b.manufacturingDate.compareTo(a.manufacturingDate));

    for (var batch in sortedBatches) {
      if (remainingToValue <= 0) break;
      double qtyToTake = remainingToValue < batch.quantity ? remainingToValue : batch.quantity;
      // In a real app, we'd fetch the specific cost of this batch
      // For now we assume a mock cost field exists on batch or is inherited
      totalValue += qtyToTake * 10.0; // Mock cost
      remainingToValue -= qtyToTake;
    }
    return totalValue;
  }

  double calculateWAC(double totalPurchaseCost, double totalQuantity) {
    if (totalQuantity <= 0) return 0;
    return totalPurchaseCost / totalQuantity;
  }
}
