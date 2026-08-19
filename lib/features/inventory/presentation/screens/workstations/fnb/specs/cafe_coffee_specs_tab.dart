import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class CafeCoffeeSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const CafeCoffeeSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "☕ CAFE & BARISTA CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "CUP SIZE", value: p.portionSize.isEmpty ? null : p.portionSize, items: coffeeCupSizes.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(portionSize: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "BREW METHOD", value: p.flavorProfile.isEmpty ? null : p.flavorProfile, items: brewMethods.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(flavorProfile: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "TEMP", value: p.temperatureProfile.isEmpty ? null : p.temperatureProfile, items: ["Hot", "Iced"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(temperatureProfile: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "BEAN ROAST", initialValue: p.bakeryType, onChanged: (v) => controller.updateField(bakeryType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BEAN ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateField(countryOfOrigin: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "PLANT MILK", value: p.milkOptions.isEmpty ? null : p.milkOptions.first, items: plantMilks.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(milkOptions: [v ?? ""]))),
            const SizedBox(width: 12),
            _toggle("EXTRA ESPRESSO SHOT", p.extraShotAllowed, (v) => controller.updateField(extraShotAllowed: v)),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
