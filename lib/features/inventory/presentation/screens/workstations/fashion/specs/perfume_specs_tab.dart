import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class PerfumeSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const PerfumeSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "FRAGRANCE FAMILY & COMPOSITION",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "FRAGRANCE FAMILY", value: p.fragranceFamily.isEmpty ? null : p.fragranceFamily, items: ["Woody", "Oriental / Amber", "Fresh / Citrus", "Floral", "Gourmand"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(fragranceFamily: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "CONCENTRATION", value: p.concentration.isEmpty ? null : p.concentration, items: ["Eau de Parfum (EDP)", "Eau de Toilette (EDT)", "Parfum / Extrait", "Attar / Concentrated Oil"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(concentration: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "NET VOLUME (ML)", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "OLFACTORY PYRAMID",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "TOP NOTES", initialValue: p.topNotes, onChanged: (v) => controller.updateField(topNotes: v))),
          const SizedBox(width: 8),
          Expanded(child: ZenoTextField(label: "HEART NOTES", initialValue: p.middleNotes, onChanged: (v) => controller.updateField(middleNotes: v))),
          const SizedBox(width: 8),
          Expanded(child: ZenoTextField(label: "BASE NOTES", initialValue: p.baseNotes, onChanged: (v) => controller.updateField(baseNotes: v))),
        ]),
      ),
    ]);
  }
}
