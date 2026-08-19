import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../healthcare_schemas.dart';

class ControlledDrugsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ControlledDrugsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🚫 CONTROLLED & NARCOTIC DRUGS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "DRUG SCHEDULE", value: p.drugSchedule.isEmpty ? null : p.drugSchedule, items: rxClasses.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(drugSchedule: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CONTROLLED REGISTER ID", initialValue: p.controlledRegisterId, onChanged: (v) => controller.updateField(controlledRegisterId: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("PRESCRIPTION REQUIRED", p.prescriptionClass != "OTC", (v) => controller.updateField(prescriptionClass: v ? "Rx Mandatory" : "OTC")),
            const SizedBox(width: 24),
            _toggle("MANDATORY ID VERIFICATION", p.posAgeGate, (v) => controller.updateField(posAgeGate: v)),
            const SizedBox(width: 24),
            _toggle("NARCOTIC LOGGING", p.isNarcotic, (v) => controller.updateField(isNarcotic: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
