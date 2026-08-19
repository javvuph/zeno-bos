import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/registries/fnb_config.dart';
import '../../widgets/product_studio_tabs.dart';
import 'fnb_basic_tab.dart';
import 'fnb_price_tab.dart';
import 'specs/kitchen_recipe_specs_tab.dart';
import 'specs/fine_dining_specs_tab.dart';
import 'specs/cloud_kitchen_specs_tab.dart';
import 'specs/bakery_specs_tab.dart';
import 'specs/cafe_coffee_specs_tab.dart';
import 'specs/juice_beverage_specs_tab.dart';
import 'specs/pizza_specs_tab.dart';
import 'specs/bar_pub_specs_tab.dart';
import 'specs/ice_cream_specs_tab.dart';
import 'specs/sweet_shop_specs_tab.dart';
import 'specs/banquet_specs_tab.dart';
import 'specs/shisha_specs_tab.dart';
import '../suppliers_section.dart';
import '../tax_section.dart';
import '../media_pillar.dart';
import '../marketing_section.dart';
import '../advanced_section.dart';

class FnbWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final Widget Function(ZenoSemanticColors) buildStickyFooter;
  const FnbWorkstation({super.key, required this.controller, required this.colors, required this.buildStickyFooter});

  @override
  Widget build(BuildContext context) {
    final profile = getFnbOperationalProfile(controller.product.businessCategory, controller.product.template);
    final config = fnbConfigMap[profile] ?? fnbConfigMap[FnbOperationalProfile.casualDining]!;
    
    return Container(
      color: colors.bgTier1,
      child: Column(children: [
        ProductStudioTabs(controller: controller, profileTitle: config.tabTitle),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), child: _buildActiveTab(profile))),
        buildStickyFooter(colors),
      ]),
    );
  }

  Widget _buildActiveTab(FnbOperationalProfile profile) {
    switch (controller.activeSection) {
      case ProductStudioSection.fnbDish: return FnbBasicTab(controller: controller, colors: colors);
      case ProductStudioSection.fnbKitchen: return _getSpecTab(profile);
      case ProductStudioSection.inventoryPrice: return FnbPriceTab(controller: controller, colors: colors);
      case ProductStudioSection.suppliers: return SuppliersSection(controller: controller, colors: colors);
      case ProductStudioSection.tax: return TaxSection(controller: controller, colors: colors);
      case ProductStudioSection.media: return MediaPillar(controller: controller, colors: colors);
      case ProductStudioSection.marketing: return MarketingSection(controller: controller, colors: colors);
      case ProductStudioSection.advanced: return AdvancedSection(controller: controller, colors: colors);
      default: return FnbBasicTab(controller: controller, colors: colors);
    }
  }

  Widget _getSpecTab(FnbOperationalProfile profile) {
    switch (profile) {
      case FnbOperationalProfile.fineDining: return FineDiningSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.pizzeria: return PizzaSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.cafeBarista: return CafeCoffeeSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.bakeryPastry: return BakerySpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.juiceBeverage: return JuiceBeverageSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.expressQsr:
      case FnbOperationalProfile.cloudDelivery: return CloudKitchenSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.iceCreamDessert: return IceCreamSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.mithaiSweets: return SweetShopSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.barMixology: return BarPubSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.banquetCatering: return BanquetSpecsTab(controller: controller, colors: colors);
      case FnbOperationalProfile.shishaLounge: return ShishaSpecsTab(controller: controller, colors: colors);
      default: return KitchenRecipeSpecsTab(controller: controller, colors: colors);
    }
  }
}
