class SupplierRelationship {
  final String id;
  final String supplierName;
  final String? supplierSku;
  final String? supplierProductName;
  final double purchaseCost;
  final int moq;
  final int leadTime;
  final String? paymentTerms;
  final String? notes;
  final bool isPrimary;

  const SupplierRelationship({
    required this.id,
    required this.supplierName,
    this.supplierSku,
    this.supplierProductName,
    this.purchaseCost = 0.0,
    this.moq = 0,
    this.leadTime = 0,
    this.paymentTerms,
    this.notes,
    this.isPrimary = false,
  });

  SupplierRelationship copyWith({
    String? id,
    String? supplierName,
    String? supplierSku,
    String? supplierProductName,
    double? purchaseCost,
    int? moq,
    int? leadTime,
    String? paymentTerms,
    String? notes,
    bool? isPrimary,
  }) {
    return SupplierRelationship(
      id: id ?? this.id,
      supplierName: supplierName ?? this.supplierName,
      supplierSku: supplierSku ?? this.supplierSku,
      supplierProductName: supplierProductName ?? this.supplierProductName,
      purchaseCost: purchaseCost ?? this.purchaseCost,
      moq: moq ?? this.moq,
      leadTime: leadTime ?? this.leadTime,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      notes: notes ?? this.notes,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
