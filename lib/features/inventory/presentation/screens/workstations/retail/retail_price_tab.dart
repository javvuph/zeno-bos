import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailPriceTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailPriceTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "💰 HYPERMARKET PRICE TRIO (EDLP ENGINE)",
        titleColor: Colors.green,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "LANDED COST *", initialValue: p.costPrice.toString(), onChanged: (v) => controller.updateCost(double.tryParse(v) ?? 0), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MAX RETAIL PRICE (MRP) *", initialValue: p.mrp.toString(), onChanged: (v) => controller.updateField(mrp: double.tryParse(v)), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "STORE SELLING PRICE *", initialValue: p.sellingPrice.toString(), onChanged: (v) => controller.updatePrice(double.tryParse(v) ?? 0), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "LOYALTY MEMBER PRICE", initialValue: p.memberLoyaltyPrice.toString(), onChanged: (v) => controller.updateField(memberLoyaltyPrice: double.tryParse(v)), prefix: const Text("₹"))),
          ]),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: _segmented("CASHIER MANUAL DISCOUNT", p.posManualDiscount, ["Allowed", "Supervisor PIN", "Blocked"], (v) => controller.updateField(posManualDiscount: v))),
            const SizedBox(width: 12),
            Expanded(child: _segmented("PRICE OVERRIDE ON POS", p.posPriceOverride, ["Allowed", "Supervisor PIN", "Blocked"], (v) => controller.updateField(posPriceOverride: v))),
            const SizedBox(width: 12),
            Expanded(child: _segmented("AGE GATE CHECK", p.posAgeGate ? "21+ Mandatory" : "None", ["None", "18+ Mandatory", "21+ Mandatory"], (v) => controller.updateField(posAgeGate: v != "None"))),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📈 MULTI-BUY PROMOTIONAL SLABS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "BUY QTY TRIGGER", initialValue: p.multiBuyQtyTrigger.toString(), onChanged: (v) => controller.updateField(multiBuyQtyTrigger: int.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "BUNDLE PRICE", initialValue: p.multiBuyBundlePrice.toString(), onChanged: (v) => controller.updateField(multiBuyBundlePrice: double.tryParse(v)), prefix: const Text("₹"))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "MAX QTY PER BILL", initialValue: p.multiBuyMaxQtyPerBill.toString(), onChanged: (v) => controller.updateField(multiBuyMaxQtyPerBill: int.tryParse(v)))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📦 STOCK TRACKING & REORDER",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            _toggle("TRACK STOCK", p.trackInventory, (v) => controller.updateField(trackInventory: v)),
            const SizedBox(width: 24),
            Expanded(child: ZenoDropdown<String>(label: "DEFAULT WAREHOUSE", value: p.warehouseLocation, items: ["Main HQ", "WH 1", "Store Front"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(warehouseLocation: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "OPENING STOCK", initialValue: p.openingStock.toString(), onChanged: (v) => controller.updateField(openingStock: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SAFETY STOCK", initialValue: p.safetyStock.toString(), onChanged: (v) => controller.updateField(safetyStock: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "REORDER TRIGGER LEVEL", initialValue: p.reorderLevel.toString(), onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v)))),
          ]),
        ]),
      ),
    ]);
  }

  Widget _segmented(String l, String v, List<String> i, ValueChanged<String?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), const SizedBox(height: 8), Wrap(spacing: 4, children: i.map((item) => InkWell(onTap: () => o(item), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: v == item ? colors.accentPrimary.withValues(alpha: 0.1) : colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: v == item ? colors.accentPrimary : colors.borderSubtle)), child: Text(item, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: v == item ? colors.accentPrimary : colors.textPrimary))))).toList())]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
