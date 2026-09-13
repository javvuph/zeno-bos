import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../../../../controllers/registries/retail_schemas.dart';

class RetailTaxSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailTaxSection({super.key, required this.controller, required this.colors});

  bool get isIndia => controller.currentCountryCode == "IN";
  bool get isArab => ["AE", "SA", "OM", "QA", "BH", "KW"].contains(controller.currentCountryCode);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "🏛️ Regional Statutory Tax Engine",
        titleColor: Colors.blue,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          if (isIndia) _buildIndiaTaxGrid(),
          if (isArab) _buildGCCTaxGrid(),
          if (!isIndia && !isArab) _buildStandardTaxGrid(),
        ]),
      ),
    ]);
  }

  Widget _buildIndiaTaxGrid() {
    return Column(children: [
      Row(children: [
        Expanded(child: ZenoTextField(label: "HSN / SAC CODE *", initialValue: controller.product.taxCode, onChanged: (v) => controller.updateField(taxCode: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoDropdown<String>(label: "GST TAX RATE (%) *", value: controller.product.taxCategory, items: gstRates.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(), onChanged: (v) => controller.updateField(taxCategory: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "COMPENSATION CESS %", initialValue: controller.product.compensationCess.toString(), onChanged: (v) => controller.updateField(compensationCess: double.tryParse(v)))),
      ]),
      const SizedBox(height: 16),
      _segmented("GST ROUTING", controller.product.gstTaxMode, ["Intra-State", "Inter-State"], (v) => controller.updateField(gstTaxMode: v)),
    ]);
  }

  Widget _buildGCCTaxGrid() {
    return Row(children: [
      Expanded(child: ZenoDropdown<String>(label: "VAT CATEGORY *", value: controller.product.vatCategory, items: vatCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => controller.updateField(vatCategory: v))),
      const SizedBox(width: 12),
      Expanded(child: ZenoDropdown<String>(label: "SELECTIVE EXCISE TAX", value: controller.product.selectiveExciseTax, items: selectiveExciseTaxes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => controller.updateField(selectiveExciseTax: v))),
      const SizedBox(width: 12),
      Expanded(child: ZenoTextField(label: "ZATCA / FTA CATEGORY CODE", initialValue: controller.product.zatcaCode, onChanged: (v) => controller.updateField(zatcaCode: v))),
    ]);
  }

  Widget _buildStandardTaxGrid() {
    return Row(children: [
      Expanded(child: ZenoTextField(label: "TAX CODE", initialValue: controller.product.taxCode, onChanged: (v) => controller.updateField(taxCode: v))),
      const SizedBox(width: 12),
      Expanded(child: ZenoTextField(label: "TAX RATE (%)", initialValue: controller.product.taxRate.toString(), onChanged: (v) => controller.updateField(taxRate: double.tryParse(v)))),
    ]);
  }

  Widget _segmented(String l, String v, List<String> i, ValueChanged<String?> o) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), const SizedBox(height: 8), Wrap(spacing: 4, children: i.map((item) => InkWell(onTap: () => o(item), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: v == item ? colors.accentPrimary.withValues(alpha: 0.1) : colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: v == item ? colors.accentPrimary : colors.borderSubtle)), child: Text(item, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: v == item ? colors.accentPrimary : colors.textPrimary))))).toList())]);
}
