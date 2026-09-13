import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailMerchandisingTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailMerchandisingTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📊 MERCHANDISING & ASSORTMENT",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "ASSORTMENT TYPE", value: "Core", items: ["Core", "Optional", "Seasonal", "Regional"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) {})),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DISPLAY ZONE", initialValue: p.floorZone, onChanged: (v) => controller.updateField(floorZone: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("PRIVATE LABEL ITEM", p.brandType == "Private Label", (v) => controller.updateField(brandType: v ? "Private Label" : "National")),
            const SizedBox(width: 24),
            _toggle("SEASONAL ASSORTMENT", p.seasonalProduct, (v) => controller.updateField(seasonalProduct: v)),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📍 SHELF PLACEMENT (PLANOGRAM)",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "PLANOGRAM ID", initialValue: p.planogramId, onChanged: (v) => controller.updateField(planogramId: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "FACING COUNT", initialValue: p.minDisplayQty.toString(), onChanged: (v) => controller.updateField(minDisplayQty: int.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "SHELF HEIGHT", value: "Eye Level", items: ["Bottom", "Waist", "Eye Level", "Top"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) {})),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
