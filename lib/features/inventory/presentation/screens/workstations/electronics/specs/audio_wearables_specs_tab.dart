import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class AudioWearablesSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const AudioWearablesSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🎧 AUDIO & WEARABLE CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "DEVICE TYPE", value: p.audioType.isEmpty ? null : p.audioType, items: ["TWS Earbuds", "Headphones", "Bluetooth Speaker", "Smart Watch"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(audioType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DRIVER SIZE", initialValue: p.driverSize, onChanged: (v) => controller.updateField(driverSize: v), hint: "e.g. 40mm")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "BLUETOOTH VERSION", initialValue: p.bluetoothVersion, onChanged: (v) => controller.updateField(bluetoothVersion: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BATTERY LIFE", initialValue: p.batteryLife, onChanged: (v) => controller.updateField(batteryLife: v), hint: "e.g. 30 Hours")),
          ]),
          const SizedBox(height: 16),
          Wrap(spacing: 24, children: [
            _toggle("ACTIVE NOISE CANCELLATION (ANC)", p.ancSupported, (v) => controller.updateField(ancSupported: v)),
            Expanded(child: ZenoTextField(label: "IP RATING", initialValue: p.weatherproofRating, onChanged: (v) => controller.updateField(weatherproofRating: v))),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
