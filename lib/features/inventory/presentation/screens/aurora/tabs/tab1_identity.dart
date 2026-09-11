import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';

import 'package:zeno/core/layouts/zeno_responsive_layout.dart';

class Tab1Identity extends StatelessWidget {
  final ProductStudioController controller;
  const Tab1Identity({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final p = controller.product;
    final bType = p.businessType.toUpperCase();
    final scale = p.businessScale;
    final profile = controller.activeProfile;
    final isClothingSmall = profile == "Clothing" && bType == "FASHION" && scale == BusinessScale.small;

    return ZenoResponsiveLayout(
      child: isClothingSmall 
        ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  _compactSection("PRODUCT IDENTITY", colors, [
                    ZenoTextField(label: "Product Name / Style Title", initialValue: p.title, onChanged: (v) => controller.updateField(title: v), isRequired: true),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: ZenoTextField(label: "SKU / Style Code", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v), isRequired: true)),
                        const SizedBox(width: 12),
                        Expanded(child: ZenoTextField(label: "Barcode / GTIN", initialValue: p.barcode, onChanged: (v) => controller.updateField(barcode: v))),
                      ],
                    ),
                  ]),
                  const SizedBox(height: 12),
                  _compactSection("BRAND", colors, [
                    ZenoTextField(label: "Brand / Label", initialValue: p.brand, onChanged: (v) => controller.updateField(brand: v), isRequired: true),
                  ]),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: _compactSection("PRODUCT DETAILS", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Country of Origin", value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin, items: ["India", "USA", "UK", "China", "UAE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(countryOfOrigin: v))),
                    const SizedBox(width: 12),
                    Expanded(child: ZenoDropdown<String>(label: "Status", value: p.status, items: ["Active", "Draft", "Discontinued"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(status: v))),
                  ],
                ),
                const SizedBox(height: 12),
                ZenoTextField(label: "Description", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 5),
              ]),
            ),
          ],
        )
        : ZenoCard(
          title: "Product Identity & Classification",
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Column(
            children: [
              Row(
                children: [
                  if (controller.isFieldVisible('title'))
                    Expanded(flex: 3, child: ZenoTextField(label: "Product Name", initialValue: p.title, onChanged: (v) => controller.updateField(title: v), isRequired: true)),
                  if (controller.isFieldVisible('title') && (controller.isFieldVisible('arabicTitle') || controller.isFieldVisible('posShortThermalName')))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('arabicTitle'))
                    Expanded(flex: 2, child: ZenoTextField(label: "Arabic Name", initialValue: p.arabicTitle, onChanged: (v) => controller.updateField(arabicTitle: v), textAlign: TextAlign.right)),
                  if (controller.isFieldVisible('arabicTitle') && controller.isFieldVisible('posShortThermalName'))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('posShortThermalName'))
                    Expanded(flex: 2, child: ZenoTextField(label: "POS Short Name", initialValue: p.posShortThermalName, onChanged: (v) => controller.updateField(posShortThermalName: v))),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (controller.isFieldVisible('sku'))
                    Expanded(child: ZenoTextField(label: "SKU", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v), isRequired: true)),
                  if (controller.isFieldVisible('sku') && (controller.isFieldVisible('barcode') || controller.isFieldVisible('internalBarcode') || controller.isFieldVisible('vendorSku')))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('barcode'))
                    Expanded(child: ZenoTextField(label: "GTIN", initialValue: p.barcode, onChanged: (v) => controller.updateField(barcode: v))),
                  if (controller.isFieldVisible('barcode') && (controller.isFieldVisible('internalBarcode') || controller.isFieldVisible('vendorSku')))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('internalBarcode'))
                    Expanded(child: ZenoTextField(label: "Internal Barcode", initialValue: p.internalBarcode, onChanged: (v) => controller.updateField(internalBarcode: v))),
                  if (controller.isFieldVisible('internalBarcode') && controller.isFieldVisible('vendorSku'))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('vendorSku'))
                    Expanded(child: ZenoTextField(label: "Vendor SKU", initialValue: p.vendorSku, onChanged: (v) => controller.updateField(vendorSku: v))),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (controller.isFieldVisible('multiBarcodes'))
                    Expanded(flex: 3, child: ZenoTextField(label: "Secondary Barcodes", initialValue: p.multiBarcodes.join(", "), onChanged: (v) => controller.updateField(multiBarcodes: v.split(',').map((e)=>e.trim()).toList()))),
                  if (controller.isFieldVisible('multiBarcodes') && (controller.isFieldVisible('manufacturerPartNumber') || true))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('manufacturerPartNumber'))
                    Expanded(flex: 1, child: ZenoTextField(label: "Mfr Part", initialValue: p.manufacturerPartNumber, onChanged: (v) => controller.updateField(manufacturerPartNumber: v))),
                  const SizedBox(width: 8),
                  Expanded(flex: 1, child: ZenoTextField(label: "Product ID", initialValue: p.id, readOnly: true)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (controller.isFieldVisible('brand'))
                    Expanded(child: ZenoDropdown<String>(label: "Brand", value: p.brand.isEmpty ? null : p.brand, items: controller.brandsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(brand: v))),
                  if (controller.isFieldVisible('brand') && (controller.isFieldVisible('subBrand') || controller.isFieldVisible('manufacturer') || controller.isFieldVisible('countryOfOrigin') || controller.isFieldVisible('status')))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('subBrand'))
                    Expanded(child: ZenoTextField(label: "Sub Brand", initialValue: p.subBrand, onChanged: (v) => controller.updateField(subBrand: v))),
                  if (controller.isFieldVisible('subBrand') && (controller.isFieldVisible('manufacturer') || controller.isFieldVisible('countryOfOrigin') || controller.isFieldVisible('status')))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('manufacturer'))
                    Expanded(child: ZenoTextField(label: "Manufacturer", initialValue: p.manufacturer, onChanged: (v) => controller.updateField(manufacturer: v))),
                  if (controller.isFieldVisible('manufacturer') && (controller.isFieldVisible('countryOfOrigin') || controller.isFieldVisible('status')))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('countryOfOrigin'))
                    Expanded(child: ZenoDropdown<String>(label: "Origin", value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin, items: ["India", "USA", "UAE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(countryOfOrigin: v))),
                  if (controller.isFieldVisible('countryOfOrigin') && controller.isFieldVisible('status'))
                    const SizedBox(width: 8),
                  if (controller.isFieldVisible('status'))
                    Expanded(child: ZenoDropdown<String>(label: "Status", value: p.status, items: ["Active", "Inactive", "Archived"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(status: v))),
                ],
              ),
              const SizedBox(height: 4),
              if (controller.isFieldVisible('description'))
                ZenoTextField(label: "Product Description", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 2, width: ZenoFieldWidth.full),
            ],
          ),
        ),
    );
  }

  Widget _compactSection(String title, ZenoSemanticColors colors, List<Widget> children) {
    return ZenoCard(
      title: title,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
