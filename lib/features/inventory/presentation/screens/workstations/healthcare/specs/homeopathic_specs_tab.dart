import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class HomeopathicSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const HomeopathicSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🧪 HOMEOPATHIC MEDICINE SPECS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "REMEDY LATIN NAME *", initialValue: p.homeopathyLatinName, onChanged: (v) => controller.updateField(homeopathyLatinName: v), hint: "e.g. Arnica Montana")),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "POTENCY SCALE", value: p.homeopathyPotencyScale.isEmpty ? null : p.homeopathyPotencyScale, items: ["C (Centesimal)", "X (Decimal)", "LM (Q)"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(homeopathyPotencyScale: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "POTENCY", initialValue: p.potency, onChanged: (v) => controller.updateField(potency: v), hint: "e.g. 30, 200, 1M")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DILUTION / TRITURATION", initialValue: p.homeopathyDilution, onChanged: (v) => controller.updateField(homeopathyDilution: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MOTHER TINCTURE (Q)", initialValue: p.homeopathyMotherTincture, onChanged: (v) => controller.updateField(homeopathyMotherTincture: v))),
          ]),
        ]),
      ),
    ]);
  }
}
