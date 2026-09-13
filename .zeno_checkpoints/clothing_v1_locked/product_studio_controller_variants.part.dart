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
        _product.variants.add(VariantMatrixItem(color: color, size: size, price: _product.sellingPrice, purchasePrice: _product.costPrice, mrp: _product.mrp, wholesalePrice: _product.wholesalePrice, stock: 0, safetyStock: _product.safetyStock.toInt(), reorderLevel: _product.reorderLevel, sku: "${_product.sku}-$color-$size", barcode: ""));
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
  void removeVariantItem(int i) { if (i >= 0 && i < _product.variants.length) { _product.variants.removeAt(i); notify(); } }
  
  List<VariantMatrixItem> get generatedVariants => _product.variants;
  String? get matrixActionMessage => null;
}
