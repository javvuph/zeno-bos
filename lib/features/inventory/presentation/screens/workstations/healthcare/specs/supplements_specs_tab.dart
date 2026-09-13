import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class SupplementsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const SupplementsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🥤 NUTRACEUTICALS & SUPPLEMENTS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "SERVING SIZE", initialValue: p.servingSize, onChanged: (v) => controller.updateField(servingSize: v), hint: "e.g. 1 Scoop (30g)")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ACTIVE NUTRIENT", initialValue: p.activeNutrient, onChanged: (v) => controller.updateField(activeNutrient: v), hint: "e.g. Whey Protein Isolate")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "VITAMIN / MINERAL %", initialValue: p.nutrientPercentage.toString(), onChanged: (v) => controller.updateField(nutrientPercentage: double.tryParse(v)))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "RECOMMENDED USAGE", initialValue: p.shortDescription, onChanged: (v) => controller.updateField(shortDescription: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REGULATORY LICENSE ID", initialValue: p.healthLicense, onChanged: (v) => controller.updateField(healthLicense: v))),
          ]),
        ]),
      ),
    ]);
  }
}
