import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class CctvSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const CctvSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🛡️ CCTV & SMART HOME CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "CAMERA RESOLUTION", initialValue: p.resolution, onChanged: (v) => controller.updateField(resolution: v), hint: "e.g. 4MP, 4K")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "LENS FOCAL LENGTH", initialValue: p.focalLength, onChanged: (v) => controller.updateField(focalLength: v), hint: "e.g. 2.8mm, 4mm")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "PROTOCOL", initialValue: p.iotProtocol, onChanged: (v) => controller.updateField(iotProtocol: v), hint: "Zigbee, Matter, ONVIF")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "WEATHERPROOF RATING", initialValue: p.weatherproofRating, onChanged: (v) => controller.updateField(weatherproofRating: v), hint: "e.g. IP67")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("NIGHT VISION", p.nightVisionEnabled, (v) => controller.updateField(nightVisionEnabled: v)),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
