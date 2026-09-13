import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class HypermarketSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const HypermarketSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📍 PLANOGRAM & CAPACITY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            if (controller.isFieldVisible('floorZone'))
            Expanded(child: ZenoTextField(label: "FLOOR / ZONE", initialValue: p.floorZone, onChanged: (v) => controller.updateFieldById(p, 'floorZone', v))),
            if (controller.isFieldVisible('floorZone')) const SizedBox(width: 12),
            if (controller.isFieldVisible('storageClass'))
            Expanded(child: ZenoTextField(label: "STORAGE CLASS", initialValue: p.storageClass, onChanged: (v) => controller.updateFieldById(p, 'storageClass', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('planogramAisle'))
            Expanded(child: ZenoTextField(label: "AISLE", initialValue: p.planogramAisle, onChanged: (v) => controller.updateFieldById(p, 'planogramAisle', v))),
            const SizedBox(width: 8),
            if (controller.isFieldVisible('planogramBay'))
            Expanded(child: ZenoTextField(label: "BAY", initialValue: p.planogramBay, onChanged: (v) => controller.updateFieldById(p, 'planogramBay', v))),
            const SizedBox(width: 8),
            if (controller.isFieldVisible('planogramRack'))
            Expanded(child: ZenoTextField(label: "RACK", initialValue: p.planogramRack, onChanged: (v) => controller.updateFieldById(p, 'planogramRack', v))),
            const SizedBox(width: 8),
            if (controller.isFieldVisible('planogramShelf'))
            Expanded(child: ZenoTextField(label: "SHELF", initialValue: p.planogramShelf, onChanged: (v) => controller.updateFieldById(p, 'planogramShelf', v))),
            const SizedBox(width: 8),
            if (controller.isFieldVisible('planogramBin'))
            Expanded(child: ZenoTextField(label: "BIN", initialValue: p.planogramBin, onChanged: (v) => controller.updateFieldById(p, 'planogramBin', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('minDisplayQty'))
            Expanded(child: ZenoTextField(label: "MIN DISPLAY QTY", initialValue: p.minDisplayQty.toString(), onChanged: (v) => controller.updateFieldById(p, 'minDisplayQty', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('maxDisplayQty'))
            Expanded(child: ZenoTextField(label: "MAX DISPLAY QTY", initialValue: p.maxDisplayQty.toString(), onChanged: (v) => controller.updateFieldById(p, 'maxDisplayQty', v))),
          ]),
          if (controller.isFieldVisible('fastMovingFlag') || controller.isFieldVisible('staffCommissionRate')) ...[
            const SizedBox(height: 16),
            Row(children: [
              if (controller.isFieldVisible('fastMovingFlag'))
              _toggle("FAST MOVING ITEM (A-RANK)", p.fastMovingFlag, (v) => controller.updateFieldById(p, 'fastMovingFlag', v)),
              if (controller.isFieldVisible('fastMovingFlag') && controller.isFieldVisible('staffCommissionRate')) const SizedBox(width: 24),
              if (controller.isFieldVisible('staffCommissionRate'))
              Expanded(child: ZenoTextField(label: "STAFF COMMISSION RATE (%)", initialValue: p.staffCommissionRate.toString(), onChanged: (v) => controller.updateFieldById(p, 'staffCommissionRate', v))),
            ]),
          ],
        ]),
      ),
      if (controller.isFieldVisible('masterOuterBarcode'))
      const SizedBox(height: 12),
      if (controller.isFieldVisible('masterOuterBarcode'))
      ZenoCard(
        title: "📦 LOGISTICS & PALLET",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            if (controller.isFieldVisible('masterOuterBarcode'))
            Expanded(child: ZenoTextField(label: "OUTER BARCODE", initialValue: p.masterOuterBarcode, onChanged: (v) => controller.updateFieldById(p, 'masterOuterBarcode', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('palletStacking'))
            Expanded(child: ZenoTextField(label: "PALLET MULTIPLIER", initialValue: p.palletStacking.toString(), onChanged: (v) => controller.updateFieldById(p, 'palletStacking', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('grossWeight'))
            Expanded(child: ZenoTextField(label: "GROSS WEIGHT (KG)", initialValue: p.grossWeight.toString(), onChanged: (v) => controller.updateFieldById(p, 'grossWeight', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('unitDimensions'))
            Expanded(child: ZenoTextField(label: "DIMENSIONS", initialValue: p.unitDimensions, onChanged: (v) => controller.updateFieldById(p, 'unitDimensions', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("CROSS-DOCKING", p.isCrossDockingAllowed, (v) => controller.updateFieldById(p, 'isCrossDockingAllowed', v)),
            const SizedBox(width: 24),
            _toggle("VENDOR MANAGED (VMI)", p.isVmiEnabled, (v) => controller.updateFieldById(p, 'isVmiEnabled', v)),
            const SizedBox(width: 24),
            _toggle("AUTO-COMPUTE LANDED", p.autoComputeLandedCost, (v) => controller.updateFieldById(p, 'autoComputeLandedCost', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
