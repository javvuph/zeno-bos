import '../models/inventory_ledger_entry.dart';
import '../models/inventory_transaction.dart';
import 'package:flutter/foundation.dart';

/// InventoryLedger (IL) v1.0
/// The definitive record of stock balances.
/// Consumes ITE events to maintain a consistent current truth of inventory.
class InventoryLedgerService extends ChangeNotifier {
  final Map<String, InventoryLedgerEntry> _ledger = {};

  List<InventoryLedgerEntry> get allEntries => _ledger.values.toList();

  /// Core logic to update the ledger based on an ITE transaction
  void updateFromTransaction(InventoryTransaction tx) {
    final String key = _generateLedgerKey(tx);
    final existing = _ledger[key];

    if (existing == null) {
      _ledger[key] = InventoryLedgerEntry(
        id: "LGR-$key",
        productId: tx.productId,
        variantId: tx.variantId,
        warehouseId: tx.warehouseId,
        binId: tx.binId,
        batchNumber: tx.batchNumber,
        serialNumber: tx.serialNumber,
        quantityOnHand: tx.quantity,
        lastCost: tx.unitCost ?? 0.0,
        averageCost: tx.unitCost ?? 0.0,
        lastMovementDate: tx.timestamp,
        lastTransactionId: tx.id,
      );
    } else {
      // Calculate delta based on transaction type
      double newOnHand = existing.quantityOnHand;
      if (tx.type == InventoryTransactionType.purchaseReceipt ||
          tx.type == InventoryTransactionType.customerReturn) {
        newOnHand += tx.quantity;
      } else if (tx.type == InventoryTransactionType.salesIssue ||
          tx.type == InventoryTransactionType.damagedStock) {
        newOnHand -= tx.quantity;
      }

      _ledger[key] = existing.copyWith(
        quantityOnHand: newOnHand,
        lastCost: tx.unitCost ?? existing.lastCost,
        lastMovementDate: tx.timestamp,
        lastTransactionId: tx.id,
      );
    }
    notifyListeners();
  }

  String _generateLedgerKey(InventoryTransaction tx) {
    return "${tx.productId}_${tx.variantId ?? 'NA'}_${tx.warehouseId}_${tx.batchNumber ?? 'NA'}";
  }

  // ANALYTICS HELPERS
  double getTotalValuation() {
    return _ledger.values.fold(
        0.0, (sum, entry) => sum + (entry.quantityOnHand * entry.averageCost));
  }

  int getLowStockCount(double threshold) {
    return _ledger.values.where((e) => e.quantityOnHand < threshold).length;
  }
}
