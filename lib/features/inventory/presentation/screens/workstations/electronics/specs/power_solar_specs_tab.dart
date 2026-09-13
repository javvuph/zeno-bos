import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class PowerSolarSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const PowerSolarSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🔋 POWER, SOLAR & BATTERIES",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "BATTERY CHEMISTRY", initialValue: p.batteryChemistry, onChanged: (v) => controller.updateField(batteryChemistry: v), hint: "Li-ion, LiFePO4, LCLA")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CAPACITY", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v), hint: "e.g. 200Ah, 10kWh")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "PEAK OUTPUT", initialValue: p.peakOutput.toString(), onChanged: (v) => controller.updateField(peakOutput: double.tryParse(v)), hint: "e.g. 5kW")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SOLAR CHARGE CONTROLLER", initialValue: p.solarChargeController, onChanged: (v) => controller.updateField(solarChargeController: v))),
          ]),
          const SizedBox(height: 16),
          _toggle("PURE SINE WAVE", p.pureSineWave, (v) => controller.updateField(pureSineWave: v)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
