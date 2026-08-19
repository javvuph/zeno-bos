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

  @override
  Widget build(BuildContext context) {
    final p = item.product;

    // Dropdown Fields
    if (fieldId == 'category') {
      return sw.TableCell(width: 120, child: sw.TableCellDropdown<String>(value: p.category.isEmpty ? null : p.category, items: controller.categoriesList, onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v))));
    }
    if (fieldId == 'subcategory') {
      return sw.TableCell(width: 120, child: sw.TableCellDropdown<String>(value: p.subcategory.isEmpty ? null : p.subcategory, items: controller.subcategoriesList, onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v))));
    }
    if (fieldId == 'unit' || fieldId == 'salesUnit' || fieldId == 'purchaseUnit' || fieldId == 'stockUnit') {
      final val = controller.getFieldValueById(p, fieldId).toString();
      return sw.TableCell(width: 90, child: sw.TableCellDropdown<String>(value: val.isEmpty ? "Piece (Pc)" : val, items: controller.unitsList, onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v))));
    }
    if (fieldId == 'warehouseLocation') {
      return sw.TableCell(width: 140, child: sw.TableCellDropdown<String>(value: p.warehouseLocation.isEmpty ? null : p.warehouseLocation, items: controller.locationsList, onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v))));
    }
    
    // Default width logic
    double width = 120;
    if (fieldId == 'title') width = 200;
    if (fieldId == 'description') width = 150;
    if (fieldId.contains('Price') || fieldId == 'mrp' || fieldId == 'costPrice' || fieldId == 'discountValue') width = 90;
    if (fieldId.contains('Stock') || fieldId == 'openingStock' || fieldId == 'safetyStock' || fieldId == 'reorderLevel') width = 80;

    final value = controller.getFieldValueById(p, fieldId);

    return sw.TableCell(
      width: width,
      child: sw.TableCellField(
        value: value == null ? "" : value.toString(),
        onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, fieldId, v)),
        textAlign: width < 100 ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
