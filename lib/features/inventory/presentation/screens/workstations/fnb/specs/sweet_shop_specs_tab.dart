import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class SweetShopSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const SweetShopSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍬 MITHAI & SWEETS CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "SELLING MODE", value: p.stockUnit, items: ["By Weight (Kg)", "By Piece", "By Box"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(stockUnit: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "FAT BASE", value: p.flavorProfile.isEmpty ? null : p.flavorProfile, items: sweetShopFats.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(flavorProfile: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SHELF LIFE", initialValue: p.bakeryShelfLife, onChanged: (v) => controller.updateField(bakeryShelfLife: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "STORAGE", initialValue: p.temperatureProfile, onChanged: (v) => controller.updateField(temperatureProfile: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BOX TARE (GRAMS)", initialValue: p.tareWeight.toString(), onChanged: (v) => controller.updateField(tareWeight: double.tryParse(v)))),
          ]),
        ]),
      ),
    ]);
  }
}
