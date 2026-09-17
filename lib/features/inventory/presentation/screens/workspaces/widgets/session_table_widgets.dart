import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_models.dart';
import 'dynamic_table_cells.dart';

class TableCell extends StatelessWidget {
  final double width;
  final Widget child;
  final BoxDecoration? decoration;
  const TableCell({super.key, required this.width, required this.child, this.decoration});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: double.infinity,
      decoration: decoration ?? BoxDecoration(border: Border(right: BorderSide(color: const Color(0xFFF1F5F9)))),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}

class TableCellField extends StatefulWidget {
  final String value;
  final String? hint;
  final ValueChanged<String> onChanged;
  final TextAlign textAlign;
  const TableCellField({super.key, required this.value, this.hint, required this.onChanged, this.textAlign = TextAlign.start});
  @override
  State<TableCellField> createState() => _TableCellFieldState();
}

class _TableCellFieldState extends State<TableCellField> {
  late TextEditingController _controller;
  @override
  void initState() { super.initState(); _controller = TextEditingController(text: widget.value); }
  @override
  void didUpdateWidget(TableCellField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: _controller, onChanged: widget.onChanged, textAlign: widget.textAlign,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        decoration: InputDecoration(hintText: widget.hint, isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
      ),
    );
  }
}

class TableCellDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  const TableCellDropdown({super.key, this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value, isDense: true, isExpanded: true,
          items: items.map((i) => DropdownMenuItem(value: i, child: Text(i.toString(), style: const TextStyle(fontSize: 10)))).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down, size: 14),
        ),
      ),
    );
  }
}

class SessionRow extends StatelessWidget {
  final int index;
  final BulkScanItem item;
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final Function(int, Function(ProductStudioData)) updateField;
  final List<String> fields;

  const SessionRow({
    super.key, required this.index, required this.item, required this.controller,
    required this.colors, required this.updateField, required this.fields
  });

  @override
  Widget build(BuildContext context) {
    double getBulkColumnWidth(dynamic field) {
      final String key = field?.toString().toLowerCase() ?? '';
      if (key == 'primaryimageurl') return 56.0;
      if (key.contains('name') || key.contains('title')) return 220.0;
      if (key.contains('description')) return 180.0;
      if (key.contains('sku') || key.contains('barcode') || key.contains('code') || key.contains('gtin')) return 130.0;
      if (key.contains('price') || key.contains('cost') || key.contains('mrp') || key.contains('purchase')) return 105.0;
      if (key.contains('discount')) return 95.0;
      if (key.contains('stock') || key.contains('quantity')) return 95.0;
      if (key.contains('alert') || key.contains('threshold') || key.contains('reorder')) return 105.0;
      if (key.contains('category') || key.contains('brand') || key.contains('label') || key.contains('supplier')) return 115.0;
      if (key.contains('country')) return 120.0;
      if (key.contains('action') || key.contains('status')) return 85.0;
      return 110.0;
    }

    // Calculate width dynamically
    double totalWidth = 24 + 42 + 56; // Static cols
    for (var f in fields) {
      totalWidth += getBulkColumnWidth(f);
    }

    final isDuplicate = item.status == BulkScanStatus.duplicate;
    return Container(
      width: totalWidth, height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: isDuplicate ? colors.statusWarning : const Color(0xFFe8e8e8)),
          right: BorderSide(color: const Color(0xFFF1F5F9), width: 1),
        ),
        color: isDuplicate
            ? colors.statusWarning.withValues(alpha: 0.08)
            : (item.isSelected ? const Color(0xFF0066CC).withValues(alpha:0.05) : const Color(0xFFFAFBFC)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Checkbox(value: item.isSelected, onChanged: (v) => _toggleSelect(v ?? false), visualDensity: VisualDensity.compact),
          ),
          TableCell(width: 42, child: Text("${index + 1}", style: TextStyle(fontSize: 10, color: colors.textDisabled))),
          TableCell(width: 56, child: Container(width: 24, height: 24, decoration: BoxDecoration(color: const Color(0xFF0066CC).withValues(alpha:0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFF0066CC).withValues(alpha:0.2))), child: Icon(Icons.image_outlined, size: 14, color: const Color(0xFF0066CC)))),

          // Dynamic Fields
          ...fields.map((f) => SizedBox(
                width: getBulkColumnWidth(f),
                child: DynamicTableCell(fieldId: f, index: index, item: item, controller: controller, updateField: updateField),
              )),
        ],
      ),
    );
  }

  void _toggleSelect(bool v) {
    if (controller.currentMode == ProductCreationMode.import) { controller.toggleImportSelectItem(index, v); }
    else { controller.toggleBulkSelectItem(index, v); }
  }
}
