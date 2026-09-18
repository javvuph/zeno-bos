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
    _activeTab = AuroraStudioTab.identity;
    _activeSection = ProductStudioSection.fashionBasic;
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
    const basicFields = {
      'title', 'sku', 'barcode', 'category', 'brand',
      'costPrice', 'sellingPrice', 'mrp', 'discountValue',
      'reorderLevel', 'openingStock', 'primaryImage'
    };
    if (basicFields.contains(f)) return true;

    final categoryFields = field.categoryFieldRegistry[_product.businessCategory] ?? [];
    final scaleFields = field.scaleFieldRegistry[_product.businessScale] ?? [];

    if (!isAdvancedMode) {
      return categoryFields.contains(f) || scaleFields.contains(f);
    }

    if (categoryFields.isEmpty && scaleFields.isEmpty) return true;
    return categoryFields.contains(f) || scaleFields.contains(f);
  }
  bool isSectionComplete(ProductStudioSection s) => _product.title.isNotEmpty;

  void nextSection() {
    final sections = ProductStudioSection.values.where((s) => isSectionVisible(s)).toList();
    final currentIdx = sections.indexOf(_activeSection);
    if (currentIdx >= 0 && currentIdx < sections.length - 1) {
      setSection(sections[currentIdx + 1]);
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
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      final file = result?.files.single;
      if (file != null && file.path != null) {
        _product.primaryImageUrl = file.path!;
        SystemSound.play(SystemSoundType.click);
        notify();
      }
    } catch (e) {
      debugPrint("Error picking primary image: $e");
    } finally {
      _isPickingImage = false;
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
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (result != null) {
        for (final file in result.files) {
          if (file.path != null) {
            _product.galleryUrls.add(file.path!);
            SystemSound.play(SystemSoundType.click);
          }
        }
        notify();
      }
    } catch (e) {
      debugPrint("Error adding to gallery: $e");
    } finally {
      _isPickingImage = false;
    }
  }

  void removeGalleryImage(int i) { if (i >= 0 && i < _product.galleryUrls.length) { _product.galleryUrls.removeAt(i); notify(); } }

  void deletePrimaryImage() { _product.primaryImageUrl = ""; notify(); }

  void setGalleryImageAsPrimary(int i) {
    if (i < 0 || i >= _product.galleryUrls.length) return;
    final newPrimary = _product.galleryUrls[i];
    if (_product.primaryImageUrl.isNotEmpty) {
      _product.galleryUrls[i] = _product.primaryImageUrl;
    } else {
      _product.galleryUrls.removeAt(i);
    }
    _product.primaryImageUrl = newPrimary;
    notify();
  }

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

  Map<String, dynamic> get currentTaxConfig => {
    "gstEnabled": true, "defaultRate": 18.0, "taxName": "GST", "codeLabel": "HSN/SAC Code", "showGSTMode": true,
    "statuses": ["Taxable", "Non-Taxable", "Exempt"], "categories": ["Standard", "Zero Rated", "Nil Rated"],
    "gstModes": ["Intra-State", "Inter-State"]
  };
  
  Map<String, List<String>> get businessCategoryMap => sub.businessCategoryMap;
}
