import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class FootwearSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FootwearSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "FOOTWEAR MATERIAL & BUILD",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "UPPER MATERIAL", value: p.material.isEmpty ? null : p.material, items: ["Genuine Leather", "Synthetic Leather", "Mesh", "Canvas", "Suede", "Knit"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(material: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "SOLE MATERIAL", value: p.soleMaterial.isEmpty ? null : p.soleMaterial, items: ["Rubber", "EVA", "TPU", "Phylon", "Polyurethane (PU)", "Leather"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(soleMaterial: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "CLOSURE TYPE", value: p.closureType.isEmpty ? null : p.closureType, items: ["Lace-Up", "Slip-On", "Velcro", "Zipper", "Buckle", "Elastic"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(closureType: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "SHAPE & FIT",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "SHOE WIDTH", value: p.widthFit.isEmpty ? null : p.widthFit, items: ["Narrow", "Regular / Medium (D/M)", "Wide (EE)", "Extra Wide (4E)"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(widthFit: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "HEEL STYLE", value: p.fitType.isEmpty ? null : p.fitType, items: ["Flat (<1\")", "Low (1-2\")", "Mid", "High Heel", "Wedge", "Platform"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(fitType: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "TOE SHAPE", value: p.patternDesign.isEmpty ? null : p.patternDesign, items: ["Round Toe", "Pointed Toe", "Square Toe", "Steel Safety Toe"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(patternDesign: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "LOGISTICS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "OCCASION / ACTIVITY", value: p.styleCategory.isEmpty ? null : p.styleCategory, items: ["Casual", "Sports / Running", "Formal / Office", "Safety / Work"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(styleCategory: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "TOTAL PAIR WEIGHT (GRAMS)", initialValue: p.weight.toString(), onChanged: (v) => controller.updateField(weight: double.tryParse(v)))),
          const Spacer(),
        ]),
      ),
    ]);
  }
}
