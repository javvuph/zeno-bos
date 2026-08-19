import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class VeterinarySpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const VeterinarySpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🐾 VETERINARY MEDICINES & CARE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "TARGET SPECIES", initialValue: p.targetSpecies, onChanged: (v) => controller.updateField(targetSpecies: v), hint: "e.g. Canine, Feline, Equine")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ANIMAL WEIGHT RANGE", initialValue: p.animalWeightRange, onChanged: (v) => controller.updateField(animalWeightRange: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "DOSAGE SCALE", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v), hint: "e.g. 5mg/kg")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MEAT WITHDRAWAL PERIOD", initialValue: p.meatWithdrawalPeriod, onChanged: (v) => controller.updateField(meatWithdrawalPeriod: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MILK WITHDRAWAL PERIOD", initialValue: p.milkWithdrawalPeriod, onChanged: (v) => controller.updateField(milkWithdrawalPeriod: v))),
          ]),
        ]),
      ),
    ]);
  }
}
