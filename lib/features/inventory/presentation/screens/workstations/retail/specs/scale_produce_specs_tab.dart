import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class ScaleProduceSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ScaleProduceSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "⚖️ DIGITAL SCALE & CATCH WEIGHT",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            _toggle("SCALE PRODUCT", p.isLiveMarketPrice, (v) => controller.updateFieldById(p, 'isLiveMarketPrice', v)),
            const SizedBox(width: 24),
            if (p.isLiveMarketPrice && controller.isFieldVisible('pluCode')) ...[
              Expanded(child: ZenoTextField(label: "SCALE PLU CODE *", initialValue: p.pluCode, onChanged: (v) => controller.updateFieldById(p, 'pluCode', v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoDropdown<int>(label: "PRECISION", value: p.scaleWeightPrecision, items: [2, 3].map((e)=>DropdownMenuItem(value: e, child: Text("$e Dec"))).toList(), onChanged: (v) => controller.updateFieldById(p, 'scaleWeightPrecision', v))),
            ] else const Spacer(flex: 2),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('tareWeightDeduction'))
            Expanded(child: ZenoTextField(label: "TARE DEDUCTION (G)", initialValue: p.tareWeightDeduction.toString(), onChanged: (v) => controller.updateFieldById(p, 'tareWeightDeduction', v))),
            if (controller.isFieldVisible('unitPriceComparisonBase'))
            Expanded(child: ZenoDropdown<String>(label: "PRICE BASE", value: p.unitPriceComparisonBase, items: ["Per 100g", "Per 1 Kg"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'unitPriceComparisonBase', v))),
            if (controller.isFieldVisible('wastagePct'))
            Expanded(child: ZenoTextField(label: "WASTE / YIELD %", initialValue: p.wastagePct.toString(), onChanged: (v) => controller.updateFieldById(p, 'wastagePct', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('styleCategory'))
            Expanded(child: ZenoTextField(label: "PRODUCE VARIETY", initialValue: p.styleCategory, onChanged: (v) => controller.updateFieldById(p, 'styleCategory', v))),
            if (controller.isFieldVisible('countryOfOrigin'))
            Expanded(child: ZenoTextField(label: "COUNTRY / FARM OF ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('harvestDate'))
            Expanded(child: _datePicker("HARVEST DATE", p.harvestDate, (d) => controller.updateFieldById(p, 'harvestDate', d))),
            if (controller.isFieldVisible('freshnessDuration'))
            Expanded(child: ZenoTextField(label: "SHELF LIFE (DAYS)", initialValue: p.freshnessDuration.toString(), onChanged: (v) => controller.updateFieldById(p, 'freshnessDuration', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('isCatchWeight'))
            _toggle("CATCH / VARIABLE WEIGHT", p.isCatchWeight, (v) => controller.updateFieldById(p, 'isCatchWeight', v)),
            const SizedBox(width: 24),
            if (controller.isFieldVisible('allowLooseBilling'))
            _toggle("ALLOW LOOSE PACK SELLING", p.allowLooseBilling, (v) => controller.updateFieldById(p, 'allowLooseBilling', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
