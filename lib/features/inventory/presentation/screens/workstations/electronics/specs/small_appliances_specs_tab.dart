import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class SmallAppliancesSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const SmallAppliancesSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍳 SMALL APPLIANCE SPECS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "APPLIANCE TYPE", initialValue: p.apparelCategory, onChanged: (v) => controller.updateField(apparelCategory: v), hint: "e.g. Mixer Grinder, Air Fryer")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MOTOR WATTAGE", initialValue: p.motorWattage, onChanged: (v) => controller.updateField(motorWattage: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "JAR / BOWL CAPACITY", initialValue: p.jarCapacity, onChanged: (v) => controller.updateField(jarCapacity: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SPEED CONTROLS", initialValue: p.speedControls, onChanged: (v) => controller.updateField(speedControls: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "HEATING ELEMENTS", initialValue: p.heatingElements, onChanged: (v) => controller.updateField(heatingElements: v))),
            const SizedBox(width: 12),
            _toggle("DISHWASHER SAFE", p.dishwasherSafe, (v) => controller.updateField(dishwasherSafe: v)),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
