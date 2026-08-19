import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class GarmentSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const GarmentSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "GARMENT BUILD & STYLE",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "NECK / COLLAR TYPE", value: p.sleeveNeckType.isEmpty ? null : p.sleeveNeckType, items: ["Round Neck", "V-Neck", "Polo Collar", "Mandarin", "Hooded"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(sleeveNeckType: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "SLEEVE LENGTH", value: p.styleCategory.isEmpty ? null : p.styleCategory, items: ["Sleeveless", "Short Sleeve", "3/4th Sleeve", "Full Sleeve"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(styleCategory: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "FIT SILHOUETTE", value: p.fitType.isEmpty ? null : p.fitType, items: ["Slim Fit", "Regular Fit", "Oversized", "Relaxed", "Athletic"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(fitType: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "FABRIC & CARE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "PATTERN / WEAVE", value: p.patternDesign.isEmpty ? null : p.patternDesign, items: ["Solid", "Checked", "Striped", "Floral", "Embroidered", "Printed"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(patternDesign: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "FABRIC COMPOSITION %", initialValue: p.ingredients, onChanged: (v) => controller.updateField(ingredients: v), hint: "e.g., 95% Cotton, 5% Elastane")),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "CARE INSTRUCTIONS", value: p.careGuide.isEmpty ? null : p.careGuide, items: ["Machine Wash", "Dry Clean Only", "Hand Wash"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(careGuide: v))),
          ]),
        ]),
      ),
    ]);
  }
}
