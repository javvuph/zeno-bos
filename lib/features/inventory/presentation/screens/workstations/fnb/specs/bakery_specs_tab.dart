import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class BakerySpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BakerySpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍰 BAKERY & CONFECTIONERY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "FLAVOR", value: p.cakeFilling.isEmpty ? null : p.cakeFilling, items: cakeFlavors.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(cakeFilling: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CAKE SIZE / WT", initialValue: p.cakeSize, onChanged: (v) => controller.updateField(cakeSize: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SPONGE BASE", initialValue: p.cakeShape, onChanged: (v) => controller.updateField(cakeShape: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "STORAGE TEMP", initialValue: p.temperatureProfile, onChanged: (v) => controller.updateField(temperatureProfile: v), hint: "e.g., 2-8°C")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SHELF LIFE", initialValue: p.bakeryShelfLife, onChanged: (v) => controller.updateField(bakeryShelfLife: v))),
          ]),
          const SizedBox(height: 16),
          Wrap(spacing: 24, children: [
            _toggle("CUSTOM MESSAGE ALLOWED", p.customMessageAllowed, (v) => controller.updateField(customMessageAllowed: v)),
            _toggle("PHOTO PRINT CAPABLE", p.isExpressPrep, (v) => controller.updateField(isExpressPrep: v)),
            _toggle("EGGLESS DEFAULT", p.foodClass == "Vegetarian", (v) => controller.updateField(foodClass: v ? "Vegetarian" : "Non-Vegetarian")),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
