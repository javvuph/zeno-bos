import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _standardWholesale = [
  ProductStudioSection.wholesaleBasic, ProductStudioSection.wholesaleB2B,
  ProductStudioSection.inventoryPrice, ProductStudioSection.suppliers,
  ProductStudioSection.tax, ProductStudioSection.media,
  ProductStudioSection.marketing, ProductStudioSection.advanced,
];

final Map<String, List<ProductStudioSection>> wholesaleCapabilities = {
  "General Wholesale": _standardWholesale,
  "Food Wholesale": _standardWholesale,
  "Grocery Wholesale": _standardWholesale,
  "Garment Wholesale": _standardWholesale,
  "Footwear Wholesale": _standardWholesale,
  "Electronics Wholesale": _standardWholesale,
  "Hardware Wholesale": _standardWholesale,
  "Building Materials Wholesale": _standardWholesale,
  "Medical Wholesale": _standardWholesale,
  "Industrial Wholesale": _standardWholesale,
  "FMCG Wholesale": _standardWholesale,
  "Electrical Wholesale": _standardWholesale,
  "Textile Wholesale": _standardWholesale,
  "Plastic Products Wholesale": _standardWholesale,
};
