import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class ShishaSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ShishaSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "💨 SHISHA LOUNGE CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "FLAVOR PROFILE", initialValue: p.flavorProfile, onChanged: (v) => controller.updateField(flavorProfile: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "BASE LIQUID", value: p.adjuvantVehicle.isEmpty ? null : p.adjuvantVehicle, items: shishaBases.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(adjuvantVehicle: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DURATION (MINS)", initialValue: p.serviceDuration.toString(), onChanged: (v) => controller.updateField(serviceDuration: int.tryParse(v)))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("MANDATORY AGE GATE", p.posAgeGate, (v) => controller.updateField(posAgeGate: v)),
            const SizedBox(width: 24),
            _toggle("DISPOSABLE PIPE INCLUDED", p.isExpressPrep, (v) => controller.updateField(isExpressPrep: v)),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
