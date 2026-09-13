import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class BoutiqueSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BoutiqueSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "DESIGNER & COUTURE DETAILS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "DESIGNER / COUTURE BRAND", initialValue: p.artisanLabel, onChanged: (v) => controller.updateField(artisanLabel: v))),
            const SizedBox(width: 12),
            _toggle("CUSTOM MEASUREMENTS REQUIRED", p.madeToOrder, (v) => controller.updateField(madeToOrder: v)),
          ]),
          if (controller.isFieldVisible('rfidTagId')) ...[
            const SizedBox(height: 16),
            ZenoTextField(label: "RFID TAG ID / EPC", initialValue: p.rfidTagId, onChanged: (v) => controller.updateField(rfidTagId: v), suffix: const Icon(Icons.nfc_rounded, size: 16)),
          ],
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "ALTERATION & DELIVERY",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "ALTERATION FEES", initialValue: p.diagnosisCharge.toString(), onChanged: (v) => controller.updateField(diagnosisCharge: double.tryParse(v)), prefix: const Text("₹"))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "GRACE DAYS", initialValue: p.freshnessDuration.toString(), onChanged: (v) => controller.updateField(freshnessDuration: int.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: _datePicker("SCHEDULED TRIAL", p.scheduledTrialDate, (d) => controller.updateField(scheduledTrialDate: d))),
          const SizedBox(width: 12),
          Expanded(child: _datePicker("FINAL DELIVERY", p.promisedDeliveryDate, (d) => controller.updateField(promisedDeliveryDate: d))),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
