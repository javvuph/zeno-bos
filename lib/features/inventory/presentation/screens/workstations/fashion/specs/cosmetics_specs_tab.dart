import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class CosmeticsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const CosmeticsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "SHADE & FINISH",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "SHADE NAME", initialValue: p.shade, onChanged: (v) => controller.updateField(shade: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "HEX CODE", initialValue: p.shadeHexColor, onChanged: (v) => controller.updateField(shadeHexColor: v), prefix: Container(width: 12, height: 12, margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: Color(int.tryParse(p.shadeHexColor.replaceFirst('#', '0xFF')) ?? 0x00000000), shape: BoxShape.circle)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "FINISH TYPE", value: p.fitType.isEmpty ? null : p.fitType, items: ["Matte", "Glossy", "Satin", "Dewy", "Shimmer"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(fitType: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "VOLUME & INGREDIENTS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "NET VOL / WT", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "PAO", value: p.periodAfterOpening.isEmpty ? null : p.periodAfterOpening, items: ["6M", "12M", "24M"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(periodAfterOpening: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "SKIN TYPE", value: p.skinType.isEmpty ? null : p.skinType, items: ["All Skin Types", "Oily", "Dry", "Sensitive", "Combination"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(skinType: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "COMPLIANCE & ETHICS",
        padding: const EdgeInsets.all(16),
        child: Wrap(spacing: 24, children: [
          _toggle("CRUELTY-FREE CERTIFIED", p.biomedicalTraining, (v) => controller.updateField(biomedicalTraining: v)),
          _toggle("100% VEGAN", p.isNarcotic, (v) => controller.updateField(isNarcotic: v)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
