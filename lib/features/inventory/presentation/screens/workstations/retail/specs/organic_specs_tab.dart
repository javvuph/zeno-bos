import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class OrganicSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const OrganicSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌿 ORGANIC CERTIFICATION & TRACEABILITY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "ORGANIC STANDARD", value: p.organicCertification.isEmpty ? null : p.organicCertification, items: ["USDA Organic", "India Organic", "EU Bio", "Jaivik Bharat"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'organicCertification', v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "LICENSE NO *", initialValue: p.organicCertNo, onChanged: (v) => controller.updateFieldById(p, 'organicCertNo', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _datePicker("CERTIFICATION EXPIRY", p.discontinueDate, (d) => controller.updateFieldById(p, 'discontinueDate', d))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "FARM / ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateFieldById(p, 'countryOfOrigin', v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "TRACEABILITY ID", initialValue: p.farmTraceabilityId, onChanged: (v) => controller.updateFieldById(p, 'farmTraceabilityId', v))),
            const SizedBox(width: 12),
            Expanded(child: _datePicker("HARVEST DATE", p.harvestDate, (d) => controller.updateFieldById(p, 'harvestDate', d))),
          ]),
          const SizedBox(height: 16),
          _toggle("ORGANIC CERTIFIED", p.organicCertified, (v) => controller.updateFieldById(p, 'organicCertified', v)),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
