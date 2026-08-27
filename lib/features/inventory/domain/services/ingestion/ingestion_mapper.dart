import '../../models/product_studio_data.dart';
import '../../models/product_studio_enums.dart';

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

  void _setProductField(ProductStudioData product, String fieldId, String value) {
    // Basic mapping for common fields
    switch (fieldId) {
      case 'title': product.title = value; break;
      case 'sku': product.sku = value; break;
      case 'barcode': product.barcode = value; break;
      case 'description': product.description = value; break;
      case 'sellingPrice': product.sellingPrice = double.tryParse(value) ?? 0.0; break;
      case 'costPrice': product.costPrice = double.tryParse(value) ?? 0.0; break;
      case 'mrp': product.mrp = double.tryParse(value) ?? 0.0; break;
      case 'category': product.category = value; break;
      case 'brand': product.brand = value; break;
      case 'unit': product.unit = value; break;
      case 'openingStock': product.openingStock = double.tryParse(value) ?? 0.0; break;
      case 'warehouseLocation': product.warehouseLocation = value; break;
      // Industry specific fields would be handled here or via a more generic update method
      default:
        // We can use a generic update if available or extend this
        _setDynamicField(product, fieldId, value);
    }
  }

  void _setDynamicField(ProductStudioData product, String fieldId, String value) {
    // In a real implementation, we would use reflection or a large switch
    // For now, we support some common industry fields
    if (fieldId == 'fabric') product.fabric = value;
    else if (fieldId == 'material') product.material = value;
    else if (fieldId == 'color') product.color = value;
    else if (fieldId == 'size') product.sizeScale = value; // Mapping size to sizeScale for simplicity
    else if (fieldId == 'pluCode') product.pluCode = value;
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
