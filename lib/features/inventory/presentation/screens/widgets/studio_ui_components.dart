import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../../domain/models/product_studio_enums.dart';

class StudioSectionHeader extends StatelessWidget {
  final String title; final String? subtitle; final IconData icon; final ZenoSemanticColors colors;
  const StudioSectionHeader({super.key, required this.title, this.subtitle, required this.icon, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: colors.accentPrimary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, size: 16, color: colors.accentPrimary)),
        const SizedBox(width: 12),
        Text(title.toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: colors.textPrimary, letterSpacing: 0.5)),
      ]),
      if (subtitle != null) ...[const SizedBox(height: 8), Text(subtitle!, style: TextStyle(fontSize: 11, color: colors.textSecondary))],
    ]);
  }
}

class ZenoQuickAddDropdown<T> extends StatelessWidget {
  final String label; final T? value; final List<DropdownMenuItem<T>> items; final ValueChanged<T?> onChanged; final VoidCallback onQuickAdd;
  const ZenoQuickAddDropdown({super.key, required this.label, this.value, required this.items, required this.onChanged, required this.onQuickAdd});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Row(children: [
        Expanded(child: Container(
          height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)),
          child: DropdownButtonHideUnderline(child: DropdownButton<T>(value: value, items: items, onChanged: onChanged, isExpanded: true, dropdownColor: colors.bgTier2, icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18))),
        )),
        const SizedBox(width: 8),
        ZenoButton(label: "", icon: Icons.add, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.md, onPressed: onQuickAdd),
      ]),
    ]);
  }
}

void showAddDialog(BuildContext context, ZenoSemanticColors colors, String title, Function(String) onAdd) {
  final tc = TextEditingController();
  showDialog(context: context, builder: (ctx) => AlertDialog(
    title: Text("Add New $title", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    content: TextField(controller: tc, decoration: InputDecoration(hintText: "Enter $title Name")),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("CANCEL")),
      TextButton(onPressed: () { onAdd(tc.text); Navigator.pop(ctx); }, child: const Text("ADD")),
    ],
  ));
}

class ScanStatusBadge extends StatelessWidget {
  final BulkScanStatus status;
  const ScanStatusBadge({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    Color color; String label;
    switch (status) {
      case BulkScanStatus.ready: color = colors.statusSuccess; label = "READY"; break;
      case BulkScanStatus.review: color = colors.statusWarning; label = "REVIEW"; break;
      case BulkScanStatus.duplicate: color = colors.statusWarning; label = "DUPLICATE"; break;
      case BulkScanStatus.notFound: color = colors.statusDanger; label = "NOT FOUND"; break;
      case BulkScanStatus.completed: color = colors.statusSuccess; label = "COMPLETED"; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: color)),
    );
  }
}
