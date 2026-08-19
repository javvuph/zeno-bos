import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class ButcherySpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ButcherySpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🥩 BUTCHERY & MEAT TRACEABILITY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            if (controller.isFieldVisible('styleCategory'))
            Expanded(child: ZenoTextField(label: "MEAT TYPE", initialValue: p.styleCategory, onChanged: (v) => controller.updateFieldById(p, 'styleCategory', v), hint: "e.g. Lamb, Beef, Poultry")),
            if (controller.isFieldVisible('fitType'))
            const SizedBox(width: 12),
            if (controller.isFieldVisible('fitType'))
            Expanded(child: ZenoDropdown<String>(label: "CUT TYPE", value: p.fitType.isEmpty ? null : p.fitType, items: ["Boneless", "Bone-In", "Mince", "Ribs", "Whole"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'fitType', v))),
            if (controller.isFieldVisible('hallmarkCert'))
            const SizedBox(width: 12),
            if (controller.isFieldVisible('hallmarkCert'))
            Expanded(child: ZenoTextField(label: "SLAUGHTER / HALAL CERT", initialValue: p.hallmarkCert, onChanged: (v) => controller.updateFieldById(p, 'hallmarkCert', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('storageCondition'))
            Expanded(child: ZenoDropdown<String>(label: "STORAGE TEMP", value: p.storageCondition, items: ["Chilled 0-4°C", "Frozen -18°C", "Ambient"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'storageCondition', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('countryOfOrigin'))
            Expanded(child: ZenoTextField(label: "MEAT ORIGIN / FARM", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('manufacturingDate'))
            Expanded(child: _datePicker("SLAUGHTER DATE", p.manufacturingDate, (d) => controller.updateFieldById(p, 'manufacturingDate', d))),
            if (controller.isFieldVisible('compatibility'))
            const SizedBox(width: 12),
            if (controller.isFieldVisible('compatibility'))
            Expanded(child: ZenoTextField(label: "CUTTING REFERENCE", initialValue: p.compatibility, onChanged: (v) => controller.updateFieldById(p, 'compatibility', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('weight'))
            Expanded(child: ZenoTextField(label: "WEIGHT (G/KG)", initialValue: p.weight.toString(), onChanged: (v) => controller.updateFieldById(p, 'weight', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('wastagePct'))
            Expanded(child: ZenoTextField(label: "WASTE / YIELD %", initialValue: p.wastagePct.toString(), onChanged: (v) => controller.updateFieldById(p, 'wastagePct', v))),
            const SizedBox(width: 12),
            if (controller.isFieldVisible('freshnessDuration'))
            Expanded(child: ZenoTextField(label: "SHELF LIFE (DAYS)", initialValue: p.freshnessDuration.toString(), onChanged: (v) => controller.updateFieldById(p, 'freshnessDuration', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            if (controller.isFieldVisible('isCatchWeight'))
            _toggle("MANDATORY CATCH WEIGHT", p.isCatchWeight, (v) => controller.updateFieldById(p, 'isCatchWeight', v)),
            const SizedBox(width: 24),
            if (controller.isFieldVisible('inHouseRepack'))
            _toggle("PRE-PACKAGED TRAY", p.inHouseRepack, (v) => controller.updateFieldById(p, 'inHouseRepack', v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
