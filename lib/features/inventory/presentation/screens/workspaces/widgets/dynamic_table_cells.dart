import 'package:flutter/material.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_models.dart';
import 'session_table_widgets.dart' as sw;

class DynamicTableCell extends StatelessWidget {
  final String fieldId;
  final int index;
  final BulkScanItem item;
  final ProductStudioController controller;
  final Function(int, Function(ProductStudioData)) updateField;

  const DynamicTableCell({
    super.key, required this.fieldId, required this.index, required this.item,
    required this.controller, required this.updateField
  });

  bool _isRequiredField(String fieldId) {
    return const {'title', 'costPrice', 'sellingPrice', 'openingStock'}.contains(fieldId);
  }

  bool _hasMissingRequiredValue(ProductStudioData p) {
    switch (fieldId) {
      case 'title':
        return p.title.trim().isEmpty;
      case 'costPrice':
        return p.costPrice <= 0;
      case 'sellingPrice':
        return p.sellingPrice <= 0;
      case 'openingStock':
        return p.openingStock <= 0;
      default:
        return false;
    }
  }

  List<String> _dropdownItemsForField(ProductStudioData p) {
    switch (fieldId) {
      case 'category': return controller.categoriesList;
      case 'subcategory': return controller.subcategoriesList;
      case 'brand': return controller.brandsList;
      case 'supplier': return controller.suppliersList;
      case 'unit':
      case 'salesUnit':
      case 'purchaseUnit':
      case 'stockUnit': return controller.unitsList;
      case 'warehouseLocation': return controller.locationsList;
      case 'gender': return ['Male', 'Female', 'Unisex', 'Kids', 'Infant'];
      case 'status': return ['Active', 'Draft', 'Discontinued'];
      case 'season': return ['Spring', 'Summer', 'Autumn', 'Winter', 'All Season'];
      case 'material': return ['Cotton', 'Polyester', 'Leather', 'Metal', 'Plastic', 'Silk', 'Denim', 'Rubber'];
      case 'countryOfOrigin': return ['India', 'China', 'USA', 'UK', 'Vietnam'];
      case 'discountType': return ['Percentage', 'Fixed'];
      case 'taxCode': return controller.taxCategoriesList;
      case 'visibility': return ['Public', 'Private', 'Internal'];
      default: return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    final hasError = _isRequiredField(fieldId) && _hasMissingRequiredValue(p);
    final dropdownItems = _dropdownItemsForField(p);

    if (dropdownItems.isNotEmpty) {
      final currentValue = controller.getFieldValueById(p, fieldId)?.toString() ?? '';
      final value = currentValue.isEmpty ? null : currentValue;
      return sw.TableCell(
        width: fieldId == 'warehouseLocation' ? 140 : fieldId == 'unit' || fieldId == 'salesUnit' || fieldId == 'purchaseUnit' || fieldId == 'stockUnit' ? 90 : 120,
        decoration: hasError ? BoxDecoration(border: Border(right: BorderSide(color: Colors.red.shade400, width: 1.2)), color: Colors.red.shade50) : null,
        child: sw.TableCellDropdown<String>(
          value: value,
          items: dropdownItems,
          onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v)),
        ),
      );
    }

    double width = 120;
    if (fieldId == 'title') width = 200;
    if (fieldId == 'description') width = 150;
    if (fieldId.contains('Price') || fieldId == 'mrp' || fieldId == 'costPrice' || fieldId == 'discountValue') width = 90;
    if (fieldId.contains('Stock') || fieldId == 'openingStock' || fieldId == 'safetyStock' || fieldId == 'reorderLevel') width = 80;

    final value = controller.getFieldValueById(p, fieldId);

    return sw.TableCell(
      width: width,
      decoration: hasError ? BoxDecoration(border: Border(right: BorderSide(color: Colors.red.shade400, width: 1.2)), color: Colors.red.shade50) : null,
      child: sw.TableCellField(
        value: value == null ? "" : value.toString(),
        onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v)),
        textAlign: width < 100 ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
