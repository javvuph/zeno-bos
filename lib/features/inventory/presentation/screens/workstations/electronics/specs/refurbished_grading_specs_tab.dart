import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class RefurbishedGradingSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RefurbishedGradingSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "♻️ REFURBISHED & GRADING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "COSMETIC GRADE", value: p.cosmeticGrade.isEmpty ? null : p.cosmeticGrade, items: ["Grade A (Mint)", "Grade B", "Grade C", "Fair"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(cosmeticGrade: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BATTERY HEALTH %", initialValue: p.batteryHealth, onChanged: (v) => controller.updateField(batteryHealth: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "INSPECTION ID", initialValue: p.inspectionId, onChanged: (v) => controller.updateField(inspectionId: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SELLER WARRANTY", initialValue: p.sellerWarranty, onChanged: (v) => controller.updateField(sellerWarranty: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REPLACED PARTS", initialValue: p.replacedParts, onChanged: (v) => controller.updateField(replacedParts: v))),
            const SizedBox(width: 12),
            _toggle("ORIGINAL BOX INCLUDED", p.originalBoxIncluded, (v) => controller.updateField(originalBoxIncluded: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
