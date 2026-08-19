import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailTraceabilityTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailTraceabilityTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🚜 ORIGIN & TRACEABILITY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "FARM / ORIGIN NAME", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateField(countryOfOrigin: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "FARM TRACEABILITY ID", initialValue: p.farmTraceabilityId, onChanged: (v) => controller.updateField(farmTraceabilityId: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _datePicker("HARVEST / PRODUCTION DATE", p.harvestDate, (d) => controller.updateField(harvestDate: d))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "CERTIFICATION NO", initialValue: p.organicCertNo, onChanged: (v) => controller.updateField(organicCertNo: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _toggle("ORGANIC CERTIFIED", p.organicCertified, (v) => controller.updateField(organicCertified: v)),
            const SizedBox(width: 24),
            _toggle("NON-GMO VERIFIED", p.organicCertified, (v) => controller.updateField(organicCertified: v)),
          ]),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
