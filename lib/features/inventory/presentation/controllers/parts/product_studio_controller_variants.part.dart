// @LOCKED: VERSION_CLOTHING_V1
// DO NOT MODIFY THE CLOTHING/FASHION LOGIC WITHOUT EXPLICIT PERMISSION.
part of '../product_studio_controller.dart';

extension ProductStudioControllerVariants on ProductStudioController {
  void toggleColor(String color) { 
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
      if (_activeMediaColor == color) _activeMediaColor = selectedColors.isNotEmpty ? selectedColors.first : null;
    } else {
      selectedColors.add(color);
      if (_activeMediaColor == null) _activeMediaColor = color;
    }
    generateMatrix();
  }
  
  void addCustomColor(String color, [Color? colorValue]) { 
    if (!availableColors.contains(color)) { 
      availableColors.add(color); 
      if (colorValue != null) customColorMap[color] = colorValue;
      toggleColor(color); 
    } 
  }

  void toggleColorManageMode() {
    isColorManageMode = !isColorManageMode;
    notify();
  }
  
  void removeCustomColor(String color) {
    if (availableColors.contains(color)) {
      availableColors.remove(color);
      selectedColors.remove(color);
      customColorMap.remove(color);
      generateMatrix();
    }
  }
  void addCustomSize(String size) { toggleSize(size); }

  void toggleSize(String size) { 
    if (selectedSizes.contains(size)) selectedSizes.remove(size); 
    else selectedSizes.add(size); 
    generateMatrix();
  }
  void setSizeType(VariantSizeType t) { sizeType = t; selectedSizes.clear(); generateMatrix(); }
  void setActiveVariant(int index) { activeVariantIndex = index; notify(); }

  List<String> getSizesForType(VariantSizeType type) {
    switch (type) {
      case VariantSizeType.alpha:
      case VariantSizeType.alphabetic:
        return ["S", "M", "L", "XL", "XXL", "XXXL"];
      case VariantSizeType.numeric:
      case VariantSizeType.numericUK:
        return ["6", "7", "8", "9", "10", "11"];
      case VariantSizeType.numericEU:
        return ["39", "40", "41", "42", "43", "44"];
      case VariantSizeType.waist:
        return ["28", "30", "32", "34", "36", "38"];
      case VariantSizeType.kids:
        return ["2Y", "4Y", "6Y", "8Y"];
      case VariantSizeType.custom:
        return [];
    }
  }

  void generateMatrix() {
    _product.variants.clear();
    for (var color in selectedColors) {
      for (var size in selectedSizes) {
        final baseSku = _product.sku.trim();
        final skuStr = baseSku.isNotEmpty ? "$baseSku-$color-$size" : "$color-$size";
        _product.variants.add(VariantMatrixItem(color: color, size: size, price: _product.sellingPrice, purchasePrice: _product.costPrice, mrp: _product.mrp, wholesalePrice: _product.wholesalePrice, stock: 0, safetyStock: _product.safetyStock.toInt(), reorderLevel: _product.reorderLevel, sku: skuStr, barcode: ""));
      }
    }
    notify();
  }

  void updateVariantField(int index, {double? price, double? purchasePrice, double? mrp, double? wholesalePrice, int? stock, int? safetyStock, double? reorderLevel, String? warehouseLocation, String? sku, String? barcode}) {
    if (index >= 0 && index < _product.variants.length) {
      final v = _product.variants[index];
      if (price != null) v.price = price; if (purchasePrice != null) v.purchasePrice = purchasePrice;
      if (mrp != null) v.mrp = mrp; if (wholesalePrice != null) v.wholesalePrice = wholesalePrice;
      if (stock != null) v.stock = stock; if (safetyStock != null) v.safetyStock = safetyStock;
      if (reorderLevel != null) v.reorderLevel = reorderLevel; if (warehouseLocation != null) v.warehouseLocation = warehouseLocation;
      if (sku != null) v.sku = sku; if (barcode != null) v.barcode = barcode;
      notify();
    }
  }

  Color getColorValue(String colorName) {
    if (customColorMap.containsKey(colorName)) return customColorMap[colorName]!;
    switch (colorName.toLowerCase()) {
      case 'black': return Colors.black;
      case 'white': return Colors.white;
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'navy': return const Color(0xFF000080);
      case 'green': return Colors.green;
      case 'beige': return const Color(0xFFF5F5DC);
      case 'yellow': return Colors.yellow;
      case 'orange': return Colors.orange;
      case 'grey': return Colors.grey;
      default: return Colors.blueGrey;
    }
  }

  void addColorMedia(String color) {
    if (!_product.colorMediaLibrary.containsKey(color)) { _product.colorMediaLibrary[color] = []; }
    _product.colorMediaLibrary[color]!.add(MediaAsset(id: "M-${DateTime.now().millisecond}", url: "", thumbnailUrl: "", sortOrder: _product.colorMediaLibrary[color]!.length));
    notify();
  }

  void removeMedia(String color, int index) {
    if (_product.colorMediaLibrary.containsKey(color) && index < _product.colorMediaLibrary[color]!.length) {
      _product.colorMediaLibrary[color]!.removeAt(index);
      notify();
    }
  }

  void setActiveMediaColor(String? color) { _activeMediaColor = color; notify(); }

  void syncAllFromFirstRow() {
    if (_product.variants.length < 2) return;
    final first = _product.variants.first;
    for (int i = 1; i < _product.variants.length; i++) {
      final v = _product.variants[i];
      v.price = first.price; v.stock = first.stock; v.sku = first.sku; v.barcode = first.barcode;
    }
    notify();
  }

  void generateAllVariantBarcodes() {
    for (var v in _product.variants) {
      if (v.barcode.isEmpty) v.barcode = (100000000000 + (DateTime.now().microsecondsSinceEpoch % 899999999999)).toString();
    }
    notify();
  }

  void syncBasePriceToAllVariants() { for (var v in _product.variants) { v.price = _product.sellingPrice; } notify(); }
  void syncBaseStockToAllVariants() { for (var v in _product.variants) { v.safetyStock = _product.safetyStock.toInt(); } notify(); }
  bool get areAllVariantsSelected => _product.variants.isNotEmpty && _product.variants.every((v) => v.isSelected);
  bool get hasSelectedVariants => _product.variants.any((v) => v.isSelected);
  void toggleVariantSelection(int index, bool value) {
    if (index >= 0 && index < _product.variants.length) {
      _product.variants[index].isSelected = value;
      notify();
    }
  }
  void toggleAllVariantsSelection(bool value) {
    for (final variant in _product.variants) {
      variant.isSelected = value;
    }
    notify();
  }
  void clearAllVariants() {
    if (_product.variants.isEmpty) return;
    _product.variants.clear();
    activeVariantIndex = null;
    notify();
  }
  void removeVariantItem(int i) {
    if (i >= 0 && i < _product.variants.length) {
      _product.variants.removeAt(i);
      if (_product.variants.isEmpty) {
        activeVariantIndex = null;
      } else if (activeVariantIndex != null && activeVariantIndex! >= _product.variants.length) {
        activeVariantIndex = _product.variants.length - 1;
      }
      notify();
    }
  }
  
  bool aiSynthesizeAnglesForColor(String color, String promptDescription, BuildContext context) {
    if (color.isEmpty) return false;
    final list = _product.colorMediaLibrary[color] ?? [];
    
    final userUploadedAssets = list.where((m) => m.url.isNotEmpty).toList();
    if (userUploadedAssets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Please upload your product photo first before creating angles."),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }

    final String userPhotoUrl = userUploadedAssets.first.url;

    if (!_product.colorMediaLibrary.containsKey(color)) {
      _product.colorMediaLibrary[color] = [];
    }
    final targetList = _product.colorMediaLibrary[color]!;

    const angleNames = ["Front View", "Back View", "Side View", "Detail Shot"];
    while (targetList.length < angleNames.length) {
      targetList.add(MediaAsset(
        id: "AI-SLOT-${DateTime.now().microsecondsSinceEpoch}-${targetList.length}",
        url: "",
        thumbnailUrl: "",
        sortOrder: targetList.length,
        altText: "$color ${angleNames[targetList.length]}",
      ));
    }

    for (int i = 0; i < targetList.length; i++) {
      final angleName = angleNames[i % angleNames.length];
      targetList[i] = MediaAsset(
        id: targetList[i].id.isEmpty ? "ANGLE-$i-${DateTime.now().microsecondsSinceEpoch}" : targetList[i].id,
        url: userPhotoUrl,
        thumbnailUrl: userPhotoUrl,
        sortOrder: i,
        isPrimary: i == 0,
        altText: "$color $angleName",
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✨ Angles created successfully using your uploaded photo!"),
        backgroundColor: Colors.indigo,
        duration: Duration(seconds: 2),
      ),
    );

    notify();
    return true;
  }

  bool aiApplyToAllSelectedColors(String sourceColor, BuildContext context) {
    if (sourceColor.isEmpty || !_product.colorMediaLibrary.containsKey(sourceColor)) return false;

    final sourceMedia = _product.colorMediaLibrary[sourceColor]!.where((m) => m.url.isNotEmpty).toList();
    if (sourceMedia.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Please upload your product photo first before applying to all colors."),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }

    for (var col in selectedColors) {
      if (col == sourceColor) continue;
      _product.colorMediaLibrary[col] = sourceMedia.map((m) {
        return MediaAsset(
          id: "SYNC-$col-${m.id}",
          url: m.url,
          thumbnailUrl: m.thumbnailUrl,
          sortOrder: m.sortOrder,
          isPrimary: m.isPrimary,
          altText: m.altText.replaceAll(sourceColor, col),
        );
      }).toList();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✨ Successfully applied your photos to all selected colors!"),
        backgroundColor: Colors.indigo,
        duration: Duration(seconds: 2),
      ),
    );

    notify();
    return true;
  }

  List<VariantMatrixItem> get generatedVariants => _product.variants;
  String? get matrixActionMessage => null;
}
