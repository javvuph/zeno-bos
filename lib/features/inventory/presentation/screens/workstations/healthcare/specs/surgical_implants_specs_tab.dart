import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class SurgicalImplantsSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const SurgicalImplantsSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🏗️ SURGICAL IMPLANTS & PROSTHETICS",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "IMPLANT TYPE", initialValue: p.implantType, onChanged: (v) => controller.updateField(implantType: v), hint: "e.g. Stent, Hip Replacement")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MATERIAL", initialValue: p.material, onChanged: (v) => controller.updateField(material: v), hint: "e.g. Titanium, Polymer")),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BIOCOMPATIBILITY GRADE", initialValue: p.biocompatibilityGrade, onChanged: (v) => controller.updateField(biocompatibilityGrade: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _datePicker("STERILIZATION EXPIRY", p.sterilizationExpiry, (d) => controller.updateField(sterilizationExpiry: d))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "UDI CODE (UNIQUE DEVICE ID)", initialValue: p.udiCode, onChanged: (v) => controller.updateField(udiCode: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MANUFACTURER MODEL", initialValue: p.modelNumber, onChanged: (v) => controller.updateField(modelNumber: v))),
          ]),
          const SizedBox(height: 16),
          _toggle("CONSENT REQUIRED", p.consentRequired, (v) => controller.updateField(consentRequired: v)),
        ]),
      ),
    ]);
  }

  Widget _datePicker(String l, DateTime? v, ValueChanged<DateTime?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text(v == null ? "Select Date" : "${v.day}/${v.month}/${v.year}", style: const TextStyle(fontSize: 11)), const Spacer(), const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey)])))]);
  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
