part of '../product_studio_controller.dart';

extension ProductStudioControllerLogic on ProductStudioController {
  void _initMD() {
    departmentsList.addAll(md.getDepartments().map((e)=>e.name));
    categoriesList.addAll(md.getCategories().map((e)=>e.name));
    brandsList.addAll(md.getBrands().map((e)=>e.name));
    unitsList.addAll(md.getUnits().map((e)=>e.name));
    locationsList.addAll(["Main HQ", "WH 1"]);
    suppliersList.addAll(["Main Supplier", "Global Corp"]);
    subcategoriesList.addAll(["Mens", "Womens", "Kids"]);
  }

  void updateProduct(ProductStudioData p) { _product = p; notify(); }
  void resetProduct() { 
    hasManualSkuOverride = false;
    _product = ProductStudioData.empty(); 
    _loadBusinessConfig(); 
    notify(); 
  }
  void setCreationMode(ProductCreationMode m) { _mode = m; notify(); }
  void setSection(ProductStudioSection s) { _activeSection = s; notify(); }
  void setTab(AuroraStudioTab t) { _activeTab = t; notify(); }
  void toggleViewMode() {
    isAdvancedMode = !isAdvancedMode;
    if (!isAdvancedMode) {
      _activeTab = AuroraStudioTab.identity;
      _activeSection = ProductStudioSection.fashionBasic;
    } else {
      _activeTab = AuroraStudioTab.identity;
      _activeSection = ProductStudioSection.fashionBasic;
    }
    notify();
  }
  void toggleFullscreen() { isFullscreen = !isFullscreen; notify(); }
  void setSaving(bool v) { isSaving = v; notify(); }

  void updateBusinessType(String t) {
    if (sub.businessCategoryMap.containsKey(t)) {
      _product.businessType = t;
      _product.businessCategory = sub.businessCategoryMap[t]!.first;
      notify();
    }
  }

  void updateBusinessCategory(String c) { _product.businessCategory = c; notify(); }
  void updateBusinessScale(BusinessScale? s) { _product.businessScale = s ?? BusinessScale.small; notify(); }

  bool isSectionVisible(ProductStudioSection s) {
    if (!isAdvancedMode) {
      // Basic Mode: Render 2 primary tabs (Basic Info & Variants)
      return s == ProductStudioSection.basic ||
             s == ProductStudioSection.fashionBasic ||
             s == ProductStudioSection.variants;
    }
    if (_product.businessType.toUpperCase() == "FASHION") {
      return getFashionCapabilities(_product.businessScale ?? BusinessScale.small).contains(s);
    }
    return (cap.categoryCapabilityRegistry[_product.businessCategory] ?? cap.businessTypeCapabilities[_product.businessType] ?? []).contains(s);
  }

  bool isFieldVisible(String f) {
    if (isAdvancedMode) return true;

    // Essential basic fields are ALWAYS visible in Basic Mode
    const basicFields = {
      'title', 'sku', 'barcode', 'category', 'brand',
      'costPrice', 'sellingPrice', 'mrp', 'discountValue',
      'reorderLevel', 'openingStock', 'primaryImage'
    };
    if (basicFields.contains(f)) return true;

    final categoryFields = field.categoryFieldRegistry[_product.businessCategory] ?? [];
    if (categoryFields.contains(f)) return true;
    
    final scaleFields = field.scaleFieldRegistry[_product.businessScale] ?? [];
    if (scaleFields.contains(f)) return true;
    
    return false;
  }
  bool isSectionComplete(ProductStudioSection s) => _product.title.isNotEmpty;

  void nextSection() {
    final sections = ProductStudioSection.values.where((s) => isSectionVisible(s)).toList();
    final currentIdx = sections.indexOf(_activeSection);
    if (currentIdx >= 0 && currentIdx < sections.length - 1) {
      setSection(sections[currentIdx + 1]);
    }
  }

  Future<void> saveProduct([BuildContext? context]) async {
    await _persistProduct(ProductLifecycleState.published, context, resetAfterSave: true);
  }

  Future<void> saveDraft([BuildContext? context]) async {
    await _persistProduct(ProductLifecycleState.draft, context);
  }

  Future<void> _persistProduct(
    ProductLifecycleState lifecycleState,
    BuildContext? context, {
    bool resetAfterSave = false,
  }) async {
    setSaving(true);
    try {
      _product.lifecycleState = lifecycleState;
      final productToSave = _product.toDomain();
      await repository.saveProduct(productToSave);
      final listController = ProductController.lastInstance;
      if (listController != null) {
        await listController.refreshProducts();
      }
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product saved successfully")),
        );
      }
      if (resetAfterSave) {
        resetToNew();
      } else {
        notify();
      }
    } catch (e) {
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save product: $e")),
        );
      }
      rethrow;
    } finally {
      setSaving(false);
    }
  }

  void resetToNew() { resetProduct(); selectedSizes.clear(); selectedColors.clear(); notify(); }

  void updatePrice(double p) { _product.sellingPrice = p; notify(); }
  void updateCost(double c) { _product.costPrice = c; notify(); }
  void addDepartment(String n) { if (!departmentsList.contains(n)) { departmentsList.add(n); notify(); } }
  void addWarehouse(String n) { if (!locationsList.contains(n)) { locationsList.add(n); notify(); } }
  void addCategory(String n) { if (!categoriesList.contains(n)) { categoriesList.add(n); notify(); } }
  void addBrand(String n) { if (!brandsList.contains(n)) { brandsList.add(n); notify(); } }
  void addSupplier(String n) { if (!suppliersList.contains(n)) { suppliersList.add(n); notify(); } }
  void addSubcategory(String n) { if (!subcategoriesList.contains(n)) { subcategoriesList.add(n); notify(); } }
  void addUnit(String n) { if (!unitsList.contains(n)) { unitsList.add(n); notify(); } }
  void addTaxJurisdiction(String n) { if (!jurisdictionsList.contains(n)) { jurisdictionsList.add(n); notify(); } }

  Future<void> pickPrimaryImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.isNotEmpty && result.files.first.path != null) {
        _product.primaryImageUrl = result.files.first.path!;
        notify();
      }
    } catch (e) {
      debugPrint("Error picking primary image: $e");
    }
  }

  void generateSuggestedSKU() {
    final normalizedTitle = _product.title.trim();
    if (normalizedTitle.isEmpty) return;

    final compact = normalizedTitle
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '')
        .toUpperCase();
    if (compact.isEmpty) return;

    final base = compact.length > 18 ? compact.substring(0, 18) : compact;
    final suffix = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
    _product.sku = "$base-$suffix";
    notify();
  }
  void generateSuggestedBarcode() { _product.barcode = (100000000000 + (DateTime.now().millisecondsSinceEpoch % 899999999999)).toString(); notify(); }

  void maybeAutoGenerateSkuFromTitle(String title) {
    _product.title = title;

    final normalizedTitle = title.trim();
    final currentSku = _product.sku.trim();
    final canAutoGenerate = !hasManualSkuOverride || currentSku.isEmpty;

    if (normalizedTitle.isNotEmpty && canAutoGenerate) {
      final compact = normalizedTitle
          .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '-')
          .replaceAll(RegExp(r'-+'), '-')
          .replaceAll(RegExp(r'^-|-$'), '')
          .toUpperCase();
      if (compact.isNotEmpty) {
        final base = compact.length > 18 ? compact.substring(0, 18) : compact;
        final suffix = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
        _product.sku = "$base-$suffix";
      }
    }

    notify();
  }

  Future<void> addToGallery() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          if (file.path != null) {
            _product.galleryUrls.add(file.path!);
          }
        }
        notify();
      }
    } catch (e) {
      debugPrint("Error adding to gallery: $e");
    }
  }

  void removeGalleryImage(int i) { if (i >= 0 && i < _product.galleryUrls.length) { _product.galleryUrls.removeAt(i); notify(); } }

  void analyzeFashionImage() {
    _product.material = "100% Cotton";
    _product.patternDesign = "Solid / Plain";
    _product.fitType = "Regular Fit";
    _product.sleeveNeckType = "Crew Neck";
    notify();
  }

  String applyAIPayloadToStudio(Map<String, dynamic> json) {
    if (json.isEmpty) return "Could not parse AI payload";

    // 1. Populate Tab 1 & Basic Product Data
    if (json.containsKey('product_name') && json['product_name'].toString().isNotEmpty) {
      _product.title = json['product_name'].toString();
    }
    if (json.containsKey('category') && json['category'].toString().isNotEmpty) {
      _product.category = json['category'].toString();
    }
    if (json.containsKey('brand') && json['brand'].toString().isNotEmpty) {
      _product.brand = json['brand'].toString();
    }
    if (json.containsKey('cost_price')) {
      _product.costPrice = double.tryParse(json['cost_price'].toString()) ?? 0.0;
    }
    if (json.containsKey('selling_price')) {
      _product.sellingPrice = double.tryParse(json['selling_price'].toString()) ?? 0.0;
    } else if (_product.costPrice > 0) {
      _product.sellingPrice = (_product.costPrice * 1.6).roundToDouble();
    }
    if (json.containsKey('hsn_code')) {
      _product.hsnCode = json['hsn_code'].toString();
    }
    if (json.containsKey('tax_rate_percentage')) {
      _product.taxRate = double.tryParse(json['tax_rate_percentage'].toString()) ?? 0.0;
    }
    if (json.containsKey('low_stock_threshold')) {
      _product.reorderLevel = double.tryParse(json['low_stock_threshold'].toString()) ?? 0.0;
    }

    // 2. Populate Tab 2 & Variants Matrix
    int variantCount = 0;
    if (json.containsKey('variants') && json['variants'] is List) {
      final variantsList = json['variants'] as List;
      for (final v in variantsList) {
        if (v is Map<String, dynamic>) {
          final color = (v['color'] ?? v['colour'] ?? "").toString();
          final size = (v['size'] ?? "").toString();

          if (color.isNotEmpty && !selectedColors.contains(color)) {
            selectedColors.add(color);
          }
          if (size.isNotEmpty && !selectedSizes.contains(size)) {
            selectedSizes.add(size);
          }
          variantCount++;
        }
      }
      generateMatrix();

      for (int i = 0; i < generatedVariants.length && i < variantsList.length; i++) {
        final v = variantsList[i] as Map<String, dynamic>;
        if (v.containsKey('stock_quantity')) {
          updateVariantField(i, stock: int.tryParse(v['stock_quantity'].toString()));
        }
        if (v.containsKey('cost_price')) {
          updateVariantField(i, purchasePrice: double.tryParse(v['cost_price'].toString()));
        }
        if (v.containsKey('selling_price')) {
          updateVariantField(i, price: double.tryParse(v['selling_price'].toString()));
        }
        if (v.containsKey('sku') && v['sku'].toString().isNotEmpty) {
          updateVariantField(i, sku: v['sku'].toString());
        }
      }
    }

    notify();
    final totalStock = json['total_calculated_stock'] ?? calculatedTotalStock;
    return "✨ Gemini auto-filled ${variantCount > 0 ? '$variantCount variants' : 'product details'} ($totalStock items total). Ready to Save!";
  }

  void addNewBatch() { _product.batches.add(model.Batch(id: "B${_product.batches.length + 1}", batchNumber: "BN-${DateTime.now().millisecond}", manufacturingDate: DateTime.now(), expiryDate: DateTime.now().add(const Duration(days: 365)), quantity: 0)); notify(); }
  void updateBatch(int i, {String? batchNumber, DateTime? mfgDate, DateTime? expiryDate, double? quantity}) {
    if (i >= 0 && i < _product.batches.length) {
      _product.batches[i] = _product.batches[i].copyWith(batchNumber: batchNumber, manufacturingDate: mfgDate, expiryDate: expiryDate, quantity: quantity);
      notify();
    }
  }
  void removeBatch(int i) { if (i >= 0 && i < _product.batches.length) { _product.batches.removeAt(i); notify(); } }

  void addModifierGroup(String name) { _product.modifierGroups.add(name); notify(); }
  void removeModifierGroup(String name) { _product.modifierGroups.remove(name); notify(); }
  void addRecipeIngredient() { _product.recipeBOM.add(RecipeIngredient(id: "RI-${DateTime.now().millisecond}", ingredientName: "New Ingredient", quantity: 1, unit: "Pc")); notify(); }
  void removeRecipeIngredient(String id) { _product.recipeBOM.removeWhere((i) => i.id == id); notify(); }

  void startManualCreationFromScan([dynamic item]) {
    if (item is ProductStudioData) updateProduct(item);
    else if (item is String) { resetProduct(); _product.barcode = item; }
    setCreationMode(ProductCreationMode.manual);
    setSection(ProductStudioSection.basic);
  }

  Map<String, dynamic> get currentTaxConfig => {
    "gstEnabled": true, "defaultRate": 18.0, "taxName": "GST", "codeLabel": "HSN/SAC Code", "showGSTMode": true,
    "statuses": ["Taxable", "Non-Taxable", "Exempt"], "categories": ["Standard", "Zero Rated", "Nil Rated"],
    "gstModes": ["Intra-State", "Inter-State"]
  };
  
  Map<String, List<String>> get businessCategoryMap => sub.businessCategoryMap;

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
    if (bType == "FASHION") standard = field.fashionStandard;
    else if (bType == "FOOD & BEVERAGE") standard = field.fnbStandard;
    else if (bType == "HEALTHCARE") standard = field.healthcareStandard;
    else standard = field.retailStandard;

    return tab1Fields.where((f) => standard.contains(f)).toList();
  }

  List<String> getTab1SpecFields() {
    final tab1Fields = getFieldsForTab(AuroraStudioTab.identity);
    final core = getTab1CoreFields();
    final List<String> excluded;
    if (_product.businessType == "Food & Beverage") excluded = ["kotStation", "kdsCategory", "courseFireDelay", "recipeVersion", "targetFoodCostPct", "recipePrepNotes"];
    else if (_product.businessType == "Retail") excluded = ["unit", "purchaseUnit", "conversionFactor", "unitsPerStrip", "masterOuterBarcode", "palletStacking", "grossWeight", "unitDimensions", "isEasTagRequired", "allowLooseBilling", "inHouseRepack", "containerDepositFee"];
    else if (_product.businessType == "Healthcare") excluded = ["enableBatchTracking", "enableExpiryTracking", "expiryWarningThreshold", "freshnessDuration", "freshnessUnit", "coldStorageIndicator"];
    else excluded = [];

    return tab1Fields.where((f) => !core.contains(f) && !excluded.contains(f)).toList();
  }

  List<String> getTab3Fields() {
    final fields = getFieldsForTab(AuroraStudioTab.pricing);
    // Add any statutory exclusions if engines handle them
    return fields;
  }

  List<String> getTab4Fields() {
    final fields = getFieldsForTab(AuroraStudioTab.stock);
    final List<String> excluded;
    if (_product.businessType == "Retail") excluded = ["unit", "purchaseUnit", "conversionFactor", "unitsPerStrip", "masterOuterBarcode", "palletStacking", "grossWeight", "unitDimensions", "freshnessDuration", "freshnessUnit", "coldStorageIndicator"];
    else if (_product.businessType == "Healthcare") excluded = ["enableBatchTracking", "enableExpiryTracking", "expiryWarningThreshold", "freshnessDuration", "freshnessUnit", "coldStorageIndicator"];
    else excluded = [];
    return fields.where((f) => !excluded.contains(f)).toList();
  }

  List<String> getTab5Fields() => getFieldsForTab(AuroraStudioTab.media);
}
