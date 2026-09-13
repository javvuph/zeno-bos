import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _standardRetail = [
  ProductStudioSection.basic,
  ProductStudioSection.retailPackaging,
  ProductStudioSection.packaging,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.advanced,
];

final List<ProductStudioSection> _enterpriseRetail = [
  ProductStudioSection.basic,
  ProductStudioSection.retailPackaging,
  ProductStudioSection.retailWms,
  ProductStudioSection.retailPromotions,
  ProductStudioSection.retailProcurement,
  ProductStudioSection.retailReplenishment,
  ProductStudioSection.retailOmnichannel,
  ProductStudioSection.retailMerchandising,
  ProductStudioSection.retailPricingEnterprise,
  ProductStudioSection.retailStoreOverrides,
  ProductStudioSection.packaging,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.marketing,
  ProductStudioSection.advanced,
];

final List<ProductStudioSection> _freshRetail = [
  ProductStudioSection.basic,
  ProductStudioSection.retailPackaging,
  ProductStudioSection.retailColdChain,
  ProductStudioSection.retailTraceability,
  ProductStudioSection.packaging,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.batch,
  ProductStudioSection.expiry,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.advanced,
];

final Map<String, List<ProductStudioSection>> retailCapabilities = {
  "Grocery": _standardRetail,
  "Supermarket": _enterpriseRetail,
  "Hypermarket": _enterpriseRetail,
  "Mini Market": _standardRetail,
  "Convenience Store": _standardRetail,
  "Departmental Store": _enterpriseRetail,
  "Organic Store": _freshRetail,
  "Gift Shop": _standardRetail,
  "Duty Free Shop": _enterpriseRetail,
  "Liquor Store": _standardRetail,
  "Tobacco Shop": _standardRetail,
  "General Store": _standardRetail,
  "Kiosk": _standardRetail,
  "Pop-up Store": _standardRetail,
  "Fresh Produce": _freshRetail,
  "Butchery": _freshRetail,
  "Fish & Seafood": _freshRetail,
  "Dairy Booth": _freshRetail,
};
