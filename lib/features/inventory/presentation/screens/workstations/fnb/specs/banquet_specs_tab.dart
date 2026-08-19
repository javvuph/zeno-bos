import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class BanquetSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BanquetSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🎊 BANQUET & CATERING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "MINIMUM PAX", initialValue: p.minPax.toString(), onChanged: (v) => controller.updateField(minPax: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PER-HEAD FOOD COST", initialValue: p.diagnosisCharge.toString(), onChanged: (v) => controller.updateField(diagnosisCharge: double.tryParse(v)), prefix: const Text("₹"))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SERVICE SETUP", initialValue: p.styleCategory, onChanged: (v) => controller.updateField(styleCategory: v), hint: "Buffet, Pre-plated, etc.")),
            const SizedBox(width: 12),
            _toggle("LIVE STATION REQ", p.isExpressPrep, (v) => controller.updateField(isExpressPrep: v)),
            const SizedBox(width: 12),
            _toggle("HOT-BOX TRANSPORT", p.isLiveMarketPrice, (v) => controller.updateField(isLiveMarketPrice: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
