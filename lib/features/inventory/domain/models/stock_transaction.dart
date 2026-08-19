enum TransactionType {
  inPurchase,
  inReturn,
  outSale,
  outDamaged,
  transferIn,
  transferOut,
  adjustment
}

class StockTransaction {
  final String id;
  final String stockItemId;
  final double quantityDelta;
  final TransactionType type;
  final String? referenceId; // PO ID, Sales Order ID, etc.
  final DateTime timestamp;
  final String userId;
  final String? notes;

  const StockTransaction({
    required this.id,
    required this.stockItemId,
    required this.quantityDelta,
    required this.type,
    this.referenceId,
    required this.timestamp,
    required this.userId,
    this.notes,
  });
}
