import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class SmartphonesSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const SmartphonesSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📱 SMARTPHONE CORE SPECS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "RAM", initialValue: p.ramSize, onChanged: (v) => controller.updateField(ramSize: v), hint: "e.g. 8GB")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "INTERNAL STORAGE", initialValue: p.internalStorage, onChanged: (v) => controller.updateField(internalStorage: v), hint: "e.g. 256GB")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CHIPSET / PROCESSOR", initialValue: p.chipset, onChanged: (v) => controller.updateField(chipset: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SCREEN SIZE", initialValue: p.screenSize, onChanged: (v) => controller.updateField(screenSize: v), hint: "e.g. 6.7\" OLED")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BATTERY CAPACITY", initialValue: p.batteryCapacity, onChanged: (v) => controller.updateField(batteryCapacity: v), hint: "e.g. 5000mAh")),
            const SizedBox(width: 12),
            _toggle("FAST CHARGING", p.fastChargingSupported, (v) => controller.updateField(fastChargingSupported: v)),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "CELLULAR SUPPORT", initialValue: p.connectivity, onChanged: (v) => controller.updateField(connectivity: v), hint: "e.g. 5G, 4G LTE")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SIM CONFIGURATION", initialValue: p.simSlots, onChanged: (v) => controller.updateField(simSlots: v), hint: "e.g. Dual SIM (Nano)")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "COLOR / FINISH", initialValue: p.colorFinish, onChanged: (v) => controller.updateField(colorFinish: v))),
          ]),
          const SizedBox(height: 16),
          _toggle("WATER RESISTANCE (IP68)", p.weatherproofRating == "IP68", (v) => controller.updateField(weatherproofRating: v ? "IP68" : "None")),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
