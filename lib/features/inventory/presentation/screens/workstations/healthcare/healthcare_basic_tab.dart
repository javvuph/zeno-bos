import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import 'healthcare_schemas.dart';
import '../../widgets/product_studio_redesign_widgets.dart';

class HealthcareBasicTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const HealthcareBasicTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      StudioSectionCard(
        title: "Product Identity",
        subtitle: "Clinical brand name and molecule identification",
        icon: Icons.medical_services_outlined,
        child: Column(children: [
          Wrap(spacing: 20, runSpacing: 20, children: [
            ZenoTextField(key: const ValueKey('title'), label: "Commercial Name", initialValue: p.title, onChanged: (v) => controller.updateField(title: v), width: ZenoFieldWidth.standard, isRequired: true),
            ZenoTextField(key: const ValueKey('genericSalt'), label: "Generic Name / Molecule", initialValue: p.genericSalt, onChanged: (v) => controller.updateField(genericSalt: v), width: ZenoFieldWidth.standard, isRequired: true),
          ]),
          const SizedBox(height: 20),
          Wrap(spacing: 20, runSpacing: 20, children: [
            ZenoTextField(key: const ValueKey('brand'), label: "Principal Brand", initialValue: p.brand, onChanged: (v) => controller.updateField(brand: v), width: ZenoFieldWidth.medium),
            ZenoTextField(key: const ValueKey('potency'), label: "Strength / Potency", initialValue: p.potency, onChanged: (v) => controller.updateField(potency: v), width: ZenoFieldWidth.short, hint: "500mg"),
            ZenoDropdown<String>(key: const ValueKey('dosageForm'), label: "Dosage Form", value: p.dosageForm.isEmpty ? null : p.dosageForm, items: dosageForms.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(dosageForm: v), width: ZenoFieldWidth.medium),
          ]),
        ]),
      ),
      StudioSectionCard(
        title: "Regulatory & Classification",
        subtitle: "Prescription controls and statutory details",
        icon: Icons.gavel_outlined,
        accentColor: colors.statusDanger,
        child: Column(children: [
          Wrap(spacing: 20, runSpacing: 20, children: [
            ZenoTextField(key: const ValueKey('sku'), label: "Master SKU", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v), width: ZenoFieldWidth.medium),
            ZenoTextField(key: const ValueKey('barcode'), label: "Primary Barcode", initialValue: p.barcode, onChanged: (v) => controller.updateField(barcode: v), width: ZenoFieldWidth.medium),
            ZenoTextField(key: const ValueKey('healthLicense'), label: "Drug License No", initialValue: p.healthLicense, onChanged: (v) => controller.updateField(healthLicense: v), width: ZenoFieldWidth.medium),
          ]),
          const SizedBox(height: 20),
          Row(children: [
            _toggle("RX MANDATORY", p.prescriptionClass == "Rx Mandatory", (v) => controller.updateField(prescriptionClass: v ? "Rx Mandatory" : "OTC")),
            const SizedBox(width: 24),
            _toggle("COLD CHAIN ITEM", p.coldChainRequired, (v) => controller.updateField(coldChainRequired: v)),
            const Spacer(),
          ]),
        ]),
      ),
      StudioSectionCard(
        title: "Packaging & Units",
        subtitle: "Dispensing ratios and sale units",
        icon: Icons.inventory_2_outlined,
        accentColor: colors.statusInfo,
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          ZenoDropdown<String>(key: const ValueKey('unit'), label: "Sale Unit", value: p.unit, items: ["Tablet", "Capsule", "Strip", "Bottle", "Vial", "Pcs"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(unit: v), width: ZenoFieldWidth.medium),
          ZenoTextField(key: const ValueKey('unitsPerStrip'), label: "Units per Strip", initialValue: p.unitsPerStrip.toString(), onChanged: (v) => controller.updateField(unitsPerStrip: int.tryParse(v)), width: ZenoFieldWidth.micro),
          ZenoTextField(key: const ValueKey('stripsPerBox'), label: "Strips per Box", initialValue: p.stripsPerBox.toString(), onChanged: (v) => controller.updateField(stripsPerBox: int.tryParse(v)), width: ZenoFieldWidth.micro),
          _toggle("ALLOW LOOSE DISPENSING", p.allowLooseBilling, (v) => controller.updateField(allowLooseBilling: v)),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.5)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
