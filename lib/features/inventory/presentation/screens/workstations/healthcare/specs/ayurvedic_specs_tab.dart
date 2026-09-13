import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../healthcare_schemas.dart';

class AyurvedicSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const AyurvedicSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌿 AYURVEDIC & HERBAL SPECIFICATIONS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "FORMULATION TYPE", value: p.formulationType.isEmpty ? null : p.formulationType, items: ayurvedaFormulations.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(formulationType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CLASSICAL REFERENCE", initialValue: p.classicalReference, onChanged: (v) => controller.updateField(classicalReference: v), hint: "e.g. Charaka Samhita")),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "HERBAL INGREDIENTS", initialValue: p.ingredients, onChanged: (v) => controller.updateField(ingredients: v), maxLines: 2),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "AYUSH / HEALTH LICENSE", initialValue: p.healthLicense, onChanged: (v) => controller.updateField(healthLicense: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SAFETY CERTIFICATION", initialValue: p.safetyCertifications.join(", "), onChanged: (v) => controller.updateField(safetyCertifications: v.split(",").map((e)=>e.trim()).toList()))),
          ]),
        ]),
      ),
    ]);
  }
}
