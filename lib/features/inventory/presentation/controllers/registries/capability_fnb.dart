import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _standardFNB = [
  ProductStudioSection.fnbDish,
  ProductStudioSection.fnbKitchen,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.marketing,
  ProductStudioSection.advanced,
];

final Map<String, List<ProductStudioSection>> fnbCapabilities = {
  "Bakery": _standardFNB,
  "Restaurant": _standardFNB,
  "Cafe": _standardFNB,
  "Fast Food": _standardFNB,
  "Hotel": _standardFNB,
  "Cloud Kitchen": _standardFNB,
  "Food Court": _standardFNB,
  "Juice Shop": _standardFNB,
  "Sweet Shop": _standardFNB,
  "Bar & Pub": _standardFNB,
};
