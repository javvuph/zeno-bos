part of '../product_studio_controller.dart';

extension ProductStudioControllerLogic on ProductStudioController {
  void _initMD() {
    categoriesList.addAll(md.getCategories().map((e)=>e.name));
    brandsList.addAll(md.getBrands().map((e)=>e.name));
    unitsList.addAll(md.getUnits().map((e)=>e.name));
    locationsList.addAll(["Main HQ", "WH 1"]);
    suppliersList.addAll(["Main Supplier", "Global Corp"]);
    subcategoriesList.addAll(["Mens", "Womens", "Kids"]);
  }

  void updateProduct(ProductStudioData p) { _product = p; notify(); }
  void resetProduct() { _product = ProductStudioData.empty(); notify(); }
  void setCreationMode(ProductCreationMode m) { _mode = m; notify(); }
  void setSection(ProductStudioSection s) { _activeSection = s; notify(); }
  void setTab(AuroraStudioTab t) { _activeTab = t; notify(); }
  void toggleViewMode() { isAdvancedMode = !isAdvancedMode; notify(); }
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
    if (_product.businessType == "Fashion") {
      return getFashionCapabilities(_product.businessScale ?? BusinessScale.small).contains(s);
    }
    return (cap.categoryCapabilityRegistry[_product.businessCategory] ?? cap.businessTypeCapabilities[_product.businessType] ?? []).contains(s);
  }

  bool isFieldVisible(String f) {
    if (isAdvancedMode) return true;
    final categoryFields = field.categoryFieldRegistry[_product.businessCategory] ?? [];
    if (categoryFields.contains(f)) return true;
    
    if (_product.businessType == "Fashion") {
      final scaleFields = field.scaleFieldRegistry[_product.businessScale] ?? [];
      if (scaleFields.contains(f)) return true;
    }
    
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

  Future<void> saveProduct() async { setSaving(true); try { await repository.saveProduct(_product.toDomain()); } finally { setSaving(false); } }
  Future<void> saveDraft() async { _product.lifecycleState = ProductLifecycleState.draft; await saveProduct(); }
  void resetToNew() { resetProduct(); selectedSizes.clear(); selectedColors.clear(); notify(); }

  void updatePrice(double p) { _product.sellingPrice = p; notify(); }
  void updateCost(double c) { _product.costPrice = c; notify(); }
  void addWarehouse(String n) { if (!locationsList.contains(n)) { locationsList.add(n); notify(); } }
  void addCategory(String n) { if (!categoriesList.contains(n)) { categoriesList.add(n); notify(); } }
  void addBrand(String n) { if (!brandsList.contains(n)) { brandsList.add(n); notify(); } }
  void addSupplier(String n) { if (!suppliersList.contains(n)) { suppliersList.add(n); notify(); } }
  void addSubcategory(String n) { if (!subcategoriesList.contains(n)) { subcategoriesList.add(n); notify(); } }
  void addUnit(String n) { if (!unitsList.contains(n)) { unitsList.add(n); notify(); } }
  void addTaxJurisdiction(String n) { if (!jurisdictionsList.contains(n)) { jurisdictionsList.add(n); notify(); } }

  void pickPrimaryImage() { _product.primaryImageUrl = "https://picsum.photos/400/400?random=${DateTime.now().millisecond}"; notify(); }
  void generateSuggestedSKU() { if (_product.title.length >= 3) { _product.sku = "${_product.title.substring(0, 3).toUpperCase()}-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}"; notify(); } }
  void generateSuggestedBarcode() { _product.barcode = (100000000000 + (DateTime.now().millisecondsSinceEpoch % 899999999999)).toString(); notify(); }
  void addToGallery() { _product.galleryUrls.add("https://picsum.photos/400/400?random=${DateTime.now().microsecond}"); notify(); }
  void removeGalleryImage(int i) { if (i >= 0 && i < _product.galleryUrls.length) { _product.galleryUrls.removeAt(i); notify(); } }

  void analyzeFashionImage() {
    _product.material = "100% Cotton";
    _product.patternDesign = "Solid / Plain";
    _product.fitType = "Regular Fit";
    _product.sleeveNeckType = "Crew Neck";
    notify();
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
    final List<String> fields = [];
    final categoryFields = field.categoryFieldRegistry[_product.businessCategory] ?? [];
    fields.addAll(categoryFields);

    if (_product.businessType == "Fashion") {
      final scaleFields = field.scaleFieldRegistry[_product.businessScale] ?? [];
      for (var f in scaleFields) {
        if (!fields.contains(f)) fields.add(f);
      }
    }
    
    const common = ["costPrice", "sellingPrice", "mrp", "wholesalePrice", "openingStock"];
    for (var f in common) {
      if (!fields.contains(f)) fields.add(f);
    }

    return fields;
  }

  String getFieldLabel(String fieldId) {
    return field.fieldLabels[fieldId] ?? 
           fieldId.replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}').toUpperCase();
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
    final allFields = getOrderedFields();
    return allFields.where((f) => getTabForField(f) == tab).toList();
  }

  List<String> getTab1CoreFields() {
    final tab1Fields = getFieldsForTab(AuroraStudioTab.identity);
    final List<String> standard;
    if (_product.businessType == "Fashion") standard = field.fashionStandard;
    else if (_product.businessType == "Food & Beverage") standard = field.fnbStandard;
    else if (_product.businessType == "Healthcare") standard = field.healthcareStandard;
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
