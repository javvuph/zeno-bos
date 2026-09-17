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
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: width, height: double.infinity,
      decoration: decoration ?? BoxDecoration(border: Border(right: BorderSide(color: colors.borderSubtle))),
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
    // Calculate width dynamically
    double totalWidth = 36 + 56 + 48; // Static cols
    for (var f in fields) {
      if (f == 'title') {
        totalWidth += 200;
      } else if (f == 'description') {
        totalWidth += 150;
      } else if (f.contains('Price') || f == 'mrp' || f == 'costPrice') {
        totalWidth += 90;
      } else if (f.contains('Stock') || f == 'openingStock') {
        totalWidth += 80;
      } else {
        totalWidth += 120;
      }
    }

    final isDuplicate = item.status == BulkScanStatus.duplicate;
    return Container(
      width: totalWidth, height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: isDuplicate ? colors.statusWarning : colors.borderSubtle), left: BorderSide(color: isDuplicate ? colors.statusWarning : colors.borderSubtle), right: BorderSide(color: isDuplicate ? colors.statusWarning : colors.borderSubtle)),
        color: isDuplicate
            ? colors.statusWarning.withValues(alpha: 0.08)
            : (item.isSelected ? colors.accentPrimary.withValues(alpha: 0.05) : null),
      ),
      child: Row(
        children: [
          Checkbox(value: item.isSelected, onChanged: (v) => _toggleSelect(v ?? false), visualDensity: VisualDensity.compact),
          TableCell(width: 36, child: Text("${index + 1}", style: TextStyle(fontSize: 10, color: colors.textDisabled))),
          TableCell(width: 56, child: Container(width: 32, height: 32, decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(4)), child: Icon(Icons.image_outlined, size: 14, color: colors.textDisabled))),
          
          // Dynamic Fields
          ...fields.map((f) => DynamicTableCell(fieldId: f, index: index, item: item, controller: controller, updateField: updateField)),
        ],
      ),
    );
  }

  void _toggleSelect(bool v) {
    if (controller.currentMode == ProductCreationMode.import) { controller.toggleImportSelectItem(index, v); }
    else { controller.toggleBulkSelectItem(index, v); }
  }
}
