import 'package:flutter/material.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_models.dart';
import 'session_table_widgets.dart' as sw;

double getBulkColumnWidth(String fieldId) {
  switch (fieldId) {
    case 'title': return 220;
    case 'category': return 140;
    case 'brand': return 140;
    case 'sku': return 140;
    case 'barcode': return 140;
    case 'costPrice': return 140;
    case 'sellingPrice': return 140;
    case 'mrp': return 110;
    case 'openingStock': return 130;
    case 'reorderLevel': return 130;
    case 'discountValue': return 120;
    case 'primaryImageUrl': return 80;
    case 'description': return 220;
    case 'hsnCode': return 120;
    case 'supplier': return 140;
    case 'countryOfOrigin': return 130;
    default: return 120;
  }
}

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
    final isDuplicateValue = item.status == BulkScanStatus.duplicate &&
        ['barcode', 'sku', 'title', 'brand', 'category', 'supplier'].contains(fieldId);
    final dropdownItems = _dropdownItemsForField(p);
    final width = getBulkColumnWidth(fieldId);
    final value = controller.getFieldValueById(p, fieldId);
    final strValue = value == null ? "" : value.toString();

    // If dropdown items exist and contain the value, show dropdown. Otherwise, show text field so extracted text is never hidden.
    if (dropdownItems.isNotEmpty && dropdownItems.contains(strValue)) {
      return sw.TableCell(
        width: width,
        decoration: hasError
            ? BoxDecoration(border: Border(right: BorderSide(color: Colors.red.shade400, width: 1.2)), color: Colors.red.shade50)
            : (isDuplicateValue
                ? BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.orange.shade600, width: 1.2)),
                    color: Colors.orange.shade50,
                  )
                : null),
        child: sw.TableCellDropdown<String>(
          value: strValue.isEmpty ? null : strValue,
          items: dropdownItems,
          onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v)),
        ),
      );
    }

    return sw.TableCell(
      width: width,
      decoration: hasError
          ? BoxDecoration(border: Border(right: BorderSide(color: Colors.red.shade400, width: 1.2)), color: Colors.red.shade50)
          : (isDuplicateValue
              ? BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.orange.shade600, width: 1.2)),
                  color: Colors.orange.shade50,
                )
              : null),
      child: sw.TableCellField(
        value: strValue,
        onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v)),
        textAlign: width < 100 ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
