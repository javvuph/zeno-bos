import '../../../domain/models/product_studio_enums.dart';

/// ---------------------------------------------------------------
/// UNIVERSAL FIELDS
/// ---------------------------------------------------------------
final List<String> retailStandard = [
  "title", "arabicTitle", "description", "barcode", "multiBarcodes", "barcodeType", "sku",
  "posShortThermalName", "eslId", "productClassification", "brandType", "brand", "category",
  "subDepartment", "returnPolicy", "taxCode", "productLifecycleStatus", "effectiveDate",
  "discontinueDate", "countryOfOrigin", "manufacturerName", "isQuickPOSSale",
];

final List<String> fnbStandard = [
  "title", "arabicTitle", "description", "sku", "barcode", "posShortThermalName", "category",
  "fineDiningCourse", "foodClass", "spiceLevel", "prepTime", "featuredProduct",
  "packagingSurcharge", "taxCode", "isCombo", "isQuickPOSSale", "returnPolicy",
  "productLifecycleStatus", "effectiveDate", "discontinueDate",
];

final List<String> fashionStandard = [
  "title", "description", "brand", "sku", "barcode", "gender", "targetAgeGroup",
  "countryOfOrigin", "season", "collectionEdition", "taxCode", "rfidTagId",
  "returnPolicy", "status", "productLifecycleStatus", "effectiveDate", "discontinueDate",
  "isQuickPOSSale",
];

final List<String> healthcareStandard = [
  "title", "genericSalt", "brand", "potency", "dosageForm", "sku", "barcode",
  "healthLicense", "unit", "unitsPerStrip", "stripsPerBox", "prescriptionClass",
  "allowLooseBilling", "taxCode",
];

/// ---------------------------------------------------------------
/// ENTERPRISE / INVENTORY / PRICING FIELDS
/// ---------------------------------------------------------------
final List<String> retailEnterpriseFields = [
  "costPrice", "purchaseCost", "landedCost", "sellingPrice", "mrp", "wholesalePrice",
  "minimumFloorPrice", "targetMarginPct", "targetMarkupPct", "promoDiscount",
  "cashierDiscountOverride", "maxCashierDiscountPct", "loyaltyMultiplier",
  "branchStorePrice", "zoneTier", "priceActivationBatchId", "scheduledStartDate",
  "scheduledEndDate",
  "trackInventory", "valuation", "primaryWarehouse", "warehouseLocation", "openingStock",
  "currentOnHand", "allocatedBopis", "safetyStock", "reorderLevel", "maxShelfCapacity",
  "leadTimeBuffer", "moq", "autoReplenish", "quarantineStock", "damagedStock",
  "inTransitStock", "spoilagePct", "breakagePct", "returnToVendor", "wastageReasonCode",
  "scrapAccount", "writeOffApprovalTier",
  "purchaseUnit", "sellingUnit", "stockUnit", "baseUom", "uomConversion", "conversionFactor",
  "innerPackQuantity", "caseMultiplier", "masterCaseMultiplier", "palletMultiplier",
  "packaging", "grossWeight", "netWeight", "unitDimensions",
  "primarySupplierId", "supplierSku", "contractCost", "supplierMoq", "supplierLeadTime",
  "deliverySchedule", "backupSupplier1", "backupSupplier2", "sourcingSplitPct",
  "paymentCreditTerms", "purchasePackUom", "incoterms",
  "taxStatus", "primaryHsnSac", "gstVatRate", "regionalSurchargeCess", "taxInclusiveExclusive",
  "taxCategoryRule", "legalMetrologyDeclaration", "licenseDisplay", "mrpMandate",
  "consumerCareContact", "regulatoryBatchText",
  "showOnPos", "showOnApp", "showOnWeb", "quickCommerce", "b2bPortal", "marketplace",
  "heroImage", "gallery", "posIcon", "zoomAsset", "video", "asset360",
  "seoTitle", "metaDescription", "canonicalUrlSlug", "keywords", "searchPriority",
  "featureHighlights", "eslTagId", "displayTemplateId", "lastSyncTime", "nfcBeaconId",
  "batteryLevel", "createdBy", "createdTimestamp", "lastModifiedBy", "lastModifiedTimestamp",
  "revisionVersion", "cryptographicAuditHash",
];

const List<String> retailCanonicalProfiles = [
  "Hypermarket", "Supermarket", "Grocery / Kirana", "Mini Market", "Fresh Produce",
  "Butchery & Meat", "Fish & Seafood", "Organic Store", "Liquor & Wine",
  "Tobacco Store", "Duty Free", "Convenience Store", "Department Store", "Dairy Booth",
];

const List<String> fnbCanonicalProfiles = [
  "Fine Dining", "Casual Dining", "Express QSR", "Cloud Delivery", "Bakery & Pastry",
  "Cafe / Barista", "Juice & Beverage", "Pizzeria", "Bar & Pub", "Ice Cream & Gelato",
  "Sweet Shop / Mithai", "Banquet & Catering", "Shisha Lounge",
];

const List<String> fashionCanonicalProfiles = [
  "Clothing", "Footwear", "Jewelry & Metals", "Watches", "Eyewear", "Cosmetics",
  "Perfume", "Boutique", "Bridal Wear", "Bags & Luggage", "Accessories", "Innerwear",
  "Kids Fashion", "Sportswear",
];

final Map<String, String> canonicalProfileAliases = {
  "Grocery": "Grocery / Kirana", "Kirana": "Grocery / Kirana", "Cafe": "Cafe / Barista",
  "Bakery": "Bakery & Pastry", "Coffee Shop": "Cafe / Barista", "Footwear / Shoes": "Footwear",
  "Shoes": "Footwear", "Watch Store": "Watches", "Eyewear / Opticals": "Eyewear",
  "Jewelry": "Jewelry & Metals", "Departmental Store": "Department Store",
  "Liquor Store": "Liquor & Wine", "Tobacco Shop": "Tobacco Store", "Duty Free Shop": "Duty Free",
  "Restaurant": "Casual Dining", "Fast Food": "Express QSR", "Cloud Kitchen": "Cloud Delivery",
  "Ice Cream Parlor": "Ice Cream & Gelato", "Sweet Shop": "Sweet Shop / Mithai",
  "Mithai": "Sweet Shop / Mithai", "Bar / Pub": "Bar & Pub", "Fashion": "Clothing",
};

String resolveCanonicalProfile(String profile, {String? fallback}) {
  final value = profile.trim();
  if (value.isEmpty) return fallback ?? "";
  return canonicalProfileAliases[value] ?? value;
}

final Map<BusinessScale, List<String>> scaleFieldRegistry = {
  BusinessScale.small: [],
  BusinessScale.growing: [
    "warehouseLocation",
    "reorderLevel",
    "safetyStock",
    "min_reorder_level",
    "preferred_supplier",
    "branch_transfer_flag",
  ],
  BusinessScale.enterprise: [
    "warehouseLocation",
    "reorderLevel",
    "safetyStock",
    "floorZone",
    "planogramId",
    "palletStacking",
    "unitDimensions",
    "grossWeight",
    "min_reorder_level",
    "preferred_supplier",
    "branch_transfer_flag",
    "bin_location",
    "rack_number",
    "secondary_barcode",
    "approval_tier",
  ],
};

final Map<String, String> fieldLabels = {
  "title": "PRODUCT NAME", "arabicTitle": "ARABIC NAME", "description": "DESCRIPTION",
  "barcode": "BARCODE/GTIN", "multiBarcodes": "SECONDARY BARCODES", "barcodeType": "BARCODE TYPE",
  "sku": "SKU", "brand": "BRAND", "category": "CATEGORY", "subDepartment": "SUB-CATEGORY",
  "taxCode": "HSN/TAX CODE", "gender": "GENDER", "season": "SEASON", "material": "MATERIAL",
  "costPrice": "COST PRICE", "purchaseCost": "PURCHASE COST", "landedCost": "LANDED COST",
  "sellingPrice": "SALE PRICE", "mrp": "MRP", "wholesalePrice": "WHOLESALE",
  "minimumFloorPrice": "MINIMUM FLOOR PRICE", "targetMarginPct": "TARGET MARGIN %",
  "targetMarkupPct": "TARGET MARKUP %", "openingStock": "OPENING STOCK",
  "currentOnHand": "CURRENT STOCK", "safetyStock": "SAFETY STOCK", "reorderLevel": "REORDER LEVEL",
  "warehouseLocation": "LOCATION", "primaryWarehouse": "PRIMARY WAREHOUSE",
  "primarySupplierId": "PRIMARY SUPPLIER", "supplierSku": "SUPPLIER SKU",
  "genericSalt": "GENERIC/SALT", "dosageForm": "DOSAGE FORM", "potency": "STRENGTH",
  "healthLicense": "DRUG LICENSE", "prescriptionClass": "RX CLASS", "kotStation": "KOT STATION",
  "foodClass": "FOOD CLASS", "prepTime": "PREP TIME", "swiggySku": "SWIGGY SKU",
  "zomatoSku": "ZOMATO SKU", "aggregatorSku": "AGGREGATOR SKU", "imei": "IMEI",
  "serialNumber": "SERIAL", "collectionEdition": "COLLECTION", "countryOfOrigin": "ORIGIN",
  "status": "STATUS", "freshnessDuration": "FRESHNESS DAYS", "freshnessUnit": "FRESHNESS UNIT",
  "coldStorageIndicator": "COLD STORAGE REQ", "palletStacking": "PALLET MULTIPLIER",
  "grossWeight": "GROSS WEIGHT", "netWeight": "NET WEIGHT", "unitDimensions": "SHELF DIMENSIONS",
  "effectiveDate": "EFFECTIVE DATE", "discontinueDate": "DISCONTINUE DATE",
  "manufacturerName": "MANUFACTURER", "seoTitle": "SEO TITLE", "metaDescription": "META DESCRIPTION",
  "canonicalUrlSlug": "CANONICAL URL", "keywords": "SEARCH KEYWORDS",
};
