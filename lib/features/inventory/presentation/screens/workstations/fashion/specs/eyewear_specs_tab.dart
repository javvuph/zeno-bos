import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class EyewearSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const EyewearSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "FRAME SPECIFICATIONS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "FRAME DIMENSIONS", initialValue: p.frameParameters, onChanged: (v) => controller.updateField(frameParameters: v), hint: "e.g., 52-18-140")),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "FRAME SHAPE", value: p.patternDesign.isEmpty ? null : p.patternDesign, items: ["Aviator", "Wayfarer", "Round", "Rectangle", "Cat-Eye", "Rimless"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(patternDesign: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "FRAME MATERIAL", value: p.material.isEmpty ? null : p.material, items: ["Acetate", "Titanium", "Metal Alloy", "TR90", "Wood"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(material: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "LENS TECHNOLOGY",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "LENS INDEX", value: p.lensIndex.isEmpty ? null : p.lensIndex, items: ["1.50 Standard", "1.56 Mid", "1.61 Hi-Index", "1.67 Ultra-Thin", "1.74"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(lensIndex: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "LENS COATINGS", initialValue: p.lensCoating.join(", "), onChanged: (v) => controller.updateField(lensCoating: v.split(",").map((e)=>e.trim()).toList()), hint: "ARC, Blue-Cut, etc.")),
          const SizedBox(width: 12),
          _toggle("PRESCRIPTION REQUIRED", p.consentRequired, (v) => controller.updateField(consentRequired: v)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
