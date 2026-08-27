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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ZenoCard(
            title: "Identity & Identification",
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 3, child: ZenoTextField(label: "Product Name", initialValue: p.title, onChanged: (v) => controller.updateField(title: v), isRequired: true)),
                    const SizedBox(width: 8),
                    Expanded(flex: 2, child: ZenoTextField(label: "Arabic Name", initialValue: p.arabicTitle, onChanged: (v) => controller.updateField(arabicTitle: v), textAlign: TextAlign.right)),
                    const SizedBox(width: 8),
                    Expanded(flex: 2, child: ZenoTextField(label: "POS Short Name", initialValue: p.posShortThermalName, onChanged: (v) => controller.updateField(posShortThermalName: v))),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: ZenoTextField(label: "SKU", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v), isRequired: true)),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "GTIN", initialValue: p.barcode, onChanged: (v) => controller.updateField(barcode: v))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "Internal", initialValue: p.internalBarcode, onChanged: (v) => controller.updateField(internalBarcode: v))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "Vendor SKU", initialValue: p.vendorSku, onChanged: (v) => controller.updateField(vendorSku: v))),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(flex: 3, child: ZenoTextField(label: "Secondary Barcodes", initialValue: p.multiBarcodes.join(", "), onChanged: (v) => controller.updateField(multiBarcodes: v.split(',').map((e)=>e.trim()).toList()))),
                    const SizedBox(width: 8),
                    Expanded(flex: 1, child: ZenoTextField(label: "Mfr Part", initialValue: p.manufacturerPartNumber, onChanged: (v) => controller.updateField(manufacturerPartNumber: v))),
                    const SizedBox(width: 8),
                    Expanded(flex: 1, child: ZenoTextField(label: "Product ID", initialValue: p.id, readOnly: true)),
                  ],
                ),
                const SizedBox(height: 6),
                ZenoTextField(label: "Product Description", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 2, width: ZenoFieldWidth.full),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: ZenoCard(
                  title: "Brand & Manufacturer",
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(child: ZenoDropdown<String>(label: "Brand", value: p.brand.isEmpty ? null : p.brand, items: controller.brandsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(brand: v))),
                      const SizedBox(width: 8),
                      Expanded(child: ZenoTextField(label: "Sub Brand", initialValue: p.subBrand, onChanged: (v) => controller.updateField(subBrand: v))),
                      const SizedBox(width: 8),
                      Expanded(child: ZenoTextField(label: "Manufacturer", initialValue: p.manufacturer, onChanged: (v) => controller.updateField(manufacturer: v))),
                      const SizedBox(width: 8),
                      Expanded(child: ZenoDropdown<String>(label: "Origin", value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin, items: ["India", "USA", "UAE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(countryOfOrigin: v))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: ZenoCard(
                  title: "Status",
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ZenoDropdown<String>(label: "Lifecycle Status", value: p.status, items: ["Active", "Inactive", "Archived"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(status: v)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
