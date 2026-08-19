import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../../../../controllers/registries/retail_schemas.dart';

class RetailPricePillar extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailPricePillar({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return SingleChildScrollView(
      child: Column(children: [
        ZenoCard(
          title: "💰 Hypermarket Price Trio & Member Offers",
          titleColor: Colors.green,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: ZenoTextField(label: "LANDED COST *", textAlign: TextAlign.center, initialValue: p.costPrice.toString(), onChanged: (v) => controller.updateCost(double.tryParse(v) ?? 0))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "MAX RETAIL PRICE (MRP) *", textAlign: TextAlign.center, initialValue: p.mrp.toString(), onChanged: (v) => controller.updateField(mrp: double.tryParse(v)))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "STORE SELLING PRICE *", textAlign: TextAlign.center, initialValue: p.sellingPrice.toString(), onChanged: (v) => controller.updatePrice(double.tryParse(v) ?? 0))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "MEMBER PRICE", textAlign: TextAlign.center, initialValue: p.memberLoyaltyPrice.toString(), onChanged: (v) => controller.updateField(memberLoyaltyPrice: double.tryParse(v)))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: _segmented("CASHIER MANUAL DISCOUNT", p.posManualDiscount, posDiscountModes, (v) => controller.updateField(posManualDiscount: v))),
              const SizedBox(width: 12),
              Expanded(child: _segmented("PRICE OVERRIDE ON POS", p.posPriceOverride, posDiscountModes, (v) => controller.updateField(posPriceOverride: v))),
              const SizedBox(width: 12),
              Expanded(child: _toggle("AGE GATE REQUIRED", p.posAgeGate, (v) => controller.updateField(posAgeGate: v))),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        ZenoCard(
          title: "🏷️ Multi-Buy Promotional Slabs",
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(child: ZenoTextField(label: "BUY QTY TRIGGER", initialValue: p.multiBuyQtyTrigger.toString(), onChanged: (v) => controller.updateField(multiBuyQtyTrigger: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BUNDLE PRICE", initialValue: p.multiBuyBundlePrice.toString(), onChanged: (v) => controller.updateField(multiBuyBundlePrice: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MAX QTY PER BILL", initialValue: p.multiBuyMaxQtyPerBill.toString(), onChanged: (v) => controller.updateField(multiBuyMaxQtyPerBill: int.tryParse(v)))),
          ]),
        ),
      ]),
    );
  }

  Widget _segmented(String l, String v, List<String> i, ValueChanged<String?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), const SizedBox(height: 8), Wrap(spacing: 4, children: i.map((item) => InkWell(onTap: () => o(item), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: v == item ? colors.accentPrimary.withValues(alpha: 0.1) : colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: v == item ? colors.accentPrimary : colors.borderSubtle)), child: Text(item, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: v == item ? colors.accentPrimary : colors.textPrimary))))).toList())]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary)]);
}
