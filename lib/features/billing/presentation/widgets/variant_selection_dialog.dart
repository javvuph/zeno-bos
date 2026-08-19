import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

class VariantSelectionDialog extends StatelessWidget {
  final List<String> variants;
  final Function(String) onSelected;
  const VariantSelectionDialog({super.key, required this.variants, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return AlertDialog(
      backgroundColor: colors.bgTier2,
      title: const Text("SELECT VARIANT", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
      content: SizedBox(
        width: 300,
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: variants.map((v) => InkWell(
            onTap: () {
              onSelected(v);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)),
              child: Text(v, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          )).toList(),
        ),
      ),
      actions: [
        ZenoButton(label: "Cancel", variant: ZenoButtonVariant.ghost, size: ZenoButtonSize.sm, onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}
