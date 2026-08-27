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
    return Column(
      children: [
        ZenoCard(
          title: "Packaging & Units",
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: ZenoDropdown<String>(label: "Package Type", value: p.packageType.isEmpty ? null : p.packageType, items: ["Box", "Bottle", "Pouch", "Can"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(packageType: v))),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoDropdown<String>(label: "Sales UOM *", value: p.salesUnit, items: ["Piece", "Kg", "Gram", "Liter"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(salesUnit: v), isRequired: true)),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoDropdown<String>(label: "Purchase UOM *", value: p.purchaseUnit, items: ["Master Carton", "Outer Case", "Pallet"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(purchaseUnit: v), isRequired: true)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(child: ZenoTextField(label: "Pkg Qty", initialValue: p.packageQuantity.toString(), onChanged: (v) => controller.updateField(packageQuantity: double.tryParse(v)), keyboardType: TextInputType.number)),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoDropdown<String>(label: "Base UOM", value: p.unit, items: ["Piece", "Kg", "Gram"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(unit: v))),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoTextField(label: "Conv Factor", initialValue: p.conversionFactor.toString(), onChanged: (v) => controller.updateField(conversionFactor: double.tryParse(v)), keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(child: ZenoTextField(label: "Net Wt (Kg)", initialValue: p.netWeight.toString(), onChanged: (v) => controller.updateField(netWeight: double.tryParse(v)), keyboardType: TextInputType.number)),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoTextField(label: "Volume (L)", initialValue: p.volume, onChanged: (v) => controller.updateField(volume: v))),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoTextField(label: "Inner Qty", initialValue: p.innerPackQuantity.toString(), onChanged: (v) => controller.updateField(innerPackQuantity: int.tryParse(v)), keyboardType: TextInputType.number)),
                  const SizedBox(width: 8),
                  Expanded(child: ZenoTextField(label: "Case Mult", initialValue: p.caseMultiplier.toString(), onChanged: (v) => controller.updateField(caseMultiplier: int.tryParse(v)), keyboardType: TextInputType.number)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ZenoCard(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _toggle("ALLOW LOOSE", p.allowLooseBilling, (v) => controller.updateField(allowLooseBilling: v)),
              const SizedBox(width: 24),
              _toggle("IN-HOUSE REPACK", p.inHouseRepack, (v) => controller.updateField(inHouseRepack: v)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)),
      Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary)),
    ],
  );
}
