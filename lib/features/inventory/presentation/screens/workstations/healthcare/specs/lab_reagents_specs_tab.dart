import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class LabReagentsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const LabReagentsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🔬 DIAGNOSTIC KITS & REAGENTS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "REAGENT TYPE", initialValue: p.reagentType, onChanged: (v) => controller.updateField(reagentType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SENSITIVITY", initialValue: p.reagentSensitivity, onChanged: (v) => controller.updateField(reagentSensitivity: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "STORAGE TEMPERATURE", initialValue: p.storageCondition, onChanged: (v) => controller.updateField(storageCondition: v), hint: "e.g. 2-8°C")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CALIBRATION FREQUENCY", initialValue: p.calibrationFrequency.toString(), onChanged: (v) => controller.updateField(calibrationFrequency: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "IVD LICENSE ID", initialValue: p.healthLicense, onChanged: (v) => controller.updateField(healthLicense: v))),
          ]),
        ]),
      ),
    ]);
  }
}
