import '../product.dart';
import '../sku.dart';
import '../barcode.dart';
import '../category.dart';
import '../brand.dart';
import '../unit.dart';
import '../tax_profile.dart';
import '../product_variant.dart';
import '../product_enums.dart';
import '../batch.dart';
import '../supplier_relationship.dart';
import '../product_industry_fields.dart';

extension ProductCopyWith on Product {
  Product copyWith({
    String? name, String? description, SKU? sku, Barcode? barcode, Category? category,
    Brand? brand, Unit? unit, TaxProfile? taxProfile, List<ProductVariant>? variants,
    List<Batch>? batches, List<SupplierRelationship>? supplierRelationships,
    double? basePrice, double? baseCost, double? mrp, double? wholesalePrice,
    double? discountPct, double? discountAmount, double? openingStock,
    String? warehouseLocation, DateTime? updatedAt, ItemType? itemType,
    ProductStatus? status, String? manufacturer, List<String>? tags,
    double? minStock, double? maxStock, double? reorderLevel, bool? batchTracking,
    bool? serialTracking, List<String>? supplierIds, String? supplierProductName,
    String? supplierProductCode, double? supplierPurchaseCost, int? supplierMOQ,
    int? supplierLeadTime, String? secondarySupplier, String? supplierPaymentTerms,
    String? supplierContact, String? supplierNotes, String? businessType,
    String? businessCategory, String? gstTaxMode, String? packageType,
    int? unitsPerPackage, double? packageQuantity, String? stockUnit,
    double? conversionFactor, Map<String, dynamic>? customFields,
    ProductIndustryFields? industry,
  }) {
    return Product(
      id: id, name: name ?? this.name, description: description ?? this.description,
      sku: sku ?? this.sku, barcode: barcode ?? this.barcode,
      category: category ?? this.category, brand: brand ?? this.brand,
      unit: unit ?? this.unit, taxProfile: taxProfile ?? this.taxProfile,
      variants: variants ?? this.variants, batches: batches ?? this.batches,
      supplierRelationships: supplierRelationships ?? this.supplierRelationships,
      basePrice: basePrice ?? this.basePrice, baseCost: baseCost ?? this.baseCost,
      mrp: mrp ?? this.mrp, wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      discountPct: discountPct ?? this.discountPct, discountAmount: discountAmount ?? this.discountAmount,
      openingStock: openingStock ?? this.openingStock, warehouseLocation: warehouseLocation ?? this.warehouseLocation,
      createdAt: createdAt, updatedAt: updatedAt ?? this.updatedAt,
      itemType: itemType ?? this.itemType, status: status ?? this.status,
      manufacturer: manufacturer ?? this.manufacturer, tags: tags ?? this.tags,
      minStock: minStock ?? this.minStock, maxStock: maxStock ?? this.maxStock,
      reorderLevel: reorderLevel ?? this.reorderLevel, batchTracking: batchTracking ?? this.batchTracking,
      serialTracking: serialTracking ?? this.serialTracking, supplierIds: supplierIds ?? this.supplierIds,
      supplierProductName: supplierProductName ?? this.supplierProductName,
      supplierProductCode: supplierProductCode ?? this.supplierProductCode,
      supplierPurchaseCost: supplierPurchaseCost ?? this.supplierPurchaseCost,
      supplierMOQ: supplierMOQ ?? this.supplierMOQ, supplierLeadTime: supplierLeadTime ?? this.supplierLeadTime,
      secondarySupplier: secondarySupplier ?? this.secondarySupplier,
      supplierPaymentTerms: supplierPaymentTerms ?? this.supplierPaymentTerms,
      supplierContact: supplierContact ?? this.supplierContact, supplierNotes: supplierNotes ?? this.supplierNotes,
      businessType: businessType ?? this.businessType, businessCategory: businessCategory ?? this.businessCategory,
      gstTaxMode: gstTaxMode ?? this.gstTaxMode, packageType: packageType ?? this.packageType,
      unitsPerPackage: unitsPerPackage ?? this.unitsPerPackage, packageQuantity: packageQuantity ?? this.packageQuantity,
      stockUnit: stockUnit ?? this.stockUnit, conversionFactor: conversionFactor ?? this.conversionFactor,
      customFields: customFields ?? this.customFields,
      industry: industry ?? this.industry,
    );
  }
}
