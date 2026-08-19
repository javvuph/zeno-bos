import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class CloudKitchenSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const CloudKitchenSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🚀 AGGREGATOR & CLOUD CONFIG",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "SWIGGY SKU ID", initialValue: p.swiggySku, onChanged: (v) => controller.updateField(swiggySku: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ZOMATO SKU ID", initialValue: p.zomatoSku, onChanged: (v) => controller.updateField(zomatoSku: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "CONTAINER TYPE", initialValue: p.containerType, onChanged: (v) => controller.updateField(containerType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "OOS BEHAVIOR", value: p.productLifecycleStatus, items: ["Mark Out of Stock", "Remove from Menu", "Keep Available"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(productLifecycleStatus: v))),
          ]),
          const SizedBox(height: 16),
          Wrap(spacing: 24, children: [
            _toggle("TAMPER-EVIDENT SEAL", p.mtcRequired, (v) => controller.updateField(mtcRequired: v)),
            _toggle("EXPRESS DISPATCH (10 MIN)", p.isExpressPrep, (v) => controller.updateField(isExpressPrep: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
