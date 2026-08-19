import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class JuiceBeverageSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const JuiceBeverageSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🥤 JUICE & BEVERAGE CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "DEFAULT VOLUME (ML)", initialValue: p.portionSize, onChanged: (v) => controller.updateField(portionSize: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "SUGAR LEVEL", value: p.sugarLevels.isEmpty ? null : p.sugarLevels.first, items: sugarLevels.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(sugarLevels: [v ?? ""]))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "ICE LEVEL", value: p.recipePrepNotes.isEmpty ? null : p.recipePrepNotes, items: iceLevels.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(recipePrepNotes: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "PROTEIN / BOOSTER ADDS", initialValue: p.virtualBrand, onChanged: (v) => controller.updateField(virtualBrand: v))),
            const SizedBox(width: 12),
            _toggle("COLD-PRESSED", p.isLiveMarketPrice, (v) => controller.updateField(isLiveMarketPrice: v)),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
