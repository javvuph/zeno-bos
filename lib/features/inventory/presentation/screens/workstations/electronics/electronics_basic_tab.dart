import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class ElectronicsBasicTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ElectronicsBasicTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "📱 DEVICE IDENTITY",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "COMMERCIAL PRODUCT NAME *", initialValue: p.title, onChanged: (v) => controller.updateField(title: v))),
            const SizedBox(width: 16),
            Expanded(child: ZenoTextField(label: "OEM MODEL NUMBER / NAME *", initialValue: p.modelNumber, onChanged: (v) => controller.updateField(modelNumber: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "PRINCIPAL BRAND *", initialValue: p.brand, onChanged: (v) => controller.updateField(brand: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MASTER SKU CODE *", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PRIMARY GTIN / BARCODE *", initialValue: p.barcode, onChanged: (v) => controller.updateField(barcode: v), suffix: const Icon(Icons.qr_code_scanner_rounded, size: 16))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "POS SHORT NAME", initialValue: p.posShortThermalName, onChanged: (v) => controller.updateField(posShortThermalName: v), hint: "Max 22 chars")),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "PRODUCT DESCRIPTION & HIGHLIGHTS", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 3),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "🛡️ WARRANTY & CONDITION",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "BRAND WARRANTY (MONTHS)", initialValue: p.warrantyDuration.toString(), onChanged: (v) => controller.updateField(warrantyDuration: int.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "WARRANTY TYPE", value: p.warrantyUnit, items: ["Brand Onsite", "Brand Carry-in", "Seller Warranty", "No Warranty"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(warrantyUnit: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "CONDITION", value: p.status, items: ["Brand New", "Factory Refurbished", "Open Box", "Pre-Owned"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(status: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "COUNTRY OF ORIGIN", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateField(countryOfOrigin: v))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "⚡ POWER & COMPLIANCE",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoTextField(label: "VOLTAGE COMPATIBILITY", initialValue: p.operatingVoltage, onChanged: (v) => controller.updateField(operatingVoltage: v), hint: "e.g. 110-240V")),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "POWER CONSUMPTION", initialValue: p.annualEnergyConsumption.toString(), onChanged: (v) => controller.updateField(annualEnergyConsumption: double.tryParse(v)), hint: "e.g. 65W")),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "CERTIFICATION ID (BIS/CE)", initialValue: p.hallmarkCert, onChanged: (v) => controller.updateField(hallmarkCert: v))),
          const Spacer(),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "⚙️ POLICIES & POS",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "RETURN / DOA WINDOW", value: p.returnPolicy, items: ["No Return", "7 Days DOA", "10 Days Replacement", "30 Days Return"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(returnPolicy: v))),
          const SizedBox(width: 24),
          _toggle("MANDATORY SERIAL SCAN", p.mandatorySerialScan, (v) => controller.updateField(mandatorySerialScan: v)),
          const SizedBox(width: 24),
          _toggle("FAST POS QUICK-SALE", p.isQuickPOSSale, (v) => controller.updateField(isQuickPOSSale: v)),
          const Spacer(),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
