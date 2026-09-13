import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/registries/fashion_config.dart';
import '../../widgets/product_studio_tabs.dart';
import 'fashion_basic_tab.dart';
import 'fashion_variants_tab.dart';
import 'fashion_size_curve_tab.dart';
import 'fashion_markdown_tab.dart';
import 'fashion_returns_tab.dart';
import 'fashion_merchandising_tab.dart';
import 'specs/footwear_specs_tab.dart';
import 'specs/garment_specs_tab.dart';
import 'specs/jewelry_specs_tab.dart';
import 'specs/watches_specs_tab.dart';
import 'specs/eyewear_specs_tab.dart';
import 'specs/cosmetics_specs_tab.dart';
import 'specs/perfume_specs_tab.dart';
import 'specs/boutique_specs_tab.dart';
import 'specs/luggage_specs_tab.dart';
import '../inventory_price_pillar.dart';
import '../retail/retail_wms_tab.dart';
import '../retail/retail_promotions_tab.dart';
import '../retail/retail_procurement_tab.dart';
import '../retail/retail_omnichannel_tab.dart';
import '../retail/retail_replenishment_tab.dart';
import '../retail/retail_pricing_enterprise_tab.dart';
import '../retail/retail_store_overrides_tab.dart';
import '../suppliers_section.dart';
import '../tax_section.dart';
import '../media_pillar.dart';
import '../marketing_section.dart';
import '../advanced_section.dart';

class FashionWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final Widget Function(ZenoSemanticColors) buildStickyFooter;
  const FashionWorkstation({super.key, required this.controller, required this.colors, required this.buildStickyFooter});

  @override
  Widget build(BuildContext context) {
    final sub = getFashionSubBusiness(controller.product.businessCategory);
    final config = fashionConfigMap[sub]!;
    return Container(
      color: colors.bgTier1,
      child: Column(children: [
        ProductStudioTabs(controller: controller, profileTitle: config.tabTitle),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: _buildActiveTab(sub, config),
          ),
        ),
        buildStickyFooter(colors),
      ]),
    );
  }

  Widget _buildActiveTab(FashionSubBusiness sub, FashionCategoryConfig config) {
    switch (controller.activeSection) {
      case ProductStudioSection.fashionBasic: return FashionBasicTab(controller: controller, colors: colors);
      case ProductStudioSection.fashionSpecs: return _getSpecTab(sub);
      case ProductStudioSection.variants: return FashionVariantsTab(controller: controller, colors: colors, config: config);
      case ProductStudioSection.inventoryPrice: return InventoryPricePillar(controller: controller, colors: colors);
      case ProductStudioSection.retailWms: return RetailWmsTab(controller: controller, colors: colors);
      case ProductStudioSection.retailReplenishment: return RetailReplenishmentTab(controller: controller, colors: colors);
      case ProductStudioSection.retailPromotions: return RetailPromotionsTab(controller: controller, colors: colors);
      case ProductStudioSection.retailProcurement: return RetailProcurementTab(controller: controller, colors: colors);
      case ProductStudioSection.retailOmnichannel: return RetailOmnichannelTab(controller: controller, colors: colors);
      case ProductStudioSection.fashionSizeCurve: return FashionSizeCurveTab(controller: controller, colors: colors);
      case ProductStudioSection.fashionMarkdown: return FashionMarkdownTab(controller: controller, colors: colors);
      case ProductStudioSection.fashionReturns: return FashionReturnsTab(controller: controller, colors: colors);
      case ProductStudioSection.fashionMerchandising: return FashionMerchandisingTab(controller: controller, colors: colors);
      case ProductStudioSection.retailPricingEnterprise: return RetailPricingEnterpriseTab(controller: controller, colors: colors);
      case ProductStudioSection.retailStoreOverrides: return RetailStoreOverridesTab(controller: controller, colors: colors);
      case ProductStudioSection.suppliers: return SuppliersSection(controller: controller, colors: colors);
      case ProductStudioSection.tax: return TaxSection(controller: controller, colors: colors);
      case ProductStudioSection.media: return MediaPillar(controller: controller, colors: colors);
      case ProductStudioSection.marketing: return MarketingSection(controller: controller, colors: colors);
      case ProductStudioSection.advanced: return AdvancedSection(controller: controller, colors: colors);
      default: return FashionBasicTab(controller: controller, colors: colors);
    }
  }

  Widget _getSpecTab(FashionSubBusiness sub) {
    switch (sub) {
      case FashionSubBusiness.footwear: return FootwearSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.clothing:
      case FashionSubBusiness.innerwear:
      case FashionSubBusiness.kidsFashion:
      case FashionSubBusiness.sportswear: return GarmentSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.jewelry: return JewelrySpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.watches: return WatchesSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.eyewear: return EyewearSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.cosmetics: return CosmeticsSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.perfume: return PerfumeSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.boutique:
      case FashionSubBusiness.bridalWear: return BoutiqueSpecsTab(controller: controller, colors: colors);
      case FashionSubBusiness.bagsLuggage:
      case FashionSubBusiness.accessories: return LuggageSpecsTab(controller: controller, colors: colors);
    }
  }
}
