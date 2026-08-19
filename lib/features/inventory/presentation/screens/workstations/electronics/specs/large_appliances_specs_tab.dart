import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class LargeAppliancesSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const LargeAppliancesSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "❄️ LARGE APPLIANCE SPECS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "APPLIANCE TYPE", value: p.apparelCategory.isEmpty ? null : p.apparelCategory, items: ["Refrigerator", "Washing Machine", "Air Conditioner", "Dishwasher"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(apparelCategory: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CAPACITY", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v), hint: "e.g. 350L / 8Kg")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "ENERGY RATING", initialValue: p.energyRating, onChanged: (v) => controller.updateField(energyRating: v), hint: "e.g. 5 Star")),
            const SizedBox(width: 12),
            _toggle("INVERTER TECHNOLOGY", p.inverterTechnology, (v) => controller.updateField(inverterTechnology: v)),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "COMPRESSOR WARRANTY", initialValue: p.scentNotes, onChanged: (v) => controller.updateField(scentNotes: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "REFRIGERANT", initialValue: p.refrigerantType, onChanged: (v) => controller.updateField(refrigerantType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ANNUAL ENERGY (kWh)", initialValue: p.annualEnergyConsumption.toString(), onChanged: (v) => controller.updateField(annualEnergyConsumption: double.tryParse(v)))),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
