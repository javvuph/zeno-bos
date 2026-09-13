import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../healthcare_schemas.dart';

class ClinicalSaltSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ClinicalSaltSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "💊 CLINICAL SALT & MOLECULE",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "ACTIVE SALT / MOLECULE *", initialValue: p.genericSalt, onChanged: (v) => controller.updateField(genericSalt: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "STRENGTH (e.g. 500mg)", initialValue: p.potency, onChanged: (v) => controller.updateField(potency: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoDropdown<String>(label: "DOSAGE FORM", value: p.dosageForm.isEmpty ? null : p.dosageForm, items: dosageForms.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(dosageForm: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "ROUTE", value: p.serviceProcedureType.isEmpty ? null : p.serviceProcedureType, items: routesOfAdmin.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(serviceProcedureType: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "THERAPEUTIC CATEGORY", initialValue: p.therapeuticCategory, onChanged: (v) => controller.updateField(therapeuticCategory: v), hint: "e.g. Antibiotic, Analgesic")),
            const SizedBox(width: 12),
            _toggle("RX MANDATORY", p.prescriptionClass == "Rx Mandatory", (v) => controller.updateField(prescriptionClass: v ? "Rx Mandatory" : "OTC")),
            const Spacer(),
          ]),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
