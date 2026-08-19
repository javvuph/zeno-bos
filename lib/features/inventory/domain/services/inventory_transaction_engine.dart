import '../models/inventory_transaction.dart';
import 'package:uuid/uuid.dart';

/// InventoryTransactionEngine (ITE) v1.0
/// The standardized operational engine for every inventory movement in ZENO BOS.
class InventoryTransactionEngine {
  InventoryTransactionEngine();

  /// Standardized entry point for recording any stock movement
  Future<InventoryTransaction> processTransaction(
      InventoryTransaction tx) async {
    // 1. Logic Validation (ITE Rules)
    _validateTransaction(tx);

    // 2. Perform AI Analysis (Simulated for v1.0)
    final enrichedTx = _applyAiIntelligence(tx);

    // 3. Persist to Repository
    // Note: In v1.1 we will map this model to the repository layer
    // For now, we simulate the commit
    await Future.delayed(const Duration(milliseconds: 150));

    return enrichedTx;
  }

  void _validateTransaction(InventoryTransaction tx) {
    if (tx.quantity == 0) {
      throw Exception("Transaction quantity cannot be zero.");
    }
    if (tx.productId.isEmpty) {
      throw Exception("Product ID is required for ITE transactions.");
    }
    if (tx.warehouseId.isEmpty) throw Exception("Warehouse ID is required.");
  }

  InventoryTransaction _applyAiIntelligence(InventoryTransaction tx) {
    final List<String> flags = List.from(tx.aiFlags);

    // Example AI Rule: Detect large adjustments
    if (tx.type == InventoryTransactionType.stockAdjustment &&
        tx.quantity.abs() > 100) {
      flags.add("high_volume_adjustment");
    }

    return tx; // Return as is for now, in future will use copyWith to add flags
  }

  /// Helper to create a new transaction with standard defaults
  InventoryTransaction createTx({
    required InventoryTransactionType type,
    required String productId,
    required String warehouseId,
    required double quantity,
    required String unitId,
    required String userId,
    required String branchId,
    String? variantId,
    String? reference,
  }) {
    return InventoryTransaction(
      id: "TXN-${const Uuid().v4().substring(0, 8).toUpperCase()}",
      type: type,
      timestamp: DateTime.now(),
      productId: productId,
      variantId: variantId,
      warehouseId: warehouseId,
      quantity: quantity,
      unitId: unitId,
      userId: userId,
      branchId: branchId,
      referenceDocument: reference,
    );
  }
}
