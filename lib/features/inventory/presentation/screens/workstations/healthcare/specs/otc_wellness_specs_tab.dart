import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class OtcWellnessSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const OtcWellnessSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌿 OTC & WELLNESS SPECIFICATIONS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "INDICATION CATEGORY", initialValue: p.indicationCategory, onChanged: (v) => controller.updateField(indicationCategory: v), hint: "e.g. Cough & Cold, Skin Care")),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "RECOMMENDED AGE GROUP", value: p.targetAgeGroup.isEmpty ? null : p.targetAgeGroup, items: ["All Ages", "Adult", "Pediatric", "Geriatric"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(targetAgeGroup: v))),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "USAGE INSTRUCTIONS", initialValue: p.shortDescription, onChanged: (v) => controller.updateField(shortDescription: v), maxLines: 2),
          const SizedBox(height: 16),
          ZenoTextField(label: "SELF-MEDICATION WARNING", initialValue: p.selfMedicationWarning, onChanged: (v) => controller.updateField(selfMedicationWarning: v), maxLines: 2, hint: "Statutory warnings if any"),
        ]),
      ),
    ]);
  }
}
