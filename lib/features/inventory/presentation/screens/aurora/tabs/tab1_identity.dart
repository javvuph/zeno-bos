import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_image_gallery.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/core/layouts/zeno_responsive_layout.dart';

part 'parts/tab1_identity_helpers.part.dart';

class Tab1Identity extends StatefulWidget {
  final ProductStudioController controller;
  const Tab1Identity({super.key, required this.controller});

  @override
  State<Tab1Identity> createState() => _Tab1IdentityState();
}

class _Tab1IdentityState extends State<Tab1Identity> {
  ProductStudioController get controller => widget.controller;

  static const List<String> _brandOptions = ["ZENO", "Urban Thread", "Classic Loom", "Street Core", "Heritage Wear"];
  static const List<String> _categoryOptions = ["Shirts", "T-Shirts", "Jeans", "Trousers", "Dresses", "Jackets", "Ethnic"];
  static const List<String> _countryOptions = ["India", "USA", "UK", "China", "UAE"];

  TextEditingController _barcodeController(String value) =>
      TextEditingController.fromValue(TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      ));

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final p = controller.product;

    return ZenoResponsiveLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _compactSection("PRODUCT & ONLINE STORE IDENTITY", colors, [
                  ZenoTextField(
                    label: "Product Name / Style Title *",
                    initialValue: p.title,
                    onChanged: controller.maybeAutoGenerateSkuFromTitle,
                    isRequired: true,
                    width: ZenoFieldWidth.full,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Category *",
                          value: p.category.isEmpty ? null : p.category,
                          items: _withCurrent(controller.categoriesList.isEmpty ? _categoryOptions : controller.categoriesList, p.category)
                              .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(category: v),
                          isRequired: true,
                          onQuickAdd: () => _showQuickAddDialog(context, "Category", (val) => controller.addCategory(val)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Brand / Label",
                          value: p.brand.isEmpty ? null : p.brand,
                          items: _withCurrent(controller.brandsList.isEmpty ? _brandOptions : controller.brandsList, p.brand)
                              .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(brand: v),
                          onQuickAdd: () => _showQuickAddDialog(context, "Brand / Label", (val) => controller.addBrand(val)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ZenoTextField(
                          label: "SKU / Style Code *",
                          initialValue: p.sku,
                          onChanged: (v) => controller.updateField(sku: v),
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ZenoTextField(
                          label: "Barcode / GTIN",
                          controller: _barcodeController(p.barcode),
                          onChanged: (v) => controller.updateField(barcode: v),
                          suffix: IconButton(
                            icon: const Icon(Icons.auto_fix_high_rounded, size: 16, color: Color(0xFF6366F1)),
                            tooltip: "Auto-generate Barcode",
                            onPressed: controller.generateSuggestedBarcode,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!controller.isAdvancedMode) ...[
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Online Store Description", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                            InkWell(
                              onTap: () => _autoWriteAIDescription(context),
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFF818CF8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.auto_awesome_rounded, size: 12, color: Color(0xFF4F46E5)),
                                    SizedBox(width: 4),
                                    Text("✨ AI Auto-Write", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4F46E5))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ZenoTextField(
                          label: null,
                          initialValue: p.description,
                          onChanged: (v) => controller.updateField(description: v),
                          maxLines: 3,
                          hint: "Enter product notes or tap AI Auto-Write...",
                          width: ZenoFieldWidth.full,
                        ),
                      ],
                    ),
                  ],
                ]),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            flex: 5,
            child: Column(
              children: [
                if (!controller.isAdvancedMode)
                  _compactSection("PRICING & STOCK", colors, [
                    Row(
                      children: [
                        Expanded(
                          child: ZenoTextField(
                            label: "Purchase / Cost Price (₹) *",
                            initialValue: p.costPrice.toString(),
                            onChanged: (v) => controller.updateCost(double.tryParse(v) ?? 0.0),
                            keyboardType: TextInputType.number,
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ZenoTextField(
                            label: "Selling Price / MRP (₹) *",
                            initialValue: p.sellingPrice.toString(),
                            onChanged: (v) => controller.updatePrice(double.tryParse(v) ?? 0.0),
                            keyboardType: TextInputType.number,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ZenoTextField(
                            label: "Discount Value (%)",
                            initialValue: p.discountValue.toString(),
                            onChanged: (v) => controller.updateField(discountValue: double.tryParse(v) ?? 0.0),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ZenoTextField(
                            label: "Low Stock Alert Threshold",
                            initialValue: (p.reorderLevel <= 0 ? 2.0 : p.reorderLevel).toString(),
                            onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v) ?? 2.0),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    controller.generatedVariants.isEmpty
                        ? ZenoTextField(
                            label: "Flat Opening Stock Quantity",
                            initialValue: p.openingStock.toString(),
                            onChanged: (v) => controller.updateField(openingStock: double.tryParse(v) ?? 0.0),
                            keyboardType: TextInputType.number,
                            width: ZenoFieldWidth.full,
                          )
                        : ZenoTextField(
                            label: "Total Variant Stock (Auto)",
                            initialValue: "${controller.calculatedTotalStock} (Locked from Variants)",
                            readOnly: true,
                            width: ZenoFieldWidth.full,
                          ),
                  ]),

                if (!controller.isAdvancedMode) ...[
                  const SizedBox(height: 16),
                  _compactSection("PRODUCT IMAGES", colors, [
                    _buildImageGallery(colors),
                  ]),
                ],

                if (controller.isAdvancedMode)
                  _compactSection("PRODUCT DETAILS & GOVERNANCE", colors, [
                    ZenoDropdown<String>(
                      label: "Country of Origin",
                      value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin,
                      items: _withCurrent(_countryOptions, p.countryOfOrigin).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => controller.updateField(countryOfOrigin: v),
                      onQuickAdd: () => _showQuickAddDialog(context, "Country of Origin", (val) => controller.updateField(countryOfOrigin: val)),
                    ),
                    const SizedBox(height: 16),
                    ZenoDropdown<String>(
                      label: "Status",
                      value: p.status,
                      items: ["Active", "Inactive", "Archived"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => controller.updateField(status: v),
                    ),
                    const SizedBox(height: 16),
                    ZenoTextField(
                      label: "Description",
                      initialValue: p.description,
                      onChanged: (v) => controller.updateField(description: v),
                      maxLines: 5,
                      width: ZenoFieldWidth.full,
                    ),
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
