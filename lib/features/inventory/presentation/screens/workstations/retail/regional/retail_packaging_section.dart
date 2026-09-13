import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';

class RetailPackagingSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailPackagingSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return SingleChildScrollView(
      child: Column(children: [
        ZenoCard(
          title: "📦 Packaging Unit Hierarchy & Repacking",
          titleColor: colors.accentPrimary,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: ZenoDropdown<String>(label: "BASE UNIT (UOM)", value: p.unit, items: ["Piece", "Kg", "Gram", "Liter", "Pack"].map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(), onChanged: (v) => controller.updateField(unit: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoDropdown<String>(label: "STOCKING UNIT", value: p.stockUnit, items: ["Outer Carton", "Master Case", "Pallet"].map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(), onChanged: (v) => controller.updateField(stockUnit: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "CONVERSION", initialValue: p.conversionFactor.toString(), onChanged: (v) => controller.updateField(conversionFactor: double.tryParse(v)), hint: "e.g., 24")),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "UNITS PER PACK", initialValue: p.unitsPerPackage.toString(), onChanged: (v) => controller.updateField(unitsPerPackage: int.tryParse(v)))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoTextField(label: "OUTER CARTON BARCODE (ITF-14)", initialValue: p.masterOuterBarcode, onChanged: (v) => controller.updateField(masterOuterBarcode: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "GROSS WEIGHT", initialValue: p.grossWeight.toString(), onChanged: (v) => controller.updateField(grossWeight: double.tryParse(v)), suffix: const Text("KG"))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "SHELF DIMENSIONS", initialValue: p.unitDimensions, onChanged: (v) => controller.updateField(unitDimensions: v), hint: "LxWxH cm")),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "CARTON MULTIPLIER", initialValue: p.caseMultiplier.toString(), onChanged: (v) => controller.updateField(caseMultiplier: int.tryParse(v)))),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        ZenoCard(
          title: "⚖️ Weight & Logistics Settings",
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: _toggle("CATCH WEIGHT", p.isCatchWeight, (v) => controller.updateField(isCatchWeight: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "SCALE PRECISION", initialValue: p.scaleWeightPrecision.toString(), onChanged: (v) => controller.updateField(scaleWeightPrecision: int.tryParse(v)), hint: "Decimals")),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "TARE WEIGHT", initialValue: p.tareWeightDeduction.toString(), onChanged: (v) => controller.updateField(tareWeightDeduction: double.tryParse(v)), suffix: const Text("G"))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "PRICE COMP. BASE", initialValue: p.unitPriceComparisonBase, onChanged: (v) => controller.updateField(unitPriceComparisonBase: v), hint: "e.g., 100g")),
            ]),
            const SizedBox(height: 16),
            Wrap(spacing: 24, runSpacing: 16, children: [
              _toggle("EAS HARD TAG", p.isEasTagRequired, (v) => controller.updateField(isEasTagRequired: v)),
              _toggle("ALLOW LOOSE", p.allowLooseBilling, (v) => controller.updateField(allowLooseBilling: v)),
              _toggle("IN-HOUSE REPACK", p.inHouseRepack, (v) => controller.updateField(inHouseRepack: v)),
              _toggle("AUTO LANDED COST", p.autoComputeLandedCost, (v) => controller.updateField(autoComputeLandedCost: v)),
              _toggle("VMI ENABLED", p.isVmiEnabled, (v) => controller.updateField(isVmiEnabled: v)),
              _toggle("CROSS-DOCKING", p.isCrossDockingAllowed, (v) => controller.updateField(isCrossDockingAllowed: v)),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        _buildDynamicExtensions(p.businessCategory),
      ]),
    );
  }

  Widget _buildDynamicExtensions(String cat) {
    if (cat == "Organic Store") return _buildOrganic();
    if (cat == "Liquor Store" || cat == "Tobacco Shop") return _buildLiquorTobacco(cat);
    if (cat == "Duty Free Shop") return _buildDutyFree();
    return const SizedBox.shrink();
  }

  Widget _buildOrganic() => ZenoCard(title: "Organic Certification", child: Row(children: [Expanded(child: ZenoTextField(label: "CERT NO", initialValue: controller.product.organicCertNo, onChanged: (v) => controller.updateField(organicCertNo: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: "FARM TRACE ID", initialValue: controller.product.farmTraceabilityId, onChanged: (v) => controller.updateField(farmTraceabilityId: v)))]));
  Widget _buildLiquorTobacco(String cat) => ZenoCard(title: "$cat Regulatory", child: Row(children: [if (cat == "Liquor Store") ...[Expanded(child: ZenoTextField(label: "ABV %", initialValue: controller.product.abv.toString(), onChanged: (v) => controller.updateField(abv: double.tryParse(v)))), const SizedBox(width: 12)], Expanded(child: ZenoDropdown<String>(label: "VOLUME", value: controller.product.volume, items: ["180ml", "375ml", "750ml", "1L"].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => controller.updateField(volume: v))), const SizedBox(width: 12), _toggle("AGE GATE", controller.product.ageGate, (v) => controller.updateField(ageGate: v))]));
  Widget _buildDutyFree() => ZenoCard(title: "Duty Free Logistics", child: Row(children: [Expanded(child: _toggle("PASSPORT REQ", controller.product.passportVerificationRequired, (v) => controller.updateField(passportVerificationRequired: v))), const SizedBox(width: 12), Expanded(child: _toggle("FLIGHT NO REQ", controller.product.flightNumberRequired, (v) => controller.updateField(flightNumberRequired: v)))]));

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
