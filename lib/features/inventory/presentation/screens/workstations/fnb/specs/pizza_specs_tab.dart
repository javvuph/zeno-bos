import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class PizzaSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const PizzaSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍕 PIZZA CONFIGURATION",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "BASE SIZE", value: p.cakeSize.isEmpty ? null : p.cakeSize, items: pizzaSizes.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(cakeSize: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "CRUST TYPE", value: p.cakeShape.isEmpty ? null : p.cakeShape, items: pizzaCrusts.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(cakeShape: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SAUCE TYPE", initialValue: p.cakeFilling, onChanged: (v) => controller.updateField(cakeFilling: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CHEESE DIP", initialValue: p.virtualBrand, onChanged: (v) => controller.updateField(virtualBrand: v))),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "SEASONING & ADD-ONS", initialValue: p.shortDescription, onChanged: (v) => controller.updateField(shortDescription: v)),
        ]),
      ),
    ]);
  }
}
