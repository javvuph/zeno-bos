import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/wholesale_schemas.dart';

class WholesaleBasicSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const WholesaleBasicSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return SingleChildScrollView(
      child: Column(children: [
        ZenoCard(
          title: "🏢 Trade / Commodity Identity",
          titleColor: colors.accentPrimary,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: ZenoTextField(label: "TRADE PRODUCT NAME *", initialValue: p.title, onChanged: (v) => controller.updateField(title: v))),
              const SizedBox(width: 16),
              Expanded(child: ZenoTextField(label: "B2B TECHNICAL DESCRIPTION *", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 2)),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoTextField(label: "MASTER B2B SKU *", initialValue: p.masterTradeSku, onChanged: (v) => controller.updateField(masterTradeSku: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "HSN / SAC CODE *", initialValue: p.taxCode, onChanged: (v) => controller.updateField(taxCode: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "MOQ *", initialValue: p.supplierMOQ.toString(), onChanged: (v) => controller.updateField(supplierMOQ: int.tryParse(v)))),
              const SizedBox(width: 12),
              Expanded(child: ZenoDropdown<String>(label: "PRIMARY TRADE UNIT", value: p.primaryTradeUnit, items: primaryTradeUnits.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(), onChanged: (v) => controller.updateField(primaryTradeUnit: v))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoTextField(label: "MIN ORDER VALUE (MOV)", initialValue: p.minOrderValue.toString(), onChanged: (v) => controller.updateField(minOrderValue: double.tryParse(v)))),
              const SizedBox(width: 12),
              Expanded(child: ZenoDropdown<String>(label: "CREDIT TERMS", value: p.tradeCreditTerms, items: creditPaymentTerms.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => controller.updateField(tradeCreditTerms: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "BUYER CREDIT LIMIT", initialValue: p.buyerCreditLimit.toString(), onChanged: (v) => controller.updateField(buyerCreditLimit: double.tryParse(v)))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: ZenoTextField(label: "SALES REP / ACCT MGR", initialValue: p.assignedSalesRepresentative, onChanged: (v) => controller.updateField(assignedSalesRepresentative: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "TERRITORY", initialValue: p.territoryAllocation, onChanged: (v) => controller.updateField(territoryAllocation: v))),
              const SizedBox(width: 12),
              Expanded(child: ZenoTextField(label: "CUSTOMS PORT", initialValue: p.customsPortOfEntry, onChanged: (v) => controller.updateField(customsPortOfEntry: v))),
            ]),
          ]),
        ),
        const SizedBox(height: 16),
        _buildWholesaleExtensions(p.businessCategory),
      ]),
    );
  }

  Widget _buildWholesaleExtensions(String cat) {
    if (cat.contains("FMCG") || cat.contains("Food")) return _buildFMCG();
    if (cat.contains("Garment") || cat.contains("Textile")) return _buildApparel();
    if (cat.contains("Industrial") || cat.contains("Building")) return _buildIndustrial();
    if (cat.contains("Medical")) return _buildMedical();
    return const SizedBox.shrink();
  }

  Widget _buildFMCG() => ZenoCard(title: "FMCG Dispatch Controls", child: Row(children: [Expanded(child: ZenoTextField(label: "CASE MULTIPLIER", initialValue: controller.product.caseMultiplier.toString(), onChanged: (v)=>controller.updateField(caseMultiplier: int.tryParse(v)))), const SizedBox(width: 12), _toggle("MANDATORY BATCH", controller.product.batchExpiryMandatory, (v)=>controller.updateField(batchExpiryMandatory: v)), const SizedBox(width: 12), _toggle("BREAK-BULK ALLOWED", controller.product.breakBulkAllowed, (v)=>controller.updateField(breakBulkAllowed: v))]));
  Widget _buildApparel() => ZenoCard(title: "Bulk Apparel Specs", child: Row(children: [Expanded(child: ZenoTextField(label: "PRE-PACK RATIO", initialValue: controller.product.prePackRatio, onChanged: (v)=>controller.updateField(prePackRatio: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: "BALE WT (KG)", initialValue: controller.product.baleWeight.toString(), onChanged: (v)=>controller.updateField(baleWeight: double.tryParse(v))))]));
  Widget _buildIndustrial() => ZenoCard(title: "Industrial Grades", child: Row(children: [Expanded(child: ZenoTextField(label: "MATERIAL GRADE", initialValue: controller.product.materialGrade, onChanged: (v)=>controller.updateField(materialGrade: v))), const SizedBox(width: 12), _toggle("MTC REQUIRED", controller.product.mtcRequired, (v)=>controller.updateField(mtcRequired: v))]));
  Widget _buildMedical() => ZenoCard(title: "Wholesale Pharma Regulatory", child: Row(children: [Expanded(child: ZenoTextField(label: "DRUG LICENSE (WHOLESALE)", initialValue: controller.product.drugLicenseWholesale, onChanged: (v)=>controller.updateField(drugLicenseWholesale: v))), const SizedBox(width: 12), _toggle("NARCOTIC LOGGING", controller.product.bulkNarcoticLogging, (v)=>controller.updateField(bulkNarcoticLogging: v))]));

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
