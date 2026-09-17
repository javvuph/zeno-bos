import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';

class MarketingSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const MarketingSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          // 1. Digital Presence (SEO & Core)
          ZenoCard(
            title: "Digital Presence",
            titleColor: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ZenoTextField(
                  label: "Marketing Title",
                  hint: "Customer-facing title",
                  initialValue: controller.product.marketingTitle,
                  onChanged: (v) => controller.updateField(marketingTitle: v),
                ),
                const SizedBox(height: 16),
                ZenoTextField(
                  label: "URL Slug",
                  hint: "product-url-slug",
                  initialValue: controller.product.urlSlug,
                  onChanged: (v) => controller.updateField(urlSlug: v),
                ),
                const SizedBox(height: 16),
                ZenoTextField(
                  label: "Meta Description",
                  hint: "Brief summary for search engines",
                  maxLines: 3,
                  initialValue: controller.product.metaDescription,
                  onChanged: (v) => controller.updateField(metaDescription: v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2. Product Presence & Status
          ZenoCard(
            title: "Product Presence",
            titleColor: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: colors.bgTier3,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: colors.borderSubtle),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("FEATURED PRODUCT",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: controller.product.featuredProduct,
                                onChanged: (v) =>
                                    controller.updateField(featuredProduct: v),
                                activeThumbColor: colors.accentPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ZenoDropdown<String>(
                        label: "Product Status",
                        value: controller.product.status,
                        items: const [
                          DropdownMenuItem(value: "Active", child: Text("Active")),
                          DropdownMenuItem(value: "Draft", child: Text("Draft")),
                          DropdownMenuItem(
                              value: "Inactive", child: Text("Inactive")),
                          DropdownMenuItem(
                              value: "Archived", child: Text("Archived")),
                        ],
                        onChanged: (v) => controller.updateField(status: v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ZenoDropdown<String>(
                  label: "Product Relationship",
                  value: controller.product.productRelationship.isEmpty
                      ? null
                      : controller.product.productRelationship,
                  items: const [
                    DropdownMenuItem(
                        value: "Related Product", child: Text("Related Product")),
                    DropdownMenuItem(
                        value: "Alternative Product",
                        child: Text("Alternative Product")),
                    DropdownMenuItem(value: "Accessory", child: Text("Accessory")),
                    DropdownMenuItem(value: "Upsell", child: Text("Upsell")),
                    DropdownMenuItem(value: "Cross-sell", child: Text("Cross-sell")),
                    DropdownMenuItem(
                        value: "Replacement", child: Text("Replacement")),
                  ],
                  onChanged: (v) =>
                      controller.updateField(productRelationship: v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 3. Warranty Information
          ZenoCard(
            title: "Warranty Protection",
            titleColor: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: colors.bgTier3,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: colors.borderSubtle),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("WARRANTY AVAILABLE",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: controller.product.warrantyAvailable,
                                onChanged: (v) =>
                                    controller.updateField(warrantyAvailable: v),
                                activeThumbColor: colors.accentPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (controller.product.warrantyAvailable) ...[
                      SizedBox(
                        width: 100,
                        child: ZenoTextField(
                          label: "Duration",
                          hint: "12",
                          textAlign: TextAlign.center,
                          initialValue:
                              controller.product.warrantyDuration.toString() ??
                                  "",
                          onChanged: (v) => controller.updateField(
                              warrantyDuration: int.tryParse(v)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ZenoDropdown<String>(
                          label: "Unit",
                          value: controller.product.warrantyUnit,
                          items: const [
                            DropdownMenuItem(value: "Days", child: Text("Days")),
                            DropdownMenuItem(
                                value: "Months", child: Text("Months")),
                            DropdownMenuItem(value: "Years", child: Text("Years")),
                            DropdownMenuItem(
                                value: "Lifetime", child: Text("Lifetime")),
                          ],
                          onChanged: (v) =>
                              controller.updateField(warrantyUnit: v),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                ZenoTextField(
                  label: "Warranty Description",
                  hint: "e.g. 1 Year Limited Manufacturer Warranty",
                  initialValue: controller.product.warrantyInfo,
                  onChanged: (v) => controller.updateField(warrantyInfo: v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
