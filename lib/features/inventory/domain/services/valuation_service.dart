enum ValuationMethod { fifo, lifo, weightedAverage }

class ValuationService {
  /// Framework for calculating inventory value based on method
  double calculateValue({
    required List<InventoryLayer> layers,
    required ValuationMethod method,
  }) {
    if (layers.isEmpty) return 0.0;

    switch (method) {
      case ValuationMethod.fifo:
        return layers.fold(
            0.0, (sum, layer) => sum + (layer.quantity * layer.unitCost));
      case ValuationMethod.lifo:
        return layers.reversed
            .fold(0.0, (sum, layer) => sum + (layer.quantity * layer.unitCost));
      case ValuationMethod.weightedAverage:
        double totalQty =
            layers.fold(0.0, (sum, layer) => sum + layer.quantity);
        if (totalQty == 0) return 0.0;
        double totalCost = layers.fold(
            0.0, (sum, layer) => sum + (layer.quantity * layer.unitCost));
        return totalCost / totalQty;
    }
  }
}

class InventoryLayer {
  final DateTime timestamp;
  final double quantity;
  final double unitCost;

  const InventoryLayer({
    required this.timestamp,
    required this.quantity,
    required this.unitCost,
  });
}
