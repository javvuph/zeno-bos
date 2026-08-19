enum FashionSubBusiness {
  clothing, footwear, jewelry, watches, eyewear, cosmetics, perfume, boutique, bridalWear, bagsLuggage, accessories, innerwear, kidsFashion, sportswear,
}

class FashionCategoryConfig {
  final String tabTitle;
  final String axis1Name;
  final List<String> defaultAxis1Options;
  final String axis2Name;
  final List<String> defaultAxis2Options;
  final String defaultHsnCode;

  const FashionCategoryConfig({
    required this.tabTitle,
    required this.axis1Name,
    required this.defaultAxis1Options,
    required this.axis2Name,
    required this.defaultAxis2Options,
    required this.defaultHsnCode,
  });
}

final Map<FashionSubBusiness, FashionCategoryConfig> fashionConfigMap = {
  FashionSubBusiness.footwear: const FashionCategoryConfig(
    tabTitle: 'FOOTWEAR SPECS', axis1Name: 'Footwear Size', defaultAxis1Options: ['UK 6', '7', '8', '9', '10', '11', '12'],
    axis2Name: 'Color', defaultAxis2Options: [], defaultHsnCode: '6404',
  ),
  FashionSubBusiness.clothing: const FashionCategoryConfig(
    tabTitle: 'GARMENT SPECS', axis1Name: 'Size', defaultAxis1Options: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    axis2Name: 'Color', defaultAxis2Options: [], defaultHsnCode: '6205',
  ),
  FashionSubBusiness.jewelry: const FashionCategoryConfig(
    tabTitle: 'JEWELRY & METALS', axis1Name: 'Purity / Karat', defaultAxis1Options: ['24K', '22K', '18K', '14K', '925 Silver'],
    axis2Name: 'Size / Length', defaultAxis2Options: [], defaultHsnCode: '7113',
  ),
  FashionSubBusiness.watches: const FashionCategoryConfig(
    tabTitle: 'WATCH SPECS', axis1Name: 'Dial Color', defaultAxis1Options: [],
    axis2Name: 'Strap Material', defaultAxis2Options: ['Leather', 'Steel', 'Silicone'], defaultHsnCode: '9102',
  ),
  FashionSubBusiness.eyewear: const FashionCategoryConfig(
    tabTitle: 'OPTICAL SPECS', axis1Name: 'Frame Color', defaultAxis1Options: [],
    axis2Name: 'Lens Type', defaultAxis2Options: ['Zero Power', 'Polarized', 'Blue-Cut'], defaultHsnCode: '9003',
  ),
  FashionSubBusiness.cosmetics: const FashionCategoryConfig(
    tabTitle: 'COSMETICS SPECS', axis1Name: 'Shade / Tone', defaultAxis1Options: [],
    axis2Name: 'Net Volume / Size', defaultAxis2Options: ['3.5g', '15ml', '30ml'], defaultHsnCode: '3304',
  ),
  FashionSubBusiness.perfume: const FashionCategoryConfig(
    tabTitle: 'FRAGRANCE SPECS', axis1Name: 'Bottle Volume', defaultAxis1Options: ['30ml', '50ml', '100ml', '200ml'],
    axis2Name: 'Concentration', defaultAxis2Options: ['EDP', 'EDT', 'Parfum'], defaultHsnCode: '3303',
  ),
  FashionSubBusiness.boutique: const FashionCategoryConfig(
    tabTitle: 'BOUTIQUE & COUTURE', axis1Name: 'Fit / Size', defaultAxis1Options: ['Bespoke', 'S', 'M', 'L'],
    axis2Name: 'Color Theme', defaultAxis2Options: [], defaultHsnCode: '6204',
  ),
  FashionSubBusiness.bridalWear: const FashionCategoryConfig(
    tabTitle: 'BRIDAL & COUTURE', axis1Name: 'Couture Size', defaultAxis1Options: ['Custom Made'],
    axis2Name: 'Color Theme', defaultAxis2Options: [], defaultHsnCode: '6204',
  ),
  FashionSubBusiness.bagsLuggage: const FashionCategoryConfig(
    tabTitle: 'LUGGAGE & BAGS', axis1Name: 'Luggage Size / Capacity', defaultAxis1Options: ['Cabin 20"', 'Check-in 28"', '25L'],
    axis2Name: 'Color', defaultAxis2Options: [], defaultHsnCode: '4202',
  ),
  FashionSubBusiness.accessories: const FashionCategoryConfig(
    tabTitle: 'ACCESSORY SPECS', axis1Name: 'Standard Size', defaultAxis1Options: ['Free Size', '32', '34', '36'],
    axis2Name: 'Finish / Color', defaultAxis2Options: [], defaultHsnCode: '6217',
  ),
  FashionSubBusiness.innerwear: const FashionCategoryConfig(
    tabTitle: 'INNERWEAR SPECS', axis1Name: 'Cup / Waist Size', defaultAxis1Options: ['32B', '34C', 'S', 'M', 'L'],
    axis2Name: 'Pack Size', defaultAxis2Options: ['Single', '3-Pack'], defaultHsnCode: '6212',
  ),
  FashionSubBusiness.kidsFashion: const FashionCategoryConfig(
    tabTitle: 'KIDS APPAREL', axis1Name: 'Age Slab', defaultAxis1Options: ['0-3M', '3-6M', '1-2Y', '3-4Y', '5-6Y'],
    axis2Name: 'Color', defaultAxis2Options: [], defaultHsnCode: '6209',
  ),
  FashionSubBusiness.sportswear: const FashionCategoryConfig(
    tabTitle: 'ACTIVEWEAR SPECS', axis1Name: 'Athletic Size', defaultAxis1Options: ['XS', 'S', 'M', 'L', 'XL'],
    axis2Name: 'Color', defaultAxis2Options: [], defaultHsnCode: '6211',
  ),
};

FashionSubBusiness getFashionSubBusiness(String category) {
  if (category.contains("Shoes") || category.contains("Footwear")) return FashionSubBusiness.footwear;
  if (category.contains("Jewelry")) return FashionSubBusiness.jewelry;
  if (category.contains("Watches")) return FashionSubBusiness.watches;
  if (category.contains("Eyewear")) return FashionSubBusiness.eyewear;
  if (category.contains("Cosmetics")) return FashionSubBusiness.cosmetics;
  if (category.contains("Perfume")) return FashionSubBusiness.perfume;
  if (category.contains("Boutique")) return FashionSubBusiness.boutique;
  if (category.contains("Bridal")) return FashionSubBusiness.bridalWear;
  if (category.contains("Bags") || category.contains("Luggage")) return FashionSubBusiness.bagsLuggage;
  if (category.contains("Innerwear")) return FashionSubBusiness.innerwear;
  if (category.contains("Kids")) return FashionSubBusiness.kidsFashion;
  if (category.contains("Sportswear")) return FashionSubBusiness.sportswear;
  if (category.contains("Accessory")) return FashionSubBusiness.accessories;
  return FashionSubBusiness.clothing;
}
