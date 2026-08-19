import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class FishSeafoodSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FishSeafoodSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🐟 SEAFOOD & COLD CHAIN",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "SPECIES", initialValue: p.patternDesign, onChanged: (v) => controller.updateField(patternDesign: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "SEAFOOD TYPE", value: p.closureType.isEmpty ? null : p.closureType, items: ["Fish", "Shellfish", "Crustacean", "Mollusk"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(closureType: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "GRADE", initialValue: p.styleCategory, onChanged: (v) => controller.updateField(styleCategory: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "ORIGIN / CATCH ZONE", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateField(countryOfOrigin: v))),
            const SizedBox(width: 12),
            Expanded(child: _datePicker("LANDING / CATCH DATE", p.manufacturingDate, (d) => controller.updateField(manufacturingDate: d))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SHELF LIFE (DAYS)", initialValue: p.freshnessDuration.toString(), onChanged: (v) => controller.updateField(freshnessDuration: int.tryParse(v)))),
            if (controller.isFieldVisible('recipePrepNotes'))
            const SizedBox(width: 12),
            if (controller.isFieldVisible('recipePrepNotes'))
            Expanded(child: ZenoTextField(label: "MAX DISPLAY HRS (ICE)", initialValue: p.recipePrepNotes, onChanged: (v) => controller.updateField(recipePrepNotes: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "WEIGHT (G/KG)", initialValue: p.weight.toString(), onChanged: (v) => controller.updateField(weight: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "STORAGE", value: p.storageCondition, items: ["Ice Bed", "Chilled", "Frozen"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(storageCondition: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("CATCH WEIGHT ACTIVE", p.isCatchWeight, (v) => controller.updateField(isCatchWeight: v)),
            const SizedBox(width: 24),
            _toggle("FREE CLEANING SERVICE", p.isExpressPrep, (v) => controller.updateField(isExpressPrep: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
