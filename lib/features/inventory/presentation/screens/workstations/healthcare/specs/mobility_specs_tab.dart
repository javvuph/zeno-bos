import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class MobilitySpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const MobilitySpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "♿ MOBILITY AIDS & PATIENT CARE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "WEIGHT CAPACITY (KG)", initialValue: p.weightCapacity, onChanged: (v) => controller.updateField(weightCapacity: v))),
            const SizedBox(width: 12),
            _toggle("FOLDABLE", p.isFoldable, (v) => controller.updateField(isFoldable: v)),
            const SizedBox(width: 12),
            _toggle("MOTORIZED", p.isMotorized, (v) => controller.updateField(isMotorized: v)),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("RENTAL AVAILABLE", p.isRentalAvailable, (v) => controller.updateField(isRentalAvailable: v)),
            const SizedBox(width: 24),
            if (p.isRentalAvailable) ...[
              Expanded(child: ZenoTextField(label: "RENTAL PERIOD", initialValue: p.rentalPeriod, onChanged: (v) => controller.updateField(rentalPeriod: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "SECURITY DEPOSIT", initialValue: p.packagingDeposit.toString(), onChanged: (v) => controller.updateField(packagingDeposit: double.tryParse(v)), prefix: const Text("₹"))),
            ] else const Spacer(flex: 2),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
