import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../../../../controllers/registries/retail_schemas.dart';

class RetailBasicSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailBasicSection({super.key, required this.controller, required this.colors});

  bool get isArab => ["AE", "SA", "OM", "QA", "BH", "KW"].contains(controller.currentCountryCode);

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return SingleChildScrollView(
      child: Column(children: [
        ZenoCard(
          title: "🛒 Hypermarket Identity & Localization",
          titleColor: colors.accentPrimary,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: ZenoTextField(label: "PRIMARY PRODUCT NAME *", initialValue: p.title, onChanged: (v) => controller.updateField(title: v))),
              const SizedBox(width: 16),
              if (isArab) Expanded(child: ZenoTextField(label: "اسم المنتج (ARABIC NAME) *", textAlign: TextAlign.right, initialValue: p.arabicTitle, onChanged: (v) => controller.updateField(arabicTitle: v)))
              else Expanded(child: ZenoTextField(label: "POS SHORT THERMAL NAME", initialValue: p.posShortThermalName, onChanged: (v) => controller.updateField(posShortThermalName: v), hint: "Max 22 chars")),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoTextField(label: "PRIMARY GTIN BARCODE *", initialValue: p.barcode, onChanged: (v) => controller.updateField(barcode: v), suffix: const Icon(Icons.qr_code_scanner_rounded, size: 16))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "MULTI-BARCODE / IMPORT", initialValue: p.multiBarcodes.join(", "), onChanged: (v) => controller.updateField(multiBarcodes: v.split(",").map((e)=>e.trim()).toList()))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "MASTER SKU *", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: _segmented("BARCODE TYPE", p.barcodeType, barcodeTypes, (v) => controller.updateField(barcodeType: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "PLU SCALE CODE", initialValue: p.pluCode, onChanged: (v) => controller.updateField(pluCode: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "ESL TAG ID", initialValue: p.eslId, onChanged: (v) => controller.updateField(eslId: v))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoDropdown<String>(label: "BRAND TYPE", value: p.brandType, items: ["National", "International", "Private Label"].map((t)=>DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => controller.updateField(brandType: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "PRINCIPAL BRAND", initialValue: p.brand, onChanged: (v) => controller.updateField(brand: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoDropdown<String>(label: "CLASSIFICATION", value: p.productClassification, items: ["Food", "Non-Food"].map((c)=>DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => controller.updateField(productClassification: v))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoDropdown<String>(label: "DEPARTMENT", value: p.category, items: retailDepartments.map((d)=>DropdownMenuItem(value: d, child: Text(d))).toList(), onChanged: (v) => controller.updateField(category: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "SUB-DEPARTMENT", initialValue: p.subDepartment, onChanged: (v) => controller.updateField(subDepartment: v))),
              const SizedBox(width: 12),
              Expanded(child: _segmented("RETURN POLICY", p.returnPolicy, returnPolicies, (v) => controller.updateField(returnPolicy: v))),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        ZenoCard(
          title: "📍 Planogram & Shelf Placement",
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: ZenoTextField(label: "AISLE", initialValue: p.planogramAisle, onChanged: (v) => controller.updateField(planogramAisle: v))),
              const SizedBox(width: 8),
              Expanded(child: ZenoTextField(label: "BAY", initialValue: p.planogramBay, onChanged: (v) => controller.updateField(planogramBay: v))),
              const SizedBox(width: 8),
              Expanded(child: ZenoTextField(label: "RACK", initialValue: p.planogramRack, onChanged: (v) => controller.updateField(planogramRack: v))),
              const SizedBox(width: 8),
              Expanded(child: ZenoTextField(label: "SHELF", initialValue: p.planogramShelf, onChanged: (v) => controller.updateField(planogramShelf: v))),
              const SizedBox(width: 8),
              Expanded(child: ZenoTextField(label: "BIN", initialValue: p.planogramBin, onChanged: (v) => controller.updateField(planogramBin: v))),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: ZenoTextField(label: "MIN DISPLAY QTY", initialValue: p.minDisplayQty.toString(), onChanged: (v) => controller.updateField(minDisplayQty: int.tryParse(v)))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "MAX DISPLAY QTY", initialValue: p.maxDisplayQty.toString(), onChanged: (v) => controller.updateField(maxDisplayQty: int.tryParse(v)))),
              const SizedBox(width: 12),
              Expanded(child: _toggle("QUICK POS SALE", p.isQuickPOSSale, (v) => controller.updateField(isQuickPOSSale: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoDropdown<String>(label: "LIFECYCLE", value: p.productLifecycleStatus, items: ["Active", "Phase-Out", "Discontinued"].map((s)=>DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => controller.updateField(productLifecycleStatus: v))),
            ]),
          ]),
        ),
      ]),
    );
  }

  Widget _segmented(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)),
      const SizedBox(height: 8),
      Wrap(spacing: 4, runSpacing: 4, children: items.map((i) {
        final isSelected = value == i;
        return InkWell(onTap: () => onChanged(i), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: isSelected ? colors.accentPrimary.withValues(alpha: 0.1) : colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle)), child: Text(i, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: isSelected ? colors.accentPrimary : colors.textPrimary))));
      }).toList()),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
