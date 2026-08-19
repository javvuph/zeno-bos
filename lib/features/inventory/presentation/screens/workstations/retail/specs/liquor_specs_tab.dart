import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class LiquorSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const LiquorSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍾 EXCISE & REGULATORY COMPLIANCE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "BEVERAGE TYPE", value: p.barLiquorClass, items: ["Whisky", "Gin", "Vodka", "Wine", "Beer", "Rum"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'barLiquorClass', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ABV % *", initialValue: p.abv.toString(), onChanged: (v) => controller.updateFieldById(p, 'abv', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "BOTTLE VOLUME", value: p.volume, items: ["180ml", "375ml", "750ml", "1000ml"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'volume', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "VINTAGE / YEAR", initialValue: p.collectionEdition, onChanged: (v) => controller.updateFieldById(p, 'collectionEdition', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REGION", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "EXCISE BARCODE / BAND", initialValue: p.ssccBarcode, onChanged: (v) => controller.updateFieldById(p, 'ssccBarcode', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "LICENSE REFERENCE", initialValue: p.healthLicense, onChanged: (v) => controller.updateFieldById(p, 'healthLicense', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BOTTLE DEPOSIT (DRS)", initialValue: p.containerDepositFee.toString(), onChanged: (v) => controller.updateFieldById(p, 'containerDepositFee', v), prefix: const Text("₹"))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("MANDATORY AGE GATE", p.posAgeGate, (v) => controller.updateFieldById(p, 'posAgeGate', v)),
            const SizedBox(width: 24),
            Expanded(child: ZenoTextField(label: "COUNTRY OF ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
