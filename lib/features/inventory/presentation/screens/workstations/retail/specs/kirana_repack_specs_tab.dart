import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class KiranaRepackSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const KiranaRepackSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌾 IN-HOUSE BULK REPACKING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "BULK SOURCE UNIT", value: p.purchaseUnit, items: ["50kg Gunny Bag", "25kg Drum", "10kg Sack"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'purchaseUnit', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "REPACK SELLING PACK", value: p.stockUnit, items: ["500g Pouch", "1kg Pouch", "2kg Pouch", "Piece"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'stockUnit', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CONVERSION FACTOR", initialValue: p.conversionFactor.toString(), onChanged: (v) => controller.updateFieldById(p, 'conversionFactor', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "NET WEIGHT", initialValue: p.weight.toString(), onChanged: (v) => controller.updateFieldById(p, 'weight', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "STORAGE CLASS", initialValue: p.storageClass, onChanged: (v) => controller.updateFieldById(p, 'storageClass', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SHELF LIFE (DAYS)", initialValue: p.bakeryShelfLife, onChanged: (v) => controller.updateFieldById(p, 'bakeryShelfLife', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "COUNTRY OF ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "INGREDIENTS / INFO", initialValue: p.ingredients, onChanged: (v) => controller.updateFieldById(p, 'ingredients', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("GENERATE IN-HOUSE BARCODE", p.inHouseRepack, (v) => controller.updateFieldById(p, 'inHouseRepack', v)),
            const SizedBox(width: 24),
            _toggle("ALLOW LOOSE SCOOP", p.allowLooseBilling, (v) => controller.updateFieldById(p, 'allowLooseBilling', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
