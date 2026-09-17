import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_models.dart';
import 'session_table_widgets.dart';
import 'import_column_config.dart';
import 'dynamic_table_cells.dart';

class DynamicSessionRow extends StatelessWidget {
  final int index;
  final BulkScanItem item;
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final List<ImportColumnConfig> columns;
  final Function(int, Function(ProductStudioData)) updateField;

  const DynamicSessionRow({
    super.key, required this.index, required this.item, required this.controller,
    required this.colors, required this.columns, required this.updateField
  });

  @override
  Widget build(BuildContext context) {
    double totalWidth = 60 + columns.fold(0.0, (sum, col) => sum + col.width);
    
    return Container(
      width: totalWidth, height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.borderSubtle), left: BorderSide(color: colors.borderSubtle), right: BorderSide(color: colors.borderSubtle)),
        color: item.isSelected ? colors.accentPrimary.withValues(alpha: 0.05) : null,
      ),
      child: Row(
        children: [
          Checkbox(value: item.isSelected, onChanged: (v) => _toggleSelect(v ?? false), visualDensity: VisualDensity.compact),
          TableCell(width: 36, child: Text("${index + 1}", style: TextStyle(fontSize: 10, color: colors.textDisabled))),
          ...columns.map((col) => _buildCell(col)),
        ],
      ),
    );
  }

  Widget _buildCell(ImportColumnConfig col) {
    // Dropdown logic for Import cells if applicable
    if (col.fieldId == 'category' || col.fieldId == 'subcategory' || col.fieldId.contains('Unit') || col.fieldId == 'warehouseLocation') {
       return DynamicTableCell(fieldId: col.fieldId, index: index, item: item, controller: controller, updateField: updateField);
    }

    final value = controller.getFieldValueById(item.product, col.fieldId);
    
    return TableCell(
      width: col.width,
      child: TableCellField(
        value: value == null ? "" : value.toString(),
        hint: col.isRequired ? "${col.label} *" : col.label,
        onChanged: (v) => updateField(index, (p) => controller.updateFieldById(p, col.fieldId, v)),
      ),
    );
  }

  void _toggleSelect(bool v) {
    if (controller.currentMode == ProductCreationMode.import) { controller.toggleImportSelectItem(index, v); }
    else { controller.toggleBulkSelectItem(index, v); }
  }
}
