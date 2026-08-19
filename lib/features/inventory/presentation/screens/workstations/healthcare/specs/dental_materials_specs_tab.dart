import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class DentalMaterialsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const DentalMaterialsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🦷 DENTAL CONSUMABLES & RESTORATIVE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "MATERIAL TYPE", initialValue: p.material, onChanged: (v) => controller.updateField(material: v), hint: "e.g. Composite, Alginate")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SHADE", initialValue: p.shade, onChanged: (v) => controller.updateField(shade: v), hint: "e.g. A1, A2, B1")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "CURING TIME (SEC)", initialValue: p.curingTime, onChanged: (v) => controller.updateField(curingTime: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SETTING EXPANSION %", initialValue: p.settingExpansion, onChanged: (v) => controller.updateField(settingExpansion: v))),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "SAFETY DATA SHEET (SDS) REF", initialValue: p.metaDescription, onChanged: (v) => controller.updateField(metaDescription: v)),
        ]),
      ),
    ]);
  }
}
