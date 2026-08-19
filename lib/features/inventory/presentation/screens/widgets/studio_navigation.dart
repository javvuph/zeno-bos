import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';

Widget buildHorizontalNavigator(ProductStudioController controller, ZenoSemanticColors colors) {
  final sections = [
    {'id': ProductStudioSection.basic, 'label': 'Basic'},
    {'id': ProductStudioSection.retailPackaging, 'label': 'Retail & Packaging'},
    {'id': ProductStudioSection.fashionBasic, 'label': 'Fashion'},
    {'id': ProductStudioSection.fnbDish, 'label': 'Dish Identity'},
    {'id': ProductStudioSection.fnbKitchen, 'label': 'Kitchen & Recipe'},
    {'id': ProductStudioSection.healthcareBasic, 'label': 'Basic Info'},
    {'id': ProductStudioSection.healthcareClinical, 'label': 'Clinical & Batch'},
    {'id': ProductStudioSection.wholesaleBasic, 'label': 'Basic'},
    {'id': ProductStudioSection.wholesaleB2B, 'label': 'B2B & Packaging'},
    {'id': ProductStudioSection.serviceBasic, 'label': 'Service Info'},
    {'id': ProductStudioSection.serviceExecution, 'label': 'Execution & Add-ons'},
    {'id': ProductStudioSection.inventoryPrice, 'label': 'Inventory & Price'},
    {'id': ProductStudioSection.suppliers, 'label': 'Suppliers'},
    {'id': ProductStudioSection.tax, 'label': 'Tax'},
    {'id': ProductStudioSection.media, 'label': 'Media'},
    {'id': ProductStudioSection.variants, 'label': 'Variants'},
    {'id': ProductStudioSection.industry, 'label': 'Industry Specific'},
    {'id': ProductStudioSection.packaging, 'label': 'Packaging'},
    {'id': ProductStudioSection.unitsConversion, 'label': 'Units & Conversion'},
    {'id': ProductStudioSection.batch, 'label': 'Batch'},
    {'id': ProductStudioSection.expiry, 'label': 'Expiry'},
    {'id': ProductStudioSection.marketing, 'label': 'Marketing'},
    {'id': ProductStudioSection.advanced, 'label': 'Advanced'},
  ];
  return Container(
    height: 38, decoration: BoxDecoration(color: colors.bgTier2, border: Border(bottom: BorderSide(color: colors.borderSubtle))),
    child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      ...sections.where((s) => controller.isSectionVisible(s['id'] as ProductStudioSection)).map((s) {
        final id = s['id'] as ProductStudioSection; final isActive = controller.activeSection == id; final isDone = controller.isSectionComplete(id);
        return InkWell(onTap: () => controller.setSection(id), child: Container(
          height: 38, padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(color: isActive ? colors.accentPrimary.withValues(alpha: 0.08) : null, border: Border(bottom: BorderSide(color: isActive ? colors.accentPrimary : Colors.transparent, width: 2))),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text((s['label'] as String).toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: isActive ? FontWeight.w900 : FontWeight.w700, color: isActive ? colors.textPrimary : colors.textDisabled, letterSpacing: 1.1)),
            if (isDone) ...[const SizedBox(width: 4), const Icon(Icons.check_circle, size: 10, color: Colors.green)],
          ]),
        ));
      }),
    ])),
  );
}

Widget buildStickyFooter(ProductStudioController controller, ZenoSemanticColors colors) {
  return Container(
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: colors.borderSubtle)),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, size: 14, color: colors.statusSuccess),
        const SizedBox(width: 8),
        Text("Autosaved at ${DateTime.now().hour}:${DateTime.now().minute}", style: TextStyle(fontSize: 11, color: colors.textDisabled, fontWeight: FontWeight.w500)),
        const Spacer(),
        ZenoButton(
          label: "CANCEL",
          variant: ZenoButtonVariant.ghost,
          size: ZenoButtonSize.sm,
          onPressed: () => controller.resetToNew(),
        ),
        const SizedBox(width: 12),
        ZenoButton(
          label: "SAVE AS DRAFT",
          variant: ZenoButtonVariant.secondary,
          size: ZenoButtonSize.sm,
          onPressed: () => controller.saveDraft(),
        ),
        const SizedBox(width: 12),
        ZenoButton(
          label: "SAVE & CONTINUE",
          icon: Icons.arrow_forward_rounded,
          size: ZenoButtonSize.md,
          onPressed: controller.saveProduct,
          isLoading: controller.isSaving,
        ),
      ],
    ),
  );
}
