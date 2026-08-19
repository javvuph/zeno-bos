import '../models/stock_level.dart';
import '../models/stock_transaction.dart';
import '../models/batch.dart';
import '../models/reorder_rule.dart';

class InventoryBusinessLogic {
  /// Calculates the current available stock for a specific level
  double calculateAvailable(StockLevel level) {
    return level.physical - level.reserved;
  }

  /// Validates if a stock outward transaction is possible
  bool canProcessOutward(StockLevel level, double quantity) {
    return calculateAvailable(level) >= quantity;
  }

  /// Generates a Stock Transaction for an inward movement
  StockTransaction createStockIn({
    required String stockItemId,
    required double quantity,
    required TransactionType type,
    required String userId,
    String? referenceId,
  }) {
    return StockTransaction(
      id: 'trx-${DateTime.now().millisecondsSinceEpoch}',
      stockItemId: stockItemId,
      quantityDelta: quantity.abs(),
      type: type,
      referenceId: referenceId,
      timestamp: DateTime.now(),
      userId: userId,
      notes: "Stock In via ${type.name}",
    );
  }

  /// Generates a Stock Transaction for an outward movement
  StockTransaction createStockOut({
    required String stockItemId,
    required double quantity,
    required TransactionType type,
    required String userId,
    String? referenceId,
  }) {
    return StockTransaction(
      id: 'trx-${DateTime.now().millisecondsSinceEpoch}',
      stockItemId: stockItemId,
      quantityDelta: -quantity.abs(),
      type: type,
      referenceId: referenceId,
      timestamp: DateTime.now(),
      userId: userId,
      notes: "Stock Out via ${type.name}",
    );
  }

  /// Evaluates reorder rules and returns true if reorder is needed
  bool shouldReorder(StockLevel level, ReorderRule rule) {
    return calculateAvailable(level) <= rule.reorderPoint;
  }

  /// FEFO (First Expired, First Out) Allocation Logic
  List<Batch> sortByExpiry(List<Batch> batches) {
    final sorted = List<Batch>.from(batches);
    sorted.sort((a, b) {
      if (a.expiryDate == null) return 1;
      if (b.expiryDate == null) return -1;
      return a.expiryDate!.compareTo(b.expiryDate!);
    });
    return sorted;
  }

  /// Generates an audit trail message for a transaction
  String generateAuditLog(StockTransaction trx) {
    final direction = trx.quantityDelta > 0 ? "ADD" : "REMOVE";
    return "[AUDIT] ${trx.timestamp.toIso8601String()} | USER: ${trx.userId} | ACTION: ${trx.type.name} | DELTA: $direction ${trx.quantityDelta.abs()}";
  }
}
