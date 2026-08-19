import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _standardServices = [
  ProductStudioSection.serviceBasic, ProductStudioSection.serviceExecution,
  ProductStudioSection.inventoryPrice, ProductStudioSection.suppliers,
  ProductStudioSection.tax, ProductStudioSection.media,
  ProductStudioSection.marketing, ProductStudioSection.advanced,
];

final Map<String, List<ProductStudioSection>> serviceCapabilities = {
  "Salon": _standardServices,
  "Spa": _standardServices,
  "Laundry": _standardServices,
  "Repair Center": _standardServices,
  "Dry Cleaning": _standardServices,
  "Tailoring": _standardServices,
  "Printing Service": _standardServices,
  "Courier Service": _standardServices,
  "IT Services": _standardServices,
  "Consultancy": _standardServices,
  "Education / Coaching": _standardServices,
  "Gym / Fitness Center": _standardServices,
};
