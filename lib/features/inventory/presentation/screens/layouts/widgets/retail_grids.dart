import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

Widget buildRetailIdentityGrid(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(
    children: [
      ZenoTextField(label: "Product Title", initialValue: controller.product.title, onChanged: (v) => controller.updateField(title: v)),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "SKU / Item Code", initialValue: controller.product.sku, onChanged: (v) => controller.updateField(sku: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Barcode (Primary)", initialValue: controller.product.barcode, onChanged: (v) => controller.updateField(barcode: v))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Aisle Location", initialValue: controller.product.aisleLocation, onChanged: (v) => controller.updateField(aisleLocation: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "PLU Code", initialValue: controller.product.pluCode, onChanged: (v) => controller.updateField(pluCode: v))),
      ]),
    ],
  );
}

Widget buildRetailPackagingGrid(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(
    children: [
      Row(children: [
        Expanded(child: ZenoTextField(label: "Base Unit (UOM)", initialValue: controller.product.unit, onChanged: (v) => controller.updateField(unit: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Stocking Unit", initialValue: controller.product.stockUnit, onChanged: (v) => controller.updateField(stockUnit: v))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Conversion Factor", initialValue: controller.product.conversionFactor.toString(), onChanged: (v) => controller.updateField(conversionFactor: double.tryParse(v)))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Units Per Package", initialValue: controller.product.unitsPerPackage.toString(), onChanged: (v) => controller.updateField(unitsPerPackage: int.tryParse(v)))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Gross Weight (kg)", initialValue: controller.product.grossWeight.toString(), onChanged: (v) => controller.updateField(grossWeight: double.tryParse(v)))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Dimensions (LxWxH)", initialValue: controller.product.unitDimensions, onChanged: (v) => controller.updateField(unitDimensions: v))),
      ]),
    ],
  );
}

Widget buildRetailTaxGrid(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(
    children: [
      Row(children: [
        Expanded(child: ZenoTextField(label: "HSN / SAC Code", initialValue: controller.product.taxCode, onChanged: (v) => controller.updateField(taxCode: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "GST Tax Mode", initialValue: controller.product.gstTaxMode, onChanged: (v) => controller.updateField(gstTaxMode: v))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Country of Origin", initialValue: controller.product.countryOfOrigin, onChanged: (v) => controller.updateField(countryOfOrigin: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Import Duty Class", initialValue: controller.product.importDutyClass, onChanged: (v) => controller.updateField(importDutyClass: v))),
      ]),
      const SizedBox(height: 12),
      ZenoTextField(label: "Packaging Deposit (Refundable)", initialValue: controller.product.packagingDeposit.toString(), onChanged: (v) => controller.updateField(packagingDeposit: double.tryParse(v))),
    ],
  );
}

Widget buildRetailPricingGrid(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(
    children: [
      Row(children: [
        Expanded(child: ZenoTextField(label: "Selling Price (B2C)", initialValue: controller.product.sellingPrice.toString(), onChanged: (v) => controller.updateField(sellingPrice: double.tryParse(v)))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "MRP (Max Retail)", initialValue: controller.product.mrp.toString(), onChanged: (v) => controller.updateField(mrp: double.tryParse(v)))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Online / App Price", initialValue: controller.product.onlinePrice.toString(), onChanged: (v) => controller.updateField(onlinePrice: double.tryParse(v)))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Max Discount Allowed (%)", initialValue: controller.product.maxDiscountPct.toString(), onChanged: (v) => controller.updateField(maxDiscountPct: double.tryParse(v)))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Member Loyalty Price", initialValue: controller.product.memberLoyaltyPrice.toString(), onChanged: (v) => controller.updateField(memberLoyaltyPrice: double.tryParse(v)))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Points Multiplier", initialValue: controller.product.loyaltyPointsMultiplier.toString(), onChanged: (v) => controller.updateField(loyaltyPointsMultiplier: double.tryParse(v)))),
      ]),
    ],
  );
}

Widget buildRetailLifecycleGrid(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(
    children: [
      Row(children: [
        Expanded(child: SwitchLabel(label: "Batch Tracking", value: controller.product.enableBatchTracking, onChanged: (v) => controller.updateField(enableBatchTracking: v), colors: colors)),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Expiry Warning (Days)", initialValue: controller.product.expiryWarningThreshold.toString(), onChanged: (v) => controller.updateField(expiryWarningThreshold: int.tryParse(v)))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Storage Class", initialValue: controller.product.storageClass, onChanged: (v) => controller.updateField(storageClass: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Floor Zone", initialValue: controller.product.floorZone, onChanged: (v) => controller.updateField(floorZone: v))),
      ]),
      const SizedBox(height: 12),
      ZenoTextField(label: "Storage Condition", initialValue: controller.product.storageCondition, onChanged: (v) => controller.updateField(storageCondition: v)),
    ],
  );
}

Widget buildRetailMarketingGrid(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(
    children: [
      ZenoTextField(label: "Marketing Title (SEO)", initialValue: controller.product.marketingTitle, onChanged: (v) => controller.updateField(marketingTitle: v)),
      const SizedBox(height: 12),
      ZenoTextField(label: "URL Slug / Permalink", initialValue: controller.product.urlSlug, onChanged: (v) => controller.updateField(urlSlug: v)),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Promotional Badges", initialValue: controller.product.promotionalBadges, onChanged: (v) => controller.updateField(promotionalBadges: v))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Search Keywords", initialValue: controller.product.searchKeywords.join(", "), onChanged: (v) => controller.updateField(searchKeywords: v.split(",").map((e) => e.trim()).toList()))),
      ]),
    ],
  );
}

class SwitchLabel extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ZenoSemanticColors colors;
  const SwitchLabel({super.key, required this.label, required this.value, required this.onChanged, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary))),
      Transform.scale(scale: 0.7, child: Switch(value: value, onChanged: onChanged, activeThumbColor: colors.accentPrimary)),
    ]);
  }
}
