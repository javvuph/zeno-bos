import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailPackagingTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailPackagingTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "PACKAGING UNIT HIERARCHY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "BASE SELLING UNIT (UOM) *", value: p.unit, items: ["Piece", "Kg", "Gram", "Liter", "Meter", "Pouch", "Can"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(unit: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "STOCKING UNIT *", value: p.purchaseUnit, items: ["Master Carton", "Outer Case", "Pallet", "Sack", "Drum"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(purchaseUnit: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CONVERSION FACTOR *", initialValue: p.conversionFactor.toString(), onChanged: (v) => controller.updateField(conversionFactor: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "UNITS PER CONSUMER PACK", initialValue: p.unitsPerStrip.toString(), onChanged: (v) => controller.updateField(unitsPerStrip: int.tryParse(v)))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "OUTER SHIPPER BARCODE (ITF-14)", initialValue: p.masterOuterBarcode, onChanged: (v) => controller.updateField(masterOuterBarcode: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MASTER CARTON MULTIPLIER", initialValue: p.palletStacking.toString(), onChanged: (v) => controller.updateField(palletStacking: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "GROSS WEIGHT (KG)", initialValue: p.grossWeight.toString(), onChanged: (v) => controller.updateField(grossWeight: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SHELF DIMENSIONS (CM)", initialValue: p.unitDimensions, onChanged: (v) => controller.updateField(unitDimensions: v), hint: "LxWxH")),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "LOGISTICS FLAGS STRIP",
        padding: const EdgeInsets.all(16),
        child: Wrap(spacing: 24, runSpacing: 12, children: [
          _toggle("EAS SECURITY HARD TAG", p.isEasTagRequired, (v) => controller.updateField(isEasTagRequired: v)),
          _toggle("ALLOW LOOSE / BROKEN PACK", p.allowLooseBilling, (v) => controller.updateField(allowLooseBilling: v)),
          _toggle("IN-HOUSE BULK REPACK MODE", p.inHouseRepack, (v) => controller.updateField(inHouseRepack: v)),
          _toggle("CONTAINER DEPOSIT (DRS FEE)", p.containerDepositFee > 0, (v) => controller.updateField(containerDepositFee: v ? 0.50 : 0.0)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
