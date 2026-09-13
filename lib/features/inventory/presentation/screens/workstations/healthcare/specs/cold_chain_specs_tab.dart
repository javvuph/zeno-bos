import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class ColdChainSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ColdChainSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "❄️ COLD CHAIN & BIOLOGICS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "MIN STORAGE TEMP (°C)", initialValue: p.minStorageTemp.toString(), onChanged: (v) => controller.updateField(minStorageTemp: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MAX STORAGE TEMP (°C)", initialValue: p.maxStorageTemp.toString(), onChanged: (v) => controller.updateField(maxStorageTemp: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DATA LOGGER SERIAL ID", initialValue: p.dataLoggerSerialId, onChanged: (v) => controller.updateField(dataLoggerSerialId: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "MAX ROOM TEMP EXPOSURE (MINS)", initialValue: p.maxRoomTempExposure.toString(), onChanged: (v) => controller.updateField(maxRoomTempExposure: double.tryParse(v)))),
            const SizedBox(width: 12),
            _toggle("COLD CHAIN REQUIRED", p.coldChainRequired, (v) => controller.updateField(coldChainRequired: v)),
            const Spacer(),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "STORAGE NOTES", initialValue: p.recipePrepNotes, onChanged: (v) => controller.updateField(recipePrepNotes: v), maxLines: 2),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
