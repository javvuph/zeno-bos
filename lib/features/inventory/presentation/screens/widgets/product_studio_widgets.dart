import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
export 'studio_ui_components.dart';

class ColHeader extends StatelessWidget {
  final double width; final String label;
  const ColHeader({super.key, required this.width, required this.label});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(width: width, decoration: BoxDecoration(border: Border(right: BorderSide(color: colors.borderSubtle))), padding: const EdgeInsets.only(left: 8), alignment: Alignment.centerLeft, child: Text(label, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)));
  }
}

class StatToken extends StatelessWidget {
  final String label; final String value; final Color color;
  const StatToken({super.key, required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(label, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)), Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color))]);
  }
}

class TableCell extends StatelessWidget {
  final double width; final Widget child; final BoxDecoration? decoration;
  const TableCell({super.key, required this.width, required this.child, this.decoration});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(width: width, height: double.infinity, decoration: decoration ?? BoxDecoration(border: Border(right: BorderSide(color: colors.borderSubtle))), padding: const EdgeInsets.symmetric(horizontal: 8), alignment: Alignment.centerLeft, child: child);
  }
}

class TableCellField extends StatefulWidget {
  final String value; final String? hint; final ValueChanged<String> onChanged; final TextAlign textAlign;
  const TableCellField({super.key, required this.value, this.hint, required this.onChanged, this.textAlign = TextAlign.start});
  @override
  State<TableCellField> createState() => _TableCellFieldState();
}

class _TableCellFieldState extends State<TableCellField> {
  late TextEditingController _controller;
  @override
  void initState() { super.initState(); _controller = TextEditingController(text: widget.value); }
  @override
  void didUpdateWidget(TableCellField oldWidget) { super.didUpdateWidget(oldWidget); if (widget.value != _controller.text) { _controller.text = widget.value; _controller.selection = TextSelection.collapsed(offset: _controller.text.length); } }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: TextField(controller: _controller, onChanged: widget.onChanged, textAlign: widget.textAlign, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), decoration: InputDecoration(hintText: widget.hint, isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero)));
  }
}

class TableCellDropdown<T> extends StatelessWidget {
  final T? value; final List<T> items; final ValueChanged<T?> onChanged;
  const TableCellDropdown({super.key, this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: DropdownButtonHideUnderline(child: DropdownButton<T>(value: value, items: items.map((i) => DropdownMenuItem(value: i, child: Text(i.toString(), style: const TextStyle(fontSize: 10)))).toList(), onChanged: onChanged, isDense: true, isExpanded: true, icon: const Icon(Icons.arrow_drop_down, size: 14))));
  }
}

class HeaderDropdown<T> extends StatelessWidget {
  final T? value; final List<T> items; final ValueChanged<T?> onChanged;
  const HeaderDropdown({super.key, this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      height: 24, padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(4), border: Border.all(color: colors.borderSubtle)),
      child: DropdownButtonHideUnderline(child: DropdownButton<T>(value: value, items: items.map((i) => DropdownMenuItem(value: i, child: Text(i.toString().toUpperCase(), style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)))).toList(), onChanged: onChanged, isDense: true, icon: const Icon(Icons.arrow_drop_down, size: 12))),
    );
  }
}

class ModeButton extends StatelessWidget {
  final String label; final IconData icon; final bool isActive; final VoidCallback onPressed; final ZenoSemanticColors colors;
  const ModeButton({super.key, required this.label, required this.icon, required this.isActive, required this.onPressed, required this.colors});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onPressed, child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: isActive ? colors.accentPrimary.withValues(alpha: 0.1) : Colors.transparent, borderRadius: BorderRadius.circular(6), border: Border.all(color: isActive ? colors.accentPrimary : colors.borderSubtle)),
      child: Row(children: [Icon(icon, size: 12, color: isActive ? colors.accentPrimary : colors.textDisabled), const SizedBox(width: 6), Text(label.toUpperCase(), style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: isActive ? colors.accentPrimary : colors.textDisabled))]),
    ));
  }
}
