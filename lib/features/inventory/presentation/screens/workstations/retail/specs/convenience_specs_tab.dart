import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class ConvenienceSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ConvenienceSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🥪 GRAB & GO / READY-TO-EAT",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            if (controller.isFieldVisible('cafeCategory'))
            Expanded(child: ZenoDropdown<String>(label: "FOOD SERVICE TYPE", value: p.cafeCategory, items: ["Fresh Sandwich", "Bakery", "Hot Dispenser", "Beverage"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'cafeCategory', v))),
            if (controller.isFieldVisible('planogramId'))
            const SizedBox(width: 12),
            if (controller.isFieldVisible('planogramId'))
            Expanded(child: ZenoTextField(label: "SHELF LOCATION", initialValue: p.planogramId, onChanged: (v) => controller.updateFieldById(p, 'planogramId', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('reorderLevel'))
            Expanded(child: ZenoTextField(label: "REORDER POINT", initialValue: p.reorderLevel.toString(), onChanged: (v) => controller.updateFieldById(p, 'reorderLevel', v))),
            if (controller.isFieldVisible('ageRestriction'))
            const SizedBox(width: 12),
            if (controller.isFieldVisible('ageRestriction'))
            Expanded(child: ZenoDropdown<String>(label: "AGE RESTRICTION", value: p.ageRestriction?.toString() ?? "None", items: ["None", "18", "21"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'ageRestriction', v))),
          ]),
          const SizedBox(height: 16),
          Wrap(spacing: 24, runSpacing: 16, children: [
            if (controller.isFieldVisible('readyToEatItem'))
            _toggle("READY TO EAT", p.readyToEatItem, (v) => controller.updateFieldById(p, 'readyToEatItem', v)),
            if (controller.isFieldVisible('isQuickPOSSale'))
            _toggle("FAST POS QUICK-SALE", p.isQuickPOSSale, (v) => controller.updateFieldById(p, 'isQuickPOSSale', v)),
            if (controller.isFieldVisible('isRoomServiceAvailable'))
            _toggle("DELIVERY AVAILABLE", p.isRoomServiceAvailable, (v) => controller.updateFieldById(p, 'isRoomServiceAvailable', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
