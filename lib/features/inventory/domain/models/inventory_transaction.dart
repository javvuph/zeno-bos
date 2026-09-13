enum InventoryTransactionType {
  openingStock,
  purchaseReceipt, // GRN
  salesIssue,
  stockTransfer,
  stockAdjustment,
  stockReservation,
  stockRelease,
  customerReturn,
  supplierReturn,
  damagedStock,
  lostStock,
  expiredStock,
  productionConsumption,
  productionOutput,
  physicalCountAdjustment
}

enum TransactionStatus { pending, completed, cancelled, approved }

class InventoryTransaction {
  final String id;
  final InventoryTransactionType type;
  final DateTime timestamp;

  // PRIMARY LINKS
  final String productId;
  final String? variantId;
  final String warehouseId;
  final String? binId;

  // QUANTITY & VALUE
  final double quantity;
  final String unitId;
  final double? unitCost;
  final double? sellingPrice;

  // TRACKING DATA
  final String? batchNumber;
  final String? serialNumber;
  final DateTime? expiryDate;

  // GOVERNANCE
  final String? referenceDocument; // e.g., PO-9921, INV-8821
  final String userId;
  final String branchId;
  final TransactionStatus status;
  final TransactionStatus approvalStatus;

  // INTELLIGENCE & AUDIT
  final List<String> aiFlags; // e.g., ["abnormal_qty", "price_deviation"]
  final List<String> auditTrail;

  const InventoryTransaction({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.productId,
    this.variantId,
    required this.warehouseId,
    this.binId,
    required this.quantity,
    required this.unitId,
    this.unitCost,
    this.sellingPrice,
    this.batchNumber,
    this.serialNumber,
    this.expiryDate,
    this.referenceDocument,
    required this.userId,
    required this.branchId,
    this.status = TransactionStatus.completed,
    this.approvalStatus = TransactionStatus.approved,
    this.aiFlags = const [],
    this.auditTrail = const [],
  });

  String get typeLabel =>
      type.name.replaceAll(RegExp(r'(?=[A-Z])'), ' ').toUpperCase();
}
