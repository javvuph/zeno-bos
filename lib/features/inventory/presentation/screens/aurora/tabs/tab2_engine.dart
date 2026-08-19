import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/fashion_config.dart';
import '../../workstations/fashion/fashion_variants_tab.dart';
import '../../workstations/fnb/specs/kitchen_recipe_specs_tab.dart';
import '../../workstations/retail/retail_packaging_tab.dart';
import '../../workstations/batch_section.dart';
import '../../workstations/expiry_section.dart';
import '../widgets/aurora_card.dart';

class Tab2Engine extends StatelessWidget {
  final ProductStudioController controller;
  const Tab2Engine({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final bType = controller.product.businessType;

    Widget engine;
    String title = "Engine & Logic";
    String subtitle = "Sector-specific computational workstations";

    if (bType == "Fashion") {
      final sub = getFashionSubBusiness(controller.product.businessCategory);
      final config = fashionConfigMap[sub]!;
      title = "Variant Matrix";
      subtitle = "Cartesian generation of colors and sizes";
      engine = FashionVariantsTab(controller: controller, colors: colors, config: config);
    } else if (bType == "Food & Beverage") {
      title = "Kitchen & Recipe";
      subtitle = "Raw materials and production orchestration";
      engine = KitchenRecipeSpecsTab(controller: controller, colors: colors);
    } else if (bType == "Retail") {
      title = "Packaging & UOM";
      subtitle = "Units of measure and break-bulk rules";
      engine = RetailPackagingTab(controller: controller, colors: colors);
    } else if (bType == "Healthcare") {
      title = "Batch & Expiry";
      subtitle = "FEFO tracking and shelf-life controls";
      engine = Column(children: [
        BatchSection(controller: controller, colors: colors),
        const SizedBox(height: 12),
        ExpirySection(controller: controller, colors: colors),
      ]);
    } else {
      engine = const Center(child: Text("No specialized engine for this profile."));
    }

    return SingleChildScrollView(
      child: AuroraCard(
        title: title,
        subtitle: subtitle,
        icon: Icons.auto_awesome_motion_outlined,
        accentColor: colors.accentPurple,
        child: engine,
      ),
    );
  }
}
