import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class GenericMappingSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const GenericMappingSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🔄 GENERIC DRUG SUBSTITUTION",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "MASTER MOLECULE CODE", initialValue: p.masterMoleculeCode, onChanged: (v) => controller.updateField(masterMoleculeCode: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "GENERIC ALTERNATIVE", initialValue: p.genericAlternative, onChanged: (v) => controller.updateField(genericAlternative: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "CLASSIFICATION", value: p.brandType, items: ["Brand", "Generic", "Branded Generic"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(brandType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "EQUIVALENT STRENGTH", initialValue: p.potency, onChanged: (v) => controller.updateField(potency: v))),
          ]),
          const SizedBox(height: 16),
          _toggle("SUBSTITUTION ALLOWED AT POS", p.substitutionAllowed, (v) => controller.updateField(substitutionAllowed: v)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
