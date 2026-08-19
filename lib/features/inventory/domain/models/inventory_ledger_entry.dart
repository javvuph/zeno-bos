class InventoryLedgerEntry {
  final String id;
  final String productId;
  final String? variantId;
  final String warehouseId;
  final String? binId;
  final String? batchNumber;
  final String? serialNumber;

  // QUANTITIES
  final double quantityOnHand;
  final double quantityReserved;
  final double quantityInTransit;
  final double quantityDamaged;
  final double quantityExpired;

  // VALUATION
  final double lastCost;
  final double averageCost;

  // TELEMETRY
  final DateTime lastMovementDate;
  final String lastTransactionId;

  const InventoryLedgerEntry({
    required this.id,
    required this.productId,
    this.variantId,
    required this.warehouseId,
    this.binId,
    this.batchNumber,
    this.serialNumber,
    this.quantityOnHand = 0.0,
    this.quantityReserved = 0.0,
    this.quantityInTransit = 0.0,
    this.quantityDamaged = 0.0,
    this.quantityExpired = 0.0,
    this.lastCost = 0.0,
    this.averageCost = 0.0,
    required this.lastMovementDate,
    required this.lastTransactionId,
  });

  double get availableQuantity => quantityOnHand - quantityReserved;

  InventoryLedgerEntry copyWith({
    double? quantityOnHand,
    double? quantityReserved,
    double? quantityInTransit,
    double? quantityDamaged,
    double? quantityExpired,
    double? lastCost,
    double? averageCost,
    DateTime? lastMovementDate,
    String? lastTransactionId,
  }) {
    return InventoryLedgerEntry(
      id: id,
      productId: productId,
      variantId: variantId,
      warehouseId: warehouseId,
      binId: binId,
      batchNumber: batchNumber,
      serialNumber: serialNumber,
      quantityOnHand: quantityOnHand ?? this.quantityOnHand,
      quantityReserved: quantityReserved ?? this.quantityReserved,
      quantityInTransit: quantityInTransit ?? this.quantityInTransit,
      quantityDamaged: quantityDamaged ?? this.quantityDamaged,
      quantityExpired: quantityExpired ?? this.quantityExpired,
      lastCost: lastCost ?? this.lastCost,
      averageCost: averageCost ?? this.averageCost,
      lastMovementDate: lastMovementDate ?? this.lastMovementDate,
      lastTransactionId: lastTransactionId ?? this.lastTransactionId,
    );
  }
}
