import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab1Identity extends StatelessWidget {
  final ProductStudioController controller;
  const Tab1Identity({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Basic Identity",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('title'),
                        label: "Product Name",
                        initialValue: p.title,
                        onChanged: (v) => controller.updateField(title: v),
                        width: ZenoFieldWidth.full,
                        isRequired: true,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('arabicTitle'),
                              label: "Arabic Name",
                              initialValue: p.arabicTitle,
                              onChanged: (v) => controller.updateField(arabicTitle: v),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('posShortThermalName'),
                              label: "POS Short Name",
                              initialValue: p.posShortThermalName,
                              onChanged: (v) => controller.updateField(posShortThermalName: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('description'),
                        label: "Marketing Description",
                        initialValue: p.description,
                        onChanged: (v) => controller.updateField(description: v),
                        maxLines: 2,
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ZenoCard(
                  title: "Classification",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Sector",
                              value: p.sectorId.isEmpty ? null : p.sectorId,
                              items: controller.categoriesList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(sectorId: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Department",
                              value: p.departmentId.isEmpty ? null : p.departmentId,
                              items: controller.categoriesList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(departmentId: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Category",
                              value: p.category.isEmpty ? null : p.category,
                              items: controller.categoriesList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(category: v),
                              isRequired: true,
                              onQuickAdd: () => controller.addCategory("New Category"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Brand",
                              value: p.brand.isEmpty ? null : p.brand,
                              items: controller.brandsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(brand: v),
                              isRequired: true,
                              onQuickAdd: () => controller.addBrand("New Brand"),
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
          // Right Column
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Identifiers",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('barcode'),
                              label: "Primary Barcode",
                              initialValue: p.barcode,
                              onChanged: (v) => controller.updateField(barcode: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('sku'),
                              label: "Master SKU",
                              initialValue: p.sku,
                              onChanged: (v) => controller.updateField(sku: v),
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('multiBarcodes'),
                        label: "Secondary Barcodes (Comma Separated)",
                        initialValue: p.multiBarcodes.join(", "),
                        onChanged: (v) {
                          final list = v.split(",")
                            .map((e) => e.trim())
                            .where((e) => e.isNotEmpty)
                            .toSet() // Prevent duplicates
                            .toList();
                          controller.updateField(multiBarcodes: list);
                        },
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('hsnCode'),
                        label: "HSN Code",
                        initialValue: p.hsnCode,
                        onChanged: (v) => controller.updateField(hsnCode: v),
                        width: ZenoFieldWidth.medium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ZenoCard(
                  title: "Policy & Status",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Return Policy",
                              value: p.returnPolicy.isEmpty ? null : p.returnPolicy,
                              items: ["Standard 30-Day", "No Return", "Exchange Only"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(returnPolicy: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Lifecycle Status",
                              value: p.productLifecycleStatus.isEmpty ? "Active" : p.productLifecycleStatus,
                              items: ["Active", "Phase-Out", "Discontinued"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(productLifecycleStatus: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSwitchRow(colors, "POS Quick-Sale", p.isQuickPOSSale, (v) => controller.updateField(isQuickPOSSale: v)),
                      const SizedBox(height: 4),
                      _buildSwitchRow(colors, "Weighable (Catch Weight)", p.isCatchWeight, (v) => controller.updateField(isCatchWeight: v)),
                      const SizedBox(height: 4),
                      _buildSwitchRow(colors, "Age Gate Required", p.ageGate, (v) => controller.updateField(ageGate: v)),
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
