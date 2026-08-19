import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailWmsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailWmsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🏬 WAREHOUSE & DC STRUCTURE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "DISTRIBUTION CENTER", value: p.warehouseLocation, items: ["DC-NORTH", "DC-SOUTH", "DC-MAIN"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(warehouseLocation: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "STORAGE ZONE", initialValue: p.floorZone, onChanged: (v) => controller.updateField(floorZone: v), hint: "e.g. Ambient, Cold, High-Value")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "AISLE", initialValue: p.planogramAisle, onChanged: (v) => controller.updateField(planogramAisle: v))),
            const SizedBox(width: 8),
            Expanded(child: ZenoTextField(label: "BAY", initialValue: p.planogramBay, onChanged: (v) => controller.updateField(planogramBay: v))),
            const SizedBox(width: 8),
            Expanded(child: ZenoTextField(label: "RACK", initialValue: p.planogramRack, onChanged: (v) => controller.updateField(planogramRack: v))),
            const SizedBox(width: 8),
            Expanded(child: ZenoTextField(label: "SHELF", initialValue: p.planogramShelf, onChanged: (v) => controller.updateField(planogramShelf: v))),
            const SizedBox(width: 8),
            Expanded(child: ZenoTextField(label: "BIN / POSITION", initialValue: p.planogramBin, onChanged: (v) => controller.updateField(planogramBin: v))),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📦 RECEIVING & QC LOGISTICS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "QC PROTOCOL", value: p.complianceId, items: ["Standard", "Blind Count", "Detailed Inspection"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(complianceId: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PUTAWAY STRATEGY", initialValue: p.storageClass, onChanged: (v) => controller.updateField(storageClass: v), hint: "Fastest-Moving, Heavy-Items")),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("CROSS-DOCKING ELIGIBLE", p.isCrossDockingAllowed, (v) => controller.updateField(isCrossDockingAllowed: v)),
            const SizedBox(width: 24),
            _toggle("VENDOR MANAGED (VMI)", p.isVmiEnabled, (v) => controller.updateField(isVmiEnabled: v)),
            const SizedBox(width: 24),
            _toggle("MANDATORY QC ON RECEIPT", p.mtcRequired, (v) => controller.updateField(mtcRequired: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
