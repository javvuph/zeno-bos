import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class JewelrySpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const JewelrySpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "METALS & PURITY",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "METAL TYPE", value: p.metalType.isEmpty ? null : p.metalType, items: ["Yellow Gold", "White Gold", "Rose Gold", "Platinum", "925 Silver"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(metalType: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "KARAT PURITY", value: p.purity.isEmpty ? null : p.purity, items: ["24K (99.9%)", "22K (91.6%)", "18K (75.0%)", "14K (58.5%)", "925 Sterling"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(purity: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "HALLMARK / BIS ID", initialValue: p.hallmarkCert, onChanged: (v) => controller.updateField(hallmarkCert: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "WEIGHT & STONES",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "GROSS WEIGHT (G)", initialValue: p.grossWeight.toString(), onChanged: (v) => controller.updateField(grossWeight: double.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "NET METAL WEIGHT (G)", initialValue: p.weight.toString(), onChanged: (v) => controller.updateField(weight: double.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "STONE CARATS (CTS)", initialValue: p.stoneWeight.toString(), onChanged: (v) => controller.updateField(stoneWeight: double.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "STONE COUNT & TYPE", initialValue: p.stoneType, onChanged: (v) => controller.updateField(stoneType: v), hint: "e.g., VVS Diamond")),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "CHARGES & PRICING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "MAKING CHARGES (FIXED/%)", initialValue: p.makingChargeRate.toString(), onChanged: (v) => controller.updateField(makingChargeRate: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "WASTAGE %", initialValue: p.wastagePct.toString(), onChanged: (v) => controller.updateField(wastagePct: double.tryParse(v)))),
            const Spacer(),
            Row(children: [
              const Text("DAILY RATE AUTO-PRICE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Switch(value: false, onChanged: (v) {}, activeThumbColor: colors.accentPrimary),
            ]),
          ]),
        ]),
      ),
    ]);
  }
}
