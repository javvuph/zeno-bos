import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class OptometrySpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const OptometrySpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "👓 OPTOMETRY & CONTACT LENSES",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "SPH", initialValue: p.optometrySph, onChanged: (v) => controller.updateField(optometrySph: v))),
            const SizedBox(width: 8),
            Expanded(child: ZenoTextField(label: "CYL", initialValue: p.optometryCyl, onChanged: (v) => controller.updateField(optometryCyl: v))),
            const SizedBox(width: 8),
            Expanded(child: ZenoTextField(label: "AXIS", initialValue: p.optometryAxis, onChanged: (v) => controller.updateField(optometryAxis: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "BASE CURVE", initialValue: p.optometryBaseCurve, onChanged: (v) => controller.updateField(optometryBaseCurve: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DIAMETER", initialValue: p.optometryDiameter, onChanged: (v) => controller.updateField(optometryDiameter: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MOISTURE CONTENT %", initialValue: p.optometryMoistureContent, onChanged: (v) => controller.updateField(optometryMoistureContent: v))),
          ]),
          const SizedBox(height: 16),
          ZenoDropdown<String>(label: "REPLACEMENT SCHEDULE", value: p.optometryReplacementSchedule.isEmpty ? null : p.optometryReplacementSchedule, items: ["Daily Disposable", "Bi-Weekly", "Monthly", "Yearly"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(optometryReplacementSchedule: v)),
        ]),
      ),
    ]);
  }
}
