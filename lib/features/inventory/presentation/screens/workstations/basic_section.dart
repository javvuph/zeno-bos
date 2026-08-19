import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_redesign_widgets.dart';

class BasicSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BasicSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      StudioSectionCard(
        title: "Product Identity",
        subtitle: "Core names and descriptions for catalog recognition",
        icon: Icons.badge_outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 20, runSpacing: 20,
              children: [
                ZenoTextField(
                  key: const ValueKey('title'),
                  label: "Product Name",
                  initialValue: p.title,
                  onChanged: (v) => controller.updateField(title: v),
                  width: ZenoFieldWidth.standard,
                  isRequired: true,
                ),
                ZenoTextField(
                  key: const ValueKey('sku'),
                  label: "SKU / Master Code",
                  initialValue: p.sku,
                  onChanged: (v) => controller.updateField(sku: v),
                  width: ZenoFieldWidth.medium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ZenoTextField(
              key: const ValueKey('description'),
              label: "Description & Merchandising Notes",
              initialValue: p.description,
              onChanged: (v) => controller.updateField(description: v),
              width: ZenoFieldWidth.full,
              maxLines: 3,
            ),
          ],
        ),
      ),
      StudioSectionCard(
        title: "Classification",
        subtitle: "Brand, department and category mapping",
        icon: Icons.account_tree_outlined,
        accentColor: colors.accentPurple,
        child: Wrap(
          spacing: 20, runSpacing: 20,
          children: [
            ZenoTextField(
              key: const ValueKey('brand'),
              label: "Principal Brand",
              initialValue: p.brand,
              onChanged: (v) => controller.updateField(brand: v),
              width: ZenoFieldWidth.medium,
            ),
            ZenoTextField(
              key: const ValueKey('category'),
              label: "Category / Department",
              initialValue: p.category,
              onChanged: (v) => controller.updateField(category: v),
              width: ZenoFieldWidth.medium,
            ),
            ZenoTextField(
              key: const ValueKey('returnPolicy'),
              label: "Return Policy",
              initialValue: p.returnPolicy,
              onChanged: (v) => controller.updateField(returnPolicy: v),
              width: ZenoFieldWidth.medium,
            ),
          ],
        ),
      ),
    ]);
  }
}
