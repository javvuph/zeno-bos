import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

part 'parts/fashion_basic_fields.part.dart';

class FashionBasicTab extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionBasicTab({super.key, required this.controller, required this.colors});

  @override
  State<FashionBasicTab> createState() => _FashionBasicTabState();
}

class _FashionBasicTabState extends State<FashionBasicTab> {
  ProductStudioController get controller => widget.controller;

  static const List<String> _brandOptions = ["ZENO", "Urban Thread", "Classic Loom", "Street Core", "Heritage Wear"];
  static const List<String> _categoryOptions = ["Shirts", "T-Shirts", "Jeans", "Trousers", "Dresses", "Jackets", "Ethnic"];

  TextEditingController _barcodeController(String value) =>
      TextEditingController.fromValue(TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      ));

  @override
  Widget build(BuildContext context) {
    final p = controller.product;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _compactSection("PRODUCT & ONLINE STORE IDENTITY", widget.colors, [
                ZenoTextField(
                  label: "Style Title / Product Name *",
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
                        label: "Master Style Code (SKU) *",
                        initialValue: p.sku,
                        onChanged: (v) => controller.updateField(sku: v),
                        isRequired: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ZenoTextField(
                        label: controller.hasVariants ? "Barcode / GTIN (Assigned per variant)" : "Barcode / GTIN",
                        controller: _barcodeController(controller.hasVariants ? "" : p.barcode),
                        onChanged: (v) => controller.updateField(barcode: v),
                        readOnly: controller.hasVariants,
                        suffix: controller.hasVariants
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.auto_fix_high_rounded, size: 16, color: Color(0xFF6366F1)),
                                tooltip: "Auto-generate Barcode",
                                onPressed: controller.generateSuggestedBarcode,
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPhotoSlot(widget.colors),
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
                _compactSection("PRICING & STOCK", widget.colors, [
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
                          initialValue: p.openingStock == 0 ? "" : p.openingStock.toString(),
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

              if (controller.isAdvancedMode)
                _compactSection("TARGET AUDIENCE & GOVERNANCE", widget.colors, [
                  Row(
                    children: [
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Gender",
                          value: p.gender.isEmpty ? null : p.gender,
                          items: ["Men", "Women", "Unisex", "Kids"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(gender: v),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Target Age Group",
                          value: p.targetAgeGroup.isEmpty ? null : p.targetAgeGroup,
                          items: ["Adult", "Teens", "Kids", "Toddler"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(targetAgeGroup: v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Season",
                          value: p.season.isEmpty ? null : p.season,
                          items: ["Spring", "Summer", "Autumn", "Winter", "All-Season"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(season: v),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Collection / Drop",
                          value: p.collectionEdition.isEmpty ? null : p.collectionEdition,
                          items: ["Core", "Summer Drop", "Festive Edit", "Limited Edition"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(collectionEdition: v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Country of Origin",
                          value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin,
                          items: ["India", "USA", "UK", "China", "UAE"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(countryOfOrigin: v),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Status",
                          value: p.status,
                          items: ["Active", "Inactive", "Archived"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) => controller.updateField(status: v),
                        ),
                      ),
                    ],
                  ),
                ]),
            ],
          ),
        ),
      ],
    );
  }
}
