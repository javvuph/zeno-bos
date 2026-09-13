import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/registries/retail_config.dart';
import '../../widgets/product_studio_tabs.dart';
import 'retail_basic_tab.dart';
import 'retail_packaging_tab.dart';
import 'retail_price_tab.dart';
import 'retail_wms_tab.dart';
import 'retail_promotions_tab.dart';
import 'retail_procurement_tab.dart';
import 'retail_omnichannel_tab.dart';
import 'retail_replenishment_tab.dart';
import 'retail_merchandising_tab.dart';
import 'retail_cold_chain_tab.dart';
import 'retail_traceability_tab.dart';
import 'retail_pricing_enterprise_tab.dart';
import 'retail_store_overrides_tab.dart';
import 'specs/hypermarket_specs_tab.dart';
import 'specs/scale_produce_specs_tab.dart';
import 'specs/butchery_specs_tab.dart';
import 'specs/fish_seafood_specs_tab.dart';
import 'specs/organic_specs_tab.dart';
import 'specs/liquor_specs_tab.dart';
import 'specs/tobacco_specs_tab.dart';
import 'specs/duty_free_specs_tab.dart';
import 'specs/convenience_specs_tab.dart';
import 'specs/kirana_repack_specs_tab.dart';
import 'specs/dairy_booth_specs_tab.dart';
import '../suppliers_section.dart';
import '../tax_section.dart';
import '../media_pillar.dart';
import '../marketing_section.dart';
import '../advanced_section.dart';

class RetailWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final Widget Function(ZenoSemanticColors) buildStickyFooter;
  const RetailWorkstation({super.key, required this.controller, required this.colors, required this.buildStickyFooter});

  @override
  Widget build(BuildContext context) {
    final sub = getRetailSubBusiness(controller.product.businessCategory);
    final config = retailConfigMap[sub]!;
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

  Widget _buildActiveTab(RetailSubBusiness sub, RetailCategoryConfig config) {
    switch (controller.activeSection) {
      case ProductStudioSection.basic: return RetailBasicTab(controller: controller, colors: colors);
      case ProductStudioSection.retailPackaging: return _getSpecTab(sub);
      case ProductStudioSection.retailWms: return RetailWmsTab(controller: controller, colors: colors);
      case ProductStudioSection.retailPromotions: return RetailPromotionsTab(controller: controller, colors: colors);
      case ProductStudioSection.retailProcurement: return RetailProcurementTab(controller: controller, colors: colors);
      case ProductStudioSection.retailReplenishment: return RetailReplenishmentTab(controller: controller, colors: colors);
      case ProductStudioSection.retailOmnichannel: return RetailOmnichannelTab(controller: controller, colors: colors);
      case ProductStudioSection.retailMerchandising: return RetailMerchandisingTab(controller: controller, colors: colors);
      case ProductStudioSection.retailPricingEnterprise: return RetailPricingEnterpriseTab(controller: controller, colors: colors);
      case ProductStudioSection.retailStoreOverrides: return RetailStoreOverridesTab(controller: controller, colors: colors);
      case ProductStudioSection.retailColdChain: return RetailColdChainTab(controller: controller, colors: colors);
      case ProductStudioSection.retailTraceability: return RetailTraceabilityTab(controller: controller, colors: colors);
      case ProductStudioSection.packaging: return RetailPackagingTab(controller: controller, colors: colors);
      case ProductStudioSection.inventoryPrice: return RetailPriceTab(controller: controller, colors: colors);
      case ProductStudioSection.suppliers: return SuppliersSection(controller: controller, colors: colors);
      case ProductStudioSection.tax: return TaxSection(controller: controller, colors: colors);
      case ProductStudioSection.media: return MediaPillar(controller: controller, colors: colors);
      case ProductStudioSection.marketing: return MarketingSection(controller: controller, colors: colors);
      case ProductStudioSection.advanced: return AdvancedSection(controller: controller, colors: colors);
      default: return RetailBasicTab(controller: controller, colors: colors);
    }
  }

  Widget _getSpecTab(RetailSubBusiness sub) {
    switch (sub) {
      case RetailSubBusiness.freshProduce: return ScaleProduceSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.butcheryMeat: return ButcherySpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.fishSeafood: return FishSeafoodSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.organicStore: return OrganicSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.liquorWine: return LiquorSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.tobaccoStore: return TobaccoSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.dutyFree: return DutyFreeSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.convenienceStore: return ConvenienceSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.groceryKirana: return KiranaRepackSpecsTab(controller: controller, colors: colors);
      case RetailSubBusiness.dairyBooth: return DairyBoothSpecsTab(controller: controller, colors: colors);
      default: return HypermarketSpecsTab(controller: controller, colors: colors);
    }
  }
}
