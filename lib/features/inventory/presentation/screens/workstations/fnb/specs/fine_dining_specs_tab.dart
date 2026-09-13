import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class FineDiningSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FineDiningSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍷 FINE DINING SPECIFICATIONS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "WINE / DRINK PAIRING", value: p.winePairing.isEmpty ? null : p.winePairing, items: winePairings.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(winePairing: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "SERVING TEMPERATURE", value: p.coffeeServingTemp.isEmpty ? null : p.coffeeServingTemp, items: servingTemps.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(coffeeServingTemp: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "COURSE SEQUENCE", initialValue: p.fineDiningCourse, onChanged: (v) => controller.updateField(fineDiningCourse: v), hint: "e.g., 2nd of 7 courses")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PLATING / CUTLERY PRESET", initialValue: p.cakeFrosting, onChanged: (v) => controller.updateField(cakeFrosting: v))),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "SOMMELIER NOTES", initialValue: p.recipePrepNotes, onChanged: (v) => controller.updateField(recipePrepNotes: v), maxLines: 3),
        ]),
      ),
    ]);
  }
}
