import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailStoreOverridesTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailStoreOverridesTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "🏬 STORE-SPECIFIC ASSORTMENT & OVERRIDES",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _storeRow("HQ-SUPERMARKET-01", true, "₹420.00", "500"),
          const Divider(),
          _storeRow("MINI-METRO-EXP-04", true, "₹435.00", "50"),
          const Divider(),
          _storeRow("HYPER-NORTH-HUB-02", false, "₹0.00", "0"),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "⚙️ GLOBAL DEFAULTS FOR NEW STORES",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          _toggle("AUTO-LIST ON NEW STORES", true, (v) {}),
          const SizedBox(width: 24),
          _toggle("INHERIT PARENT PRICING", true, (v) {}),
        ]),
      ),
    ]);
  }

  Widget _storeRow(String name, bool listed, String price, String stock) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [
    Expanded(child: Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
    Text(listed ? "LISTED" : "NOT LISTED", style: TextStyle(fontSize: 8, color: listed ? Colors.green : Colors.red, fontWeight: FontWeight.w900)),
    const SizedBox(width: 16),
    Text("PRICE: $price", style: const TextStyle(fontSize: 9)),
    const SizedBox(width: 16),
    Text("STOCK: $stock", style: const TextStyle(fontSize: 9, color: Colors.grey)),
    const SizedBox(width: 16),
    const Icon(Icons.edit_note_rounded, size: 14, color: Colors.grey),
  ]));
  
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
