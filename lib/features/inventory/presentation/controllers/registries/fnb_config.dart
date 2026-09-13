enum FnbCategory {
  restaurant,
  cafe,
  bakery,
  juiceShop,
  fastFood,
  cloudKitchen,
  sweetShop,
  barPub,
}

enum FnbOperationalProfile {
  fineDining,
  casualDining,
  pizzeria,
  cafeBarista,
  bakeryPastry,
  juiceBeverage,
  expressQsr,
  cloudDelivery,
  iceCreamDessert,
  mithaiSweets,
  barMixology,
  banquetCatering,
  shishaLounge,
}

class FnbCategoryConfig {
  final String tabTitle;
  final String defaultKotStation;
  final bool requiresAgeGate;
  final bool hasBom;
  final String defaultCourse;
  final String suggestedTaxClassification;

  const FnbCategoryConfig({
    required this.tabTitle,
    required this.defaultKotStation,
    this.requiresAgeGate = false,
    this.hasBom = true,
    required this.defaultCourse,
    required this.suggestedTaxClassification,
  });
}

final Map<FnbOperationalProfile, FnbCategoryConfig> fnbConfigMap = {
  FnbOperationalProfile.fineDining: const FnbCategoryConfig(
    tabTitle: 'FINE DINING SPECS',
    defaultKotStation: 'Main Kitchen',
    defaultCourse: 'Main Course',
    suggestedTaxClassification: 'Luxury / Fine Dining',
  ),
  FnbOperationalProfile.casualDining: const FnbCategoryConfig(
    tabTitle: 'KITCHEN & RECIPE',
    defaultKotStation: 'Main Kitchen',
    defaultCourse: 'Main Course',
    suggestedTaxClassification: 'Standard Restaurant',
  ),
  FnbOperationalProfile.pizzeria: const FnbCategoryConfig(
    tabTitle: 'PIZZA SPECS',
    defaultKotStation: 'Oven/Pizza',
    defaultCourse: 'Main Course',
    suggestedTaxClassification: 'Fast Food',
  ),
  FnbOperationalProfile.cafeBarista: const FnbCategoryConfig(
    tabTitle: 'CAFE / BARISTA SPECS',
    defaultKotStation: 'Barista Counter',
    defaultCourse: 'Beverage',
    suggestedTaxClassification: 'Cafe',
  ),
  FnbOperationalProfile.bakeryPastry: const FnbCategoryConfig(
    tabTitle: 'BAKERY SPECS',
    defaultKotStation: 'Pastry Kitchen',
    defaultCourse: 'Dessert',
    suggestedTaxClassification: 'Bakery',
  ),
  FnbOperationalProfile.juiceBeverage: const FnbCategoryConfig(
    tabTitle: 'JUICE & BEVERAGE',
    defaultKotStation: 'Juice Bar',
    defaultCourse: 'Beverage',
    suggestedTaxClassification: 'Beverage',
  ),
  FnbOperationalProfile.expressQsr: const FnbCategoryConfig(
    tabTitle: 'EXPRESS QSR SPECS',
    defaultKotStation: 'Expedite',
    defaultCourse: 'Main Course',
    suggestedTaxClassification: 'Fast Food',
  ),
  FnbOperationalProfile.cloudDelivery: const FnbCategoryConfig(
    tabTitle: 'CLOUD DELIVERY SPECS',
    defaultKotStation: 'Packing Station',
    defaultCourse: 'Main Course',
    suggestedTaxClassification: 'Delivery Only',
  ),
  FnbOperationalProfile.iceCreamDessert: const FnbCategoryConfig(
    tabTitle: 'ICE CREAM SPECS',
    defaultKotStation: 'Dessert Counter',
    defaultCourse: 'Dessert',
    suggestedTaxClassification: 'Dessert',
  ),
  FnbOperationalProfile.mithaiSweets: const FnbCategoryConfig(
    tabTitle: 'MITHAI SPECS',
    defaultKotStation: 'Halwai Kitchen',
    defaultCourse: 'Dessert',
    suggestedTaxClassification: 'Sweets',
  ),
  FnbOperationalProfile.barMixology: const FnbCategoryConfig(
    tabTitle: 'BAR & PUB SPECS',
    defaultKotStation: 'Bar',
    requiresAgeGate: true,
    defaultCourse: 'Beverage',
    suggestedTaxClassification: 'Alcoholic Beverage',
  ),
  FnbOperationalProfile.banquetCatering: const FnbCategoryConfig(
    tabTitle: 'BANQUET SPECS',
    defaultKotStation: 'Banquet Kitchen',
    defaultCourse: 'Multi-Course',
    suggestedTaxClassification: 'Catering',
  ),
  FnbOperationalProfile.shishaLounge: const FnbCategoryConfig(
    tabTitle: 'SHISHA SPECS',
    defaultKotStation: 'Shisha Bar',
    requiresAgeGate: true,
    defaultCourse: 'Tobacco',
    suggestedTaxClassification: 'Tobacco/Shisha',
  ),
};

FnbOperationalProfile getFnbOperationalProfile(String category, String profile) {
  // Logic to map business category and operational profile strings to enums
  if (profile == "Fine Dining") return FnbOperationalProfile.fineDining;
  if (profile == "Pizzeria") return FnbOperationalProfile.pizzeria;
  if (profile == "Espresso Bar" || profile == "Bakery Cafe" || profile == "Artisan Brew") return FnbOperationalProfile.cafeBarista;
  if (profile == "Custom Cakes" || profile == "Pastry & Confectionery" || profile == "Bread & Savory") return FnbOperationalProfile.bakeryPastry;
  if (profile == "Cold-Pressed Juice" || profile == "Smoothie & Shake Bar") return FnbOperationalProfile.juiceBeverage;
  if (profile == "Express QSR" || profile == "Food Truck") return FnbOperationalProfile.expressQsr;
  if (profile == "Multi-Brand Virtual Kitchen" || profile == "Meal-Prep Delivery") return FnbOperationalProfile.cloudDelivery;
  if (profile == "Ice Cream & Gelato") return FnbOperationalProfile.iceCreamDessert;
  if (profile == "Traditional Mithai") return FnbOperationalProfile.mithaiSweets;
  if (profile == "Cocktail Lounge" || profile == "Microbrewery" || profile == "Sports Bar") return FnbOperationalProfile.barMixology;
  if (profile == "Banquet/Catering") return FnbOperationalProfile.banquetCatering;
  if (profile == "Shisha Lounge") return FnbOperationalProfile.shishaLounge;
  return FnbOperationalProfile.casualDining;
}
