import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class LaptopsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const LaptopsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "💻 COMPUTING SPECIFICATIONS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "PROCESSOR", initialValue: p.processor, onChanged: (v) => controller.updateField(processor: v), hint: "e.g. Core i7 13th Gen")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "RAM SIZE", initialValue: p.ramSize, onChanged: (v) => controller.updateField(ramSize: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "RAM GENERATION", initialValue: p.ramGeneration, onChanged: (v) => controller.updateField(ramGeneration: v), hint: "e.g. DDR5")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "STORAGE", initialValue: p.internalStorage, onChanged: (v) => controller.updateField(internalStorage: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "STORAGE TYPE", value: p.packageForm.isEmpty ? null : p.packageForm, items: ["SSD", "HDD", "NVMe"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(packageForm: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DEDICATED GPU", initialValue: p.dedicatedGpu, onChanged: (v) => controller.updateField(dedicatedGpu: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "DISPLAY", initialValue: p.screenSize, onChanged: (v) => controller.updateField(screenSize: v), hint: "e.g. 15.6\" 4K OLED")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "OPERATING SYSTEM", initialValue: p.osVersion, onChanged: (v) => controller.updateField(osVersion: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "WEIGHT (KG)", initialValue: p.weight.toString(), onChanged: (v) => controller.updateField(weight: double.tryParse(v)))),
          ]),
        ]),
      ),
    ]);
  }
}
