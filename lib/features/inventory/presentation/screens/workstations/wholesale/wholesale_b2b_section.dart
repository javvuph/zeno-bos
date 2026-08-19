import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/wholesale_schemas.dart';

class WholesaleB2BSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const WholesaleB2BSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return SingleChildScrollView(
      child: Column(children: [
        ZenoCard(
          title: "💰 B2B Logistics & Price Lists",
          titleColor: colors.accentPrimary,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: ZenoDropdown<String>(label: "INCOTERMS", value: p.incoterms, items: incotermsOptions.map((i)=>DropdownMenuItem(value: i, child: Text(i))).toList(), onChanged: (v) => controller.updateField(incoterms: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "SSCC / PALLET BARCODE", initialValue: p.ssccBarcode, onChanged: (v) => controller.updateField(ssccBarcode: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "TAX EXEMPTION / RESALE NO", initialValue: p.taxExemptionNo, onChanged: (v) => controller.updateField(taxExemptionNo: v))),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        ZenoCard(
          title: "📈 Multi-Tier Volume Pricing",
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _tierHeader(),
            _tierRow("10 - 49 Units", "\$95.00", "15%", "Retailer"),
            _tierRow("50 - 99 Units", "\$88.00", "22%", "Stockist"),
            _tierRow("100+ Units", "\$80.00", "28%", "Super-Stockist"),
          ]),
        ),
      ]),
    );
  }

  Widget _tierHeader() => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(4)), child: const Row(children: [Expanded(flex: 2, child: Text("SLAB RANGE", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 1, child: Text("PRICE", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 1, child: Text("MARGIN", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 2, child: Text("CUSTOMER GROUP", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900)))]));
  Widget _tierRow(String r, String p, String m, String g) => Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), child: Row(children: [Expanded(flex: 2, child: Text(r, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))), Expanded(flex: 1, child: Text(p, style: const TextStyle(fontSize: 10))), Expanded(flex: 1, child: Text(m, style: const TextStyle(fontSize: 10, color: Colors.green))), Expanded(flex: 2, child: Text(g, style: const TextStyle(fontSize: 10)))]));
}
