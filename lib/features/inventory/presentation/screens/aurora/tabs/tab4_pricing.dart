import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab4Pricing extends StatelessWidget {
  final ProductStudioController controller;
  const Tab4Pricing({super.key, required this.controller});

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
                  title: "Cost & Margin Analysis",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('costPrice'),
                              label: "Purchase Cost",
                              initialValue: p.costPrice.toString(),
                              onChanged: (v) => controller.updateField(costPrice: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: _buildSwitchRow(colors, "Auto Landed", p.autoComputeLandedCost, (v) => controller.updateField(autoComputeLandedCost: v)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('targetMarginPct'),
                              label: "Margin %",
                              initialValue: p.targetMarginPct.toString(),
                              onChanged: (v) => controller.updateField(targetMarginPct: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('targetMarkupPct'),
                              label: "Markup %",
                              initialValue: p.targetMarkupPct.toString(),
                              onChanged: (v) => controller.updateField(targetMarkupPct: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ZenoCard(
                  title: "Selling Prices",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('sellingPrice'),
                              label: "Store Price",
                              initialValue: p.sellingPrice.toString(),
                              onChanged: (v) => controller.updateField(sellingPrice: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('mrp'),
                              label: "MRP",
                              initialValue: p.mrp.toString(),
                              onChanged: (v) => controller.updateField(mrp: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('wholesalePrice'),
                              label: "Wholesale",
                              initialValue: p.wholesalePrice.toString(),
                              onChanged: (v) => controller.updateField(wholesalePrice: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('memberLoyaltyPrice'),
                              label: "Floor (Member)",
                              initialValue: p.memberLoyaltyPrice.toString(),
                              onChanged: (v) => controller.updateField(memberLoyaltyPrice: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                        ],
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
                  title: "Regional & POS Control",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('branchSellingPrice'),
                        label: "Branch Selling Price",
                        initialValue: p.branchSellingPrice.toString(),
                        onChanged: (v) => controller.updateField(branchSellingPrice: double.tryParse(v)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 10),
                      ZenoTextField(
                        key: const ValueKey('multiBuyBundlePrice'),
                        label: "Bundle / B2B Price",
                        initialValue: p.multiBuyBundlePrice.toString(),
                        onChanged: (v) => controller.updateField(multiBuyBundlePrice: double.tryParse(v)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ZenoCard(
                  title: "Cashier Governance",
                  child: Column(
                    children: [
                      _buildSwitchRow(colors, "Cashier Override", p.cashierOverride, (v) => controller.updateField(cashierOverride: v)),
                      const SizedBox(height: 10),
                      ZenoTextField(
                        key: const ValueKey('maxCashierDisc'),
                        label: "Max Discount %",
                        initialValue: p.maxCashierDisc.toString(),
                        onChanged: (v) => controller.updateField(maxCashierDisc: double.tryParse(v)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        width: ZenoFieldWidth.full,
                        readOnly: !p.cashierOverride,
                      ),
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
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
        const Spacer(),
        SizedBox(
          height: 20,
          child: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: colors.accentPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
