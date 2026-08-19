import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _fashionSmall = [
  ProductStudioSection.fashionBasic,
  ProductStudioSection.fashionSpecs,
  ProductStudioSection.variants,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.marketing,
  ProductStudioSection.advanced,
];

final List<ProductStudioSection> _fashionGrowing = [
  ..._fashionSmall,
  ProductStudioSection.retailWms,
  ProductStudioSection.retailReplenishment,
  ProductStudioSection.retailPromotions,
  ProductStudioSection.retailOmnichannel,
  ProductStudioSection.fashionReturns,
];

final List<ProductStudioSection> _fashionEnterprise = [
  ..._fashionGrowing,
  ProductStudioSection.retailPricingEnterprise,
  ProductStudioSection.retailStoreOverrides,
  ProductStudioSection.fashionSizeCurve,
  ProductStudioSection.fashionMarkdown,
  ProductStudioSection.fashionMerchandising,
];

List<ProductStudioSection> getFashionCapabilities(BusinessScale scale) {
  switch (scale) {
    case BusinessScale.small: return _fashionSmall;
    case BusinessScale.growing: return _fashionGrowing;
    case BusinessScale.enterprise: return _fashionEnterprise;
  }
}

final Map<String, List<ProductStudioSection>> fashionCapabilities = {
  "Shoes": _fashionSmall,
  "Clothing": _fashionSmall,
  "Boutique": _fashionSmall,
  "Jewelry": _fashionSmall,
  "Cosmetics": _fashionSmall,
  "Perfume": _fashionSmall,
  "Watch Store": _fashionSmall,
  "Eyewear / Opticals": _fashionSmall,
  "Bags & Luggage": _fashionSmall,
  "Accessories": _fashionSmall,
  "Innerwear": _fashionSmall,
  "Bridal Wear": _fashionSmall,
  "Kids Fashion": _fashionSmall,
  "Sportswear": _fashionSmall,
};
