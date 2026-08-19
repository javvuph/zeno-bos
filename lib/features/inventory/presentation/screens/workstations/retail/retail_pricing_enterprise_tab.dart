import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailPricingEnterpriseTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailPricingEnterpriseTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌍 REGIONAL & ZONE PRICING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _zoneRow("NORTH ZONE (NCR)", "₹420.00", "₹450.00"),
          const Divider(),
          _zoneRow("SOUTH ZONE (BLR)", "₹399.00", "₹430.00"),
          const Divider(),
          _zoneRow("WEST ZONE (MUM)", "₹425.00", "₹455.00"),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📅 SCHEDULED PRICE CHANGES",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "FUTURE SELLING PRICE", initialValue: "0", prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: _datePicker("EFFECTIVE FROM", p.priceEffectiveFrom, (d) => controller.updateField(priceEffectiveFrom: d))),
          ]),
          const SizedBox(height: 16),
          _toggle("AUTO-APPLY ON EFFECTIVE DATE", true, (v) {}),
        ]),
      ),
    ]);
  }

  Widget _zoneRow(String zone, String storePrice, String mrp) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [Text(zone, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), const Spacer(), Text("STORE: $storePrice", style: const TextStyle(fontSize: 9)), const SizedBox(width: 16), Text("MRP: $mrp", style: const TextStyle(fontSize: 9, color: Colors.grey))]));
  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
