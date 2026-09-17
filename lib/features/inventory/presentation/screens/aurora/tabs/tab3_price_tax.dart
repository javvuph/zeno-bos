import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../../domain/models/product_studio_data.dart';
import 'package:zeno/core/layouts/zeno_responsive_layout.dart';

part 'parts/tab3_price_tax_clothing.part.dart';

class Tab3PriceTax extends StatelessWidget {
  final ProductStudioController controller;
  const Tab3PriceTax({super.key, required this.controller});

  static const List<String> _taxStatusOptions = ["Taxable", "Exempt"];
  static const List<String> _discountTypeOptions = ["Percentage", "Amount"];

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final bType = p.businessType.toUpperCase();
    final scale = p.businessScale;
    final profile = controller.activeProfile;
    final isClothingSmall = profile == "Clothing" && bType == "FASHION" && scale == BusinessScale.small;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoResponsiveLayout(
      child: isClothingSmall 
        ? _buildClothingSmallLayout(context, p, colors)
        : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        if (controller.isFieldVisible('mrp') || controller.isFieldVisible('wholesalePrice'))
                        Row(
                          children: [
                            if (controller.isFieldVisible('mrp'))
                              Expanded(child: ZenoTextField(label: "MRP", initialValue: p.mrp.toString(), onChanged: (v) => controller.updateField(mrp: double.tryParse(v)), keyboardType: TextInputType.number)),
                            if (controller.isFieldVisible('mrp') && controller.isFieldVisible('wholesalePrice'))
                              const SizedBox(width: 8),
                            if (controller.isFieldVisible('wholesalePrice'))
                              Expanded(child: ZenoTextField(label: "Wholesale", initialValue: p.wholesalePrice.toString(), onChanged: (v) => controller.updateField(wholesalePrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                          ],
                        ),
                        if (controller.isFieldVisible('mrp') || controller.isFieldVisible('wholesalePrice'))
                          const SizedBox(height: 6),
                        if (controller.isFieldVisible('discountType') || controller.isFieldVisible('discountValue'))
                        Row(
                          children: [
                            if (controller.isFieldVisible('discountType'))
                              Expanded(child: ZenoDropdown<String>(label: "Disc Type", value: p.discountType, items: _withCurrent(_discountTypeOptions, p.discountType).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(discountType: v), onQuickAdd: () => _showQuickAddDialog(context, "Disc Type", (val) => controller.updateField(discountType: val)))),
                            if (controller.isFieldVisible('discountType') && controller.isFieldVisible('discountValue'))
                              const SizedBox(width: 8),
                            if (controller.isFieldVisible('discountValue'))
                              Expanded(child: ZenoTextField(label: "Disc Value", initialValue: p.discountValue.toString(), onChanged: (v) => controller.updateField(discountValue: double.tryParse(v)), keyboardType: TextInputType.number)),
                          ],
                        ),
                        if (controller.isFieldVisible('discountType') || controller.isFieldVisible('discountValue'))
                          const SizedBox(height: 6),
                        Row(
                          children: [
                            if (controller.isFieldVisible('promotionalPrice'))
                              Expanded(child: ZenoTextField(label: "Promo Price", initialValue: p.promotionalPrice.toString(), onChanged: (v) => controller.updateField(promotionalPrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                            if (controller.isFieldVisible('promotionalPrice') && controller.isFieldVisible('priceFloorLock'))
                              const SizedBox(width: 8),
                            if (controller.isFieldVisible('priceFloorLock'))
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
                            Expanded(child: ZenoDropdown<String>(label: "Tax Status", value: p.taxStatus, items: _withCurrent(_taxStatusOptions, p.taxStatus).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(taxStatus: v), onQuickAdd: () => _showQuickAddDialog(context, "Tax Status", (val) => controller.updateField(taxStatus: val)))),
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

  Widget _compactSection(String title, ZenoSemanticColors colors, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x14667EEA), Color(0x0D764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0x33667EEA)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF667EEA),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  List<String> _withCurrent(List<String> options, String current) {
    if (current.isEmpty || options.contains(current)) return options;
    return [...options, current];
  }

  void _showQuickAddDialog(BuildContext context, String type, Function(String) onAdd) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Add Custom $type", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: textController,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            labelText: "$type Name",
            hintText: "Enter $type name",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onAdd(textController.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
