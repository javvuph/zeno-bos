import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class ComponentsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ComponentsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🧩 ELECTRONIC COMPONENTS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "COMPONENT TYPE", initialValue: p.material, onChanged: (v) => controller.updateField(material: v), hint: "e.g. IC, Capacitor, Resistor")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "OPERATING VOLTAGE", initialValue: p.operatingVoltage, onChanged: (v) => controller.updateField(operatingVoltage: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "MOUNTING TYPE", initialValue: p.mountingType, onChanged: (v) => controller.updateField(mountingType: v), hint: "SMD / Through-hole")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PACKAGE TYPE", initialValue: p.packageForm, onChanged: (v) => controller.updateField(packageForm: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PIN COUNT", initialValue: p.pinCount.toString(), onChanged: (v) => controller.updateField(pinCount: int.tryParse(v)))),
          ]),
        ]),
      ),
    ]);
  }
}
