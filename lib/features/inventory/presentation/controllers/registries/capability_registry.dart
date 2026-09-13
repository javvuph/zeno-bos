import '../../../domain/models/product_studio_enums.dart';
import 'capability_fashion.dart';
import 'capability_retail.dart';
import 'capability_fnb.dart';
import 'capability_wholesale.dart';
import 'capability_healthcare.dart';
import 'capability_services.dart';

import 'capability_electronics.dart';

final Map<String, List<ProductStudioSection>> categoryCapabilityRegistry = {
  ...retailCapabilities,
  ...fashionCapabilities,
  ...fnbCapabilities,
  ...wholesaleCapabilities,
  ...healthcareCapabilities,
  ...serviceCapabilities,
  ...electronicsCapabilities,
  "Home Decor": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.variants, ProductStudioSection.industry, ProductStudioSection.tax,
    ProductStudioSection.suppliers, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Fitness": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.variants, ProductStudioSection.tax,
    ProductStudioSection.suppliers, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Cricket": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.industry, ProductStudioSection.tax,
    ProductStudioSection.suppliers, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
};

final Map<String, List<ProductStudioSection>> businessTypeCapabilities = {
  "General / Standard": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Retail": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.unitsConversion, ProductStudioSection.batch,
    ProductStudioSection.expiry, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Food & Beverage": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Fashion": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.variants, ProductStudioSection.tax,
    ProductStudioSection.suppliers, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Healthcare": [
    ProductStudioSection.healthcareBasic, ProductStudioSection.healthcareClinical,
    ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Services": [
    ProductStudioSection.serviceBasic, ProductStudioSection.serviceExecution,
    ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Wholesale": [
    ProductStudioSection.wholesaleBasic, ProductStudioSection.wholesaleB2B,
    ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Electronics": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Furniture": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Hardware": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.unitsConversion, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Automobile": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Agriculture": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.unitsConversion, ProductStudioSection.batch,
    ProductStudioSection.expiry, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Pet Shop": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.batch, ProductStudioSection.expiry, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Stationery": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Book Store": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Toy Store": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.tax, ProductStudioSection.suppliers,
    ProductStudioSection.packaging, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Sports Store": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.variants, ProductStudioSection.tax,
    ProductStudioSection.suppliers, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
  "Home Decor": [
    ProductStudioSection.basic, ProductStudioSection.inventoryPrice, ProductStudioSection.media,
    ProductStudioSection.variants, ProductStudioSection.tax,
    ProductStudioSection.suppliers, ProductStudioSection.marketing, ProductStudioSection.advanced,
  ],
};
