import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailPromotionsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailPromotionsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🏷️ ACTIVE PROMOTIONS & BUNDLES",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "PROMO TYPE", value: p.productRelationship, items: ["None", "BOGO", "Bulk Bundle", "Mix & Match", "Member Only"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(productRelationship: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BUY QTY", initialValue: p.multiBuyQtyTrigger.toString(), onChanged: (v) => controller.updateField(multiBuyQtyTrigger: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BUNDLE / PROMO PRICE", initialValue: p.multiBuyBundlePrice.toString(), onChanged: (v) => controller.updateField(multiBuyBundlePrice: double.tryParse(v)), prefix: const Text("₹"))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _datePicker("START DATE", DateTime.now(), (d) {})),
            const SizedBox(width: 12),
            Expanded(child: _datePicker("END DATE", DateTime.now().add(const Duration(days: 30)), (d) {})),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "💎 LOYALTY & REWARDS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "LOYALTY MEMBER PRICE", initialValue: p.memberLoyaltyPrice.toString(), onChanged: (v) => controller.updateField(memberLoyaltyPrice: double.tryParse(v)), prefix: const Text("₹"))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "POINTS MULTIPLIER", initialValue: p.loyaltyPointsMultiplier.toString(), onChanged: (v) => controller.updateField(loyaltyPointsMultiplier: double.tryParse(v)))),
          const SizedBox(width: 12),
          _toggle("REDEMPTION ELIGIBLE", true, (v) {}),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
