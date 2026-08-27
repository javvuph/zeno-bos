import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab3PriceTax extends StatelessWidget {
  final ProductStudioController controller;
  const Tab3PriceTax({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Pricing
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Commercial Pricing",
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: ZenoTextField(label: "Cost Price", initialValue: p.costPrice.toString(), onChanged: (v) => controller.updateField(costPrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                          const SizedBox(width: 8),
                          Expanded(child: ZenoTextField(label: "Selling Price", initialValue: p.sellingPrice.toString(), onChanged: (v) => controller.updateField(sellingPrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: ZenoTextField(label: "MRP", initialValue: p.mrp.toString(), onChanged: (v) => controller.updateField(mrp: double.tryParse(v)), keyboardType: TextInputType.number)),
                          const SizedBox(width: 8),
                          Expanded(child: ZenoTextField(label: "Wholesale", initialValue: p.wholesalePrice.toString(), onChanged: (v) => controller.updateField(wholesalePrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: ZenoDropdown<String>(label: "Disc Type", value: p.discountType, items: ["Percentage", "Amount"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(discountType: v))),
                          const SizedBox(width: 8),
                          Expanded(child: ZenoTextField(label: "Disc Value", initialValue: p.discountValue.toString(), onChanged: (v) => controller.updateField(discountValue: double.tryParse(v)), keyboardType: TextInputType.number)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: ZenoTextField(label: "Promo Price", initialValue: p.promotionalPrice.toString(), onChanged: (v) => controller.updateField(promotionalPrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildSwitchRow(colors, "Floor Lock", p.priceFloorLock, (v) => controller.updateField(priceFloorLock: v))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Right Column: Taxation
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Taxation & Compliance",
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    children: [
                      ZenoTextField(key: const ValueKey('hsnCodeTax'), label: "HSN Code", initialValue: p.hsnCode, onChanged: (v) => controller.updateField(hsnCode: v), width: ZenoFieldWidth.full),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: ZenoDropdown<String>(label: "Tax Status", value: p.taxStatus, items: ["Taxable", "Exempt"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(taxStatus: v))),
                          const SizedBox(width: 8),
                          Expanded(child: ZenoDropdown<String>(label: "Tax Category", value: p.taxCategory, items: ["Standard", "Luxury"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(taxCategory: v))),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(child: ZenoTextField(label: "Tax Rate (%)", initialValue: p.taxRate.toString(), onChanged: (v) => controller.updateField(taxRate: double.tryParse(v)), keyboardType: TextInputType.number)),
                          const SizedBox(width: 8),
                          Expanded(child: ZenoDropdown<String>(label: "GST Mode", value: p.gstTaxMode, items: ["Intra-State", "Inter-State"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(gstTaxMode: v))),
                        ],
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
