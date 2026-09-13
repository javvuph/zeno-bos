import '../../models/product_studio_data.dart';

class IngestionMapper {
  /// Maps a raw row of data to ProductStudioData.
  /// headerMapping: Map of Header Name -> Internal Field ID
  ProductStudioData mapToProductStudio(Map<String, String> rawRow, Map<String, String> headerMapping) {
    final product = ProductStudioData.empty();
    
    for (final entry in headerMapping.entries) {
      final header = entry.key;
      final fieldId = entry.value;
      final value = rawRow[header];
      
      if (value != null) {
        _setProductField(product, fieldId, value);
      }
    }
    
    return product;
  }

  /// Maps a ZENO BOS JSON extraction object directly to ProductStudioData.
  ProductStudioData mapJsonToProductStudio(Map<String, dynamic> json) {
    final product = ProductStudioData.empty();
    product.title = (json['product_name'] ?? json['productName'] ?? "").toString().trim();
    product.arabicTitle = (json['arabic_name'] ?? json['arabicName'] ?? "").toString().trim();
    product.description = (json['description'] ?? "").toString().trim();
    product.subBrand = (json['sub_brand'] ?? json['subBrand'] ?? "").toString().trim();
    product.manufacturer = (json['manufacturer'] ?? "").toString().trim();
    product.shade = (json['colour'] ?? json['color'] ?? "").toString().trim();
    product.sizeStandard = (json['size'] ?? "").toString().trim();
    product.sku = (json['sku'] ?? "").toString().trim();
    product.barcode = (json['barcode_gtin'] ?? json['barcodeGtin'] ?? "").toString().trim();
    product.internalBarcode = (json['internal_barcode'] ?? json['internalBarcode'] ?? "").toString().trim();
    product.openingStock = double.tryParse(json['opening_stock']?.toString() ?? "0") ?? 0.0;
    product.reorderLevel = double.tryParse(json['reorder_level']?.toString() ?? "0") ?? 0.0;
    product.costPrice = double.tryParse(json['purchase_cost']?.toString() ?? "0") ?? 0.0;
    product.sellingPrice = double.tryParse(json['selling_price']?.toString() ?? "0") ?? 0.0;
    product.mrp = double.tryParse(json['mrp']?.toString() ?? "0") ?? 0.0;
    product.promotionalPrice = double.tryParse(json['promo_price']?.toString() ?? "0") ?? 0.0;
    product.hsnCode = (json['hsn_tax_code'] ?? json['hsnTaxCode'] ?? "").toString().trim();
    product.taxRate = double.tryParse(json['tax_rate']?.toString() ?? "0") ?? 0.0;
    product.fabricComposition = (json['fabric'] ?? json['material'] ?? "").toString().trim();
    product.supplier = (json['primary_supplier'] ?? json['primarySupplier'] ?? "").toString().trim();
    return product;
  }

  void _setProductField(ProductStudioData product, String fieldId, String value) {
    // Basic mapping for common fields
    switch (fieldId) {
      case 'title': product.title = value; break;
      case 'sku': product.sku = value; break;
      case 'barcode': product.barcode = value; break;
      case 'description': product.description = value; break;
      case 'color': product.shade = value; break;
      case 'sellingPrice': product.sellingPrice = double.tryParse(value) ?? 0.0; break;
      case 'costPrice': product.costPrice = double.tryParse(value) ?? 0.0; break;
      case 'mrp': product.mrp = double.tryParse(value) ?? 0.0; break;
      case 'promoPrice': product.promotionalPrice = double.tryParse(value) ?? 0.0; break;
      case 'category': product.category = value; break;
      case 'brand': product.brand = value; break;
      case 'unit': product.unit = value; break;
      case 'size': product.sizeStandard = value; break;
      case 'openingStock': product.openingStock = double.tryParse(value) ?? 0.0; break;
      case 'warehouseLocation': product.warehouseLocation = value; break;
      case 'fabric': product.fabricComposition = value; break;
      default:
        _setDynamicField(product, fieldId, value);
    }
  }

  void _setDynamicField(ProductStudioData product, String fieldId, String value) {
    if (fieldId == 'fabric') {
      product.fabricComposition = value;
    } else if (fieldId == 'material') {
      product.material = value;
    } else if (fieldId == 'color') {
      product.shade = value;
    } else if (fieldId == 'size') {
      product.sizeStandard = value;
    } else if (fieldId == 'promoPrice') {
      product.promotionalPrice = double.tryParse(value) ?? 0.0;
    } else if (fieldId == 'pluCode') {
      product.pluCode = value;
    }
  }

  /// Auto-detect mapping based on header similarity
  Map<String, String> autoDetectMapping(List<String> headers, List<String> availableFieldIds) {
    final Map<String, String> mapping = {};
    for (final header in headers) {
      final normalizedHeader = header.toLowerCase().replaceAll(' ', '');
      for (final fieldId in availableFieldIds) {
        final normalizedField = fieldId.toLowerCase();
        if (normalizedHeader == normalizedField || normalizedHeader.contains(normalizedField) || normalizedField.contains(normalizedHeader)) {
          mapping[header] = fieldId;
          break;
        }
      }
    }
    return mapping;
  }
}
