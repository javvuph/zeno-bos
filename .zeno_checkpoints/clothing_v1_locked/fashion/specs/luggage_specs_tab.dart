import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class LuggageSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const LuggageSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "BAG & STORAGE SPECIFICATIONS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "BAG / STORAGE TYPE", value: p.apparelCategory.isEmpty ? null : p.apparelCategory, items: ["Backpack", "Trolley Suitcase", "Duffel", "Tote", "Handbag", "Wallet"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(apparelCategory: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "OUTER MATERIAL", value: p.material.isEmpty ? null : p.material, items: ["Polycarbonate", "Hard ABS", "Genuine Leather", "Ballistic Nylon", "Canvas"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(material: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "CAPACITY (LITERS)", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "SECURITY & FEATURES",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "TSA LOCK TYPE", value: p.widthFit.isEmpty ? null : p.widthFit, items: ["Built-in TSA 3-Digit", "Key Lock", "None"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(widthFit: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "COMPARTMENTS", initialValue: p.gemstoneCount.toString(), onChanged: (v) => controller.updateField(gemstoneCount: int.tryParse(v)))),
          const Spacer(),
        ]),
      ),
    ]);
  }
}
