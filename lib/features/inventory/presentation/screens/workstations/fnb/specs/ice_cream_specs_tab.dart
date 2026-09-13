import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class IceCreamSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const IceCreamSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍦 ICE CREAM & DESSERT",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "BASE", value: p.cakeFilling.isEmpty ? null : p.cakeFilling, items: iceCreamBases.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(cakeFilling: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SERVING TYPE", initialValue: p.portionSize, onChanged: (v) => controller.updateField(portionSize: v), hint: "Scoop, Sundae, etc.")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CONE / CUP OPTION", initialValue: p.cakeShape, onChanged: (v) => controller.updateField(cakeShape: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("DELIVERY ICE PACK REQ", p.isLiveMarketPrice, (v) => controller.updateField(isLiveMarketPrice: v)),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
