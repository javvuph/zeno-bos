part of '../product_studio_controller.dart';

extension ProductStudioControllerLogicFields on ProductStudioController {
  List<String> getOrderedFields() {
    var categoryFields = field.categoryFieldRegistry[_product.businessCategory];
    if (categoryFields == null || categoryFields.isEmpty) {
      final canonical = field.resolveCanonicalProfile(_product.businessCategory);
      categoryFields = field.categoryFieldRegistry[canonical];
    }
    if (categoryFields == null || categoryFields.isEmpty) {
      final bType = _product.businessType.toUpperCase();
      if (bType == "FASHION" || bType == "CLOTHING") {
        categoryFields = field.categoryFieldRegistry["Clothing"] ?? field.fashionStandard;
      } else if (bType == "FOOD & BEVERAGE" || bType == "FOOD" || bType == "F&B") {
        categoryFields = field.fnbStandard;
      } else if (bType == "HEALTHCARE" || bType == "PHARMACY") {
        categoryFields = field.healthcareStandard;
      } else {
        categoryFields = field.retailStandard;
      }
    }
    final scaleFields = field.scaleFieldRegistry[_product.businessScale] ?? [];
    final allFields = <String>[];

    for (final f in categoryFields) {
      if (!allFields.contains(f)) allFields.add(f);
    }
    for (final f in scaleFields) {
      if (!allFields.contains(f)) allFields.add(f);
    }

    const common = ["costPrice", "sellingPrice", "mrp", "wholesalePrice", "openingStock"];
    for (final f in common) {
      if (!allFields.contains(f)) allFields.add(f);
    }

    final preferredOrder = <String>[
      'title',
      'sku',
      'barcode',
      'brand',
      'category',
      'subcategory',
      'department',
      'subDepartment',
      'supplier',
      'status',
      'costPrice',
      'sellingPrice',
      'mrp',
      'wholesalePrice',
      'taxCode',
      'openingStock',
      'unit',
      'stockUnit',
      'purchaseUnit',
      'warehouseLocation',
      'material',
      'color',
      'sizeScale',
      'gender',
      'season',
      'description',
      'arabicTitle',
      'countryOfOrigin',
      'returnPolicy',
      'discountType',
      'discountValue',
      'safetyStock',
      'reorderLevel',
      'marketingTitle',
      'urlSlug',
      'metaDescription',
      'primaryImageUrl',
      'galleryUrls',
    ];

    final ordered = <String>[];
    for (final fieldId in preferredOrder) {
      if (allFields.contains(fieldId) && !ordered.contains(fieldId)) {
        ordered.add(fieldId);
      }
    }
    for (final fieldId in allFields) {
      if (!ordered.contains(fieldId)) {
        ordered.add(fieldId);
      }
    }

    return ordered;
  }

  List<String> getBulkEntryFields() {
    return const [
      'title',
      'category',
      'brand',
      'color',
      'sizeScale',
      'sku',
      'barcode',
      'costPrice',
      'sellingPrice',
      'mrp',
      'openingStock',
      'discountValue',
      'hsnCode',
      'supplier',
      'description',
    ];
  }

  String getFieldLabel(String fieldId) {
    switch (fieldId) {
      case 'title': return 'PRODUCT NAME';
      case 'category': return 'CATEGORY';
      case 'brand': return 'BRAND';
      case 'color': return 'COLOUR';
      case 'sizeScale': return 'SIZE';
      case 'sku': return 'SKU / STYLE CODE';
      case 'barcode': return 'BARCODE / GTIN';
      case 'costPrice': return 'COST PRICE (₹)';
      case 'sellingPrice': return 'SALE PRICE (₹)';
      case 'mrp': return 'MRP (₹)';
      case 'openingStock': return 'QUANTITY / STOCK';
      case 'discountValue': return 'DISCOUNT (%)';
      case 'hsnCode': return 'HSN TAX CODE';
      case 'supplier': return 'SUPPLIER';
      case 'description': return 'DESCRIPTION';
      default:
        return field.fieldLabels[fieldId] ?? 
               fieldId.replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}').toUpperCase();
    }
  }

  double calculateCompletionPercentage() {
    final requiredFields = ["title", "sku", "brand", "category", "sellingPrice", "warehouseLocation"];
    int filled = 0;
    for (var f in requiredFields) {
      final val = getFieldValueById(_product, f);
      if (val != null && val.toString().isNotEmpty && val.toString() != "0" && val.toString() != "0.0") {
        filled++;
      }
    }
    return filled / requiredFields.length;
  }

  List<String> getFieldsForTab(AuroraStudioTab tab) {
    final List<String> allFields;
    if (isClothingSmallProfile) {
      final categoryFields = field.categoryFieldRegistry[_product.businessCategory] ?? [];
      allFields = List<String>.from(categoryFields);
      final scaleFields = field.scaleFieldRegistry[_product.businessScale] ?? [];
      for (final fieldId in scaleFields) {
        if (!allFields.contains(fieldId)) {
          allFields.add(fieldId);
        }
      }
      const common = ["costPrice", "sellingPrice", "mrp", "wholesalePrice", "openingStock"];
      for (final fieldId in common) {
        if (!allFields.contains(fieldId)) {
          allFields.add(fieldId);
        }
      }
    } else {
      allFields = getOrderedFields();
    }
    return allFields.where((f) => getTabForField(f) == tab).toList();
  }

  List<String> getTab1CoreFields() {
    final tab1Fields = getFieldsForTab(AuroraStudioTab.identity);
    final List<String> standard;
    final bType = _product.businessType.toUpperCase();
    if (bType == "FASHION") {
      standard = field.fashionStandard;
    } else if (bType == "FOOD & BEVERAGE") standard = field.fnbStandard;
    else if (bType == "HEALTHCARE") standard = field.healthcareStandard;
    else standard = field.retailStandard;

    return tab1Fields.where((f) => standard.contains(f)).toList();
  }

  List<String> getTab1SpecFields() {
    final tab1Fields = getFieldsForTab(AuroraStudioTab.identity);
    final core = getTab1CoreFields();
    final List<String> excluded;
    if (_product.businessType == "Food & Beverage") {
      excluded = ["kotStation", "kdsCategory", "courseFireDelay", "recipeVersion", "targetFoodCostPct", "recipePrepNotes"];
    } else if (_product.businessType == "Retail") excluded = ["unit", "purchaseUnit", "conversionFactor", "unitsPerStrip", "masterOuterBarcode", "palletStacking", "grossWeight", "unitDimensions", "isEasTagRequired", "allowLooseBilling", "inHouseRepack", "containerDepositFee"];
    else if (_product.businessType == "Healthcare") excluded = ["enableBatchTracking", "enableExpiryTracking", "expiryWarningThreshold", "freshnessDuration", "freshnessUnit", "coldStorageIndicator"];
    else excluded = [];

    return tab1Fields.where((f) => !core.contains(f) && !excluded.contains(f)).toList();
  }

  List<String> getTab3Fields() {
    final fields = getFieldsForTab(AuroraStudioTab.pricing);
    return fields;
  }

  List<String> getTab4Fields() {
    final fields = getFieldsForTab(AuroraStudioTab.stock);
    final List<String> excluded;
    if (_product.businessType == "Retail") {
      excluded = ["unit", "purchaseUnit", "conversionFactor", "unitsPerStrip", "masterOuterBarcode", "palletStacking", "grossWeight", "unitDimensions", "freshnessDuration", "freshnessUnit", "coldStorageIndicator"];
    } else if (_product.businessType == "Healthcare") excluded = ["enableBatchTracking", "enableExpiryTracking", "expiryWarningThreshold", "freshnessDuration", "freshnessUnit", "coldStorageIndicator"];
    else excluded = [];
    return fields.where((f) => !excluded.contains(f)).toList();
  }

  List<String> getTab5Fields() => getFieldsForTab(AuroraStudioTab.media);
}
