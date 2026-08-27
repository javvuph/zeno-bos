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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Product Identity
              Expanded(
                child: ZenoCard(
                  title: "Product Identity",
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
                        label: "Product Description",
                        initialValue: p.description,
                        onChanged: (v) => controller.updateField(description: v),
                        maxLines: 3,
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Right Column: Identification
              Expanded(
                child: ZenoCard(
                  title: "Identification",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('sku'),
                              label: "Master SKU",
                              initialValue: p.sku,
                              onChanged: (v) => controller.updateField(sku: v),
                              isRequired: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('productId'),
                              label: "Product ID (Internal)",
                              initialValue: p.id,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('barcode'),
                              label: "Primary GTIN / Barcode",
                              initialValue: p.barcode,
                              onChanged: (v) => controller.updateField(barcode: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('internalBarcode'),
                              label: "Internal Barcode",
                              initialValue: p.internalBarcode,
                              onChanged: (v) => controller.updateField(internalBarcode: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('multiBarcodes'),
                        label: "Alternate / Secondary Barcodes",
                        initialValue: p.multiBarcodes.join(", "),
                        onChanged: (v) => controller.updateField(multiBarcodes: v.split(',').map((e)=>e.trim()).toList()),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('vendorSku'),
                              label: "Vendor SKU",
                              initialValue: p.vendorSku,
                              onChanged: (v) => controller.updateField(vendorSku: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('mfrPartNo'),
                              label: "Mfr Part Number",
                              initialValue: p.manufacturerPartNumber,
                              onChanged: (v) => controller.updateField(manufacturerPartNumber: v),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand / Manufacturer
              Expanded(
                child: ZenoCard(
                  title: "Brand / Manufacturer",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Brand",
                              value: p.brand.isEmpty ? null : p.brand,
                              items: controller.brandsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(brand: v),
                              onQuickAdd: () => controller.addBrand("New Brand"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('subBrand'),
                              label: "Sub Brand",
                              initialValue: p.subBrand,
                              onChanged: (v) => controller.updateField(subBrand: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('manufacturer'),
                              label: "Manufacturer",
                              initialValue: p.manufacturer,
                              onChanged: (v) => controller.updateField(manufacturer: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Country of Origin",
                              value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin,
                              items: ["India", "USA", "UK", "China", "UAE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) => controller.updateField(countryOfOrigin: v),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Lifecycle / Status
              Expanded(
                child: ZenoCard(
                  title: "Lifecycle / Status",
                  child: Column(
                    children: [
                      ZenoDropdown<String>(
                        label: "Status",
                        value: p.status,
                        items: ["Active", "Inactive", "Archived"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(status: v),
                        width: ZenoFieldWidth.medium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
