import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _standardHealthcare = [
  ProductStudioSection.healthcareBasic,
  ProductStudioSection.healthcareClinical,
  ProductStudioSection.batch,
  ProductStudioSection.expiry,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.advanced,
];

final Map<String, List<ProductStudioSection>> healthcareCapabilities = {
  "Medical Shop": _standardHealthcare,
  "Pharmacy": _standardHealthcare,
  "Clinic": _standardHealthcare,
  "Dental Clinic": _standardHealthcare,
  "Diagnostics Center": _standardHealthcare,
  "Hospital Supply": _standardHealthcare,
  "Medical Equipment": _standardHealthcare,
  "Ayurvedic Medicine": _standardHealthcare,
  "Homeopathy Store": _standardHealthcare,
  "Health Supplements": _standardHealthcare,
  "Optical Clinic": _standardHealthcare,
  "Surgical & Orthopedic": _standardHealthcare,
  "Veterinary": _standardHealthcare,
  "Specialty / Cold Chain": _standardHealthcare,
};
