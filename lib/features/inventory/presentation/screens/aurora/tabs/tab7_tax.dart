import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab7Tax extends StatelessWidget {
  final ProductStudioController controller;
  const Tab7Tax({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Tax Classification",
                  child: Column(
                    children: [
                      ZenoDropdown<String>(
                        label: "Tax Status",
                        value: p.taxStatus.isEmpty ? "Taxable" : p.taxStatus,
                        items: ["Taxable", "Exempt", "Zero Rated", "Non-GST"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(taxStatus: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('hsnCode'),
                        label: "HSN Code",
                        initialValue: p.hsnCode,
                        onChanged: (v) => controller.updateField(hsnCode: v),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Rate & Calculation",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('taxRate'),
                        label: "GST / VAT Rate %",
                        initialValue: p.taxRate.toString(),
                        onChanged: (v) => controller.updateField(taxRate: double.tryParse(v)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 16),
                      _buildSwitchRow(colors, "Tax Inclusive Pricing", p.taxTreatment == "Inclusive", (v) => controller.updateField(taxTreatment: v ? "Inclusive" : "Exclusive")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(ZenoSemanticColors colors, String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.textSecondary)),
        const Spacer(),
        SizedBox(
          height: 24,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colors.accentPrimary,
          ),
        ),
      ],
    );
  }
}
