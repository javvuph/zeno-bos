import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class TelevisionsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const TelevisionsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📺 TELEVISION & HOME CINEMA",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "SCREEN SIZE", initialValue: p.screenSize, onChanged: (v) => controller.updateField(screenSize: v), hint: "e.g. 55\"")),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "PANEL TECHNOLOGY", value: p.panelTechnology.isEmpty ? null : p.panelTechnology, items: ["LED", "QLED", "OLED", "Mini-LED"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(panelTechnology: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "RESOLUTION", initialValue: p.resolution, onChanged: (v) => controller.updateField(resolution: v), hint: "e.g. 4K Ultra HD")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REFRESH RATE", initialValue: p.refreshRate, onChanged: (v) => controller.updateField(refreshRate: v), hint: "e.g. 120Hz")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SMART TV OS", initialValue: p.smartTvOs, onChanged: (v) => controller.updateField(smartTvOs: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "HDR FORMAT", initialValue: p.hdrFormat, onChanged: (v) => controller.updateField(hdrFormat: v), hint: "e.g. HDR10+, Dolby Vision")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "HDMI PORT COUNT", initialValue: p.hdmiPorts, onChanged: (v) => controller.updateField(hdmiPorts: v))),
          ]),
        ]),
      ),
    ]);
  }
}
