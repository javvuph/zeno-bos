enum InventoryRuleType { tracking, reorder, safety, logic }

enum StockPolicy { fifo, lifo, fefo }

class InventoryRule {
  final String id;
  final String name;
  final InventoryRuleType type;
  final String description;
  final bool isGlobal;
  final List<String>
      targetCategories; // Apply to these categories if not global

  // POLICY FLAGS
  final bool requiresBatch;
  final bool requiresExpiry;
  final bool requiresSerial;
  final bool requiresWarranty;
  final bool allowNegativeStock;
  final bool autoReservation;
  final StockPolicy stockPolicy;

  // THRESHOLDS (Optional, can be overridden per product)
  final double? defaultMinStock;
  final double? defaultMaxStock;
  final double? safetyStockDays;

  const InventoryRule({
    required this.id,
    required this.name,
    required this.type,
    this.description = "",
    this.isGlobal = false,
    this.targetCategories = const [],
    this.requiresBatch = false,
    this.requiresExpiry = false,
    this.requiresSerial = false,
    this.requiresWarranty = false,
    this.allowNegativeStock = false,
    this.autoReservation = false,
    this.stockPolicy = StockPolicy.fifo,
    this.defaultMinStock,
    this.defaultMaxStock,
    this.safetyStockDays,
  });

  String get typeLabel => type.name.toUpperCase();
}
