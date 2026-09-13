import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailProcurementTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailProcurementTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📦 SUPPLIER PROCUREMENT SPECS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "MINIMUM ORDER QTY (MOQ)", initialValue: p.supplierMOQ.toString(), onChanged: (v) => controller.updateField(supplierMOQ: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SUPPLIER LEAD TIME (DAYS)", initialValue: p.supplierLeadTime.toString(), onChanged: (v) => controller.updateField(supplierLeadTime: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PRIMARY SUPPLIER SKU", initialValue: p.supplierProductCode, onChanged: (v) => controller.updateField(supplierProductCode: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "CONTRACT PURCHASE COST", initialValue: p.supplierPurchaseCost.toString(), onChanged: (v) => controller.updateField(supplierPurchaseCost: double.tryParse(v)), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "TRADE CREDIT TERMS", initialValue: p.tradeCreditTerms, onChanged: (v) => controller.updateField(tradeCreditTerms: v), hint: "e.g. Net 30")),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📈 SUPPLIER PERFORMANCE (OTIF)",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          _metric("ON-TIME DELIVERY", "98.5%", Colors.green),
          _metric("FILL RATE", "94.2%", Colors.green),
          _metric("QC PASS RATE", "100%", Colors.green),
          _metric("RETURN %", "0.5%", Colors.blue),
        ]),
      ),
    ]);
  }

  Widget _metric(String l, String v, Color c) => Expanded(child: Column(children: [Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: c))]));
}
