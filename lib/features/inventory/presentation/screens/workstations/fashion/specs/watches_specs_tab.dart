import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class WatchesSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const WatchesSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "WATCH MOVEMENT & CASE",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "MOVEMENT TYPE", value: p.material.isEmpty ? null : p.material, items: ["Automatic", "Quartz", "Solar", "Mechanical Hand-Wind", "Smart / Digital"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(material: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "CASE MATERIAL", value: p.closureType.isEmpty ? null : p.closureType, items: ["Stainless Steel", "Titanium", "Ceramic", "Gold Plated", "Resin"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(closureType: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "CASE DIAMETER (MM)", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v), hint: "e.g., 42mm")),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "STRAP & WATER RESISTANCE",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "STRAP MATERIAL", value: p.soleMaterial.isEmpty ? null : p.soleMaterial, items: ["Genuine Leather", "Stainless Steel Mesh", "Silicone", "NATO Nylon"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(soleMaterial: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "WATER RESISTANCE", value: p.widthFit.isEmpty ? null : p.widthFit, items: ["3 ATM (30m)", "5 ATM (50m)", "10 ATM (100m)", "20 ATM Diver"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(widthFit: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "POWER RESERVE (HRS)", initialValue: p.scentNotes, onChanged: (v) => controller.updateField(scentNotes: v))),
        ]),
      ),
    ]);
  }
}
