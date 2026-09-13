import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class DairyBoothSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const DairyBoothSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🥛 DAIRY METRICS & CRATE LOGISTICS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "DAIRY TYPE", value: p.bakeryType, items: ["Full Cream", "Toned", "Double Toned", "Skimmed", "Curd", "Paneer"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'bakeryType', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MILK FAT %", initialValue: p.nutritionalTransFats.toString(), onChanged: (v) => controller.updateFieldById(p, 'nutritionalTransFats', v), hint: "e.g., 3.5%")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SNF %", initialValue: p.nutritionalProtein.toString(), onChanged: (v) => controller.updateFieldById(p, 'nutritionalProtein', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _datePicker("PRODUCTION DATE", p.manufacturingDate, (d) => controller.updateFieldById(p, 'manufacturingDate', d))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SHELF LIFE", initialValue: p.freshnessUnit, onChanged: (v) => controller.updateFieldById(p, 'freshnessUnit', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "STORAGE TEMP", value: p.storageCondition, items: ["Chilled 2-4°C", "Frozen", "Ambient"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'storageCondition', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "CRATE MULTIPLIER", initialValue: p.masterCaseRatio.toString(), onChanged: (v) => controller.updateFieldById(p, 'masterCaseRatio', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CRATE DEPOSIT FEE", initialValue: p.containerDepositFee.toString(), onChanged: (v) => controller.updateFieldById(p, 'containerDepositFee', v), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            _toggle("COLD CHAIN REQUIRED", p.coldChainRequired, (v) => controller.updateFieldById(p, 'coldChainRequired', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
