class Batch {
  final String id;
  final String batchNumber;
  final DateTime manufacturingDate;
  final DateTime? expiryDate;
  final double quantity;
  final double purchaseCost;
  final double sellingPrice;
  final double mrp;
  final String? supplier;
  final String? warehouse;
  final String? notes;
  final Map<String, dynamic> attributes;

  const Batch({
    required this.id,
    required this.batchNumber,
    required this.manufacturingDate,
    this.expiryDate,
    this.quantity = 0.0,
    this.purchaseCost = 0.0,
    this.sellingPrice = 0.0,
    this.mrp = 0.0,
    this.supplier,
    this.warehouse,
    this.notes,
    this.attributes = const {},
  });

  Batch copyWith({
    String? id,
    String? batchNumber,
    DateTime? manufacturingDate,
    DateTime? expiryDate,
    double? quantity,
    double? purchaseCost,
    double? sellingPrice,
    double? mrp,
    String? supplier,
    String? warehouse,
    String? notes,
    Map<String, dynamic>? attributes,
  }) {
    return Batch(
      id: id ?? this.id,
      batchNumber: batchNumber ?? this.batchNumber,
      manufacturingDate: manufacturingDate ?? this.manufacturingDate,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      purchaseCost: purchaseCost ?? this.purchaseCost,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      mrp: mrp ?? this.mrp,
      supplier: supplier ?? this.supplier,
      warehouse: warehouse ?? this.warehouse,
      notes: notes ?? this.notes,
      attributes: attributes ?? this.attributes,
    );
  }
}
