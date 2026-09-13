import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class BarPubSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BarPubSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍸 BAR & PUB CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "ABV %", initialValue: p.abv.toString(), onChanged: (v) => controller.updateField(abv: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "POUR VOLUME", initialValue: p.barPourMetric, onChanged: (v) => controller.updateField(barPourMetric: v), hint: "30ml, 60ml, etc.")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "LIQUOR CLASS", initialValue: p.barLiquorClass, onChanged: (v) => controller.updateField(barLiquorClass: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "EXCISE LICENSE ID", initialValue: p.ssccBarcode, onChanged: (v) => controller.updateField(ssccBarcode: v))),
            const SizedBox(width: 12),
            _toggle("HAPPY HOUR ELIGIBLE", p.isAppointmentRequired, (v) => controller.updateField(isAppointmentRequired: v)),
            const SizedBox(width: 12),
            _toggle("MANDATORY AGE GATE", p.posAgeGate, (v) => controller.updateField(posAgeGate: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
