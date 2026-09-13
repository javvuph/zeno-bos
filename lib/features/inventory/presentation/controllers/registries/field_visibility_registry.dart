import '../../../domain/models/product_studio_enums.dart';

final List<String> retailStandard = [
  "title", "arabicTitle", "description", "barcode", "multiBarcodes", "sku", "posShortThermalName",
  "barcodeType", "eslId", "productClassification", "brandType", "brand", "category",
  "subDepartment", "returnPolicy", "taxCode", "productLifecycleStatus", "isQuickPOSSale"
];

final List<String> fashionStandard = [
  "title", "arabicTitle", "description", "brand", "subBrand", "manufacturer", "sku", "barcode", "internalBarcode", "vendorSku",
  "gender", "targetAgeGroup", "countryOfOrigin", "season", "collectionEdition", "taxCode", "rfidTagId", "returnPolicy", "status",
  "discountType", "discountValue", "marketingTitle", "urlSlug", "searchKeywords", "metaDescription", "primaryImageUrl", "galleryUrls", "isQuickPOSSale"
];

final List<String> fnbStandard = [
  "title", "arabicTitle", "description", "sku", "posShortThermalName", "category", "fineDiningCourse", "foodClass", "spiceLevel", "prepTime", "featuredProduct", "packagingSurcharge", "taxCode", "isCombo", "isQuickPOSSale"
];

final List<String> healthcareStandard = [
  "title", "genericSalt", "brand", "potency", "dosageForm", "sku", "barcode", "healthLicense", "unit", "unitsPerStrip", "stripsPerBox", "prescriptionClass", "allowLooseBilling", "taxCode"
];

const List<String> retailCanonicalProfiles = [
  "Hypermarket", "Supermarket", "Grocery / Kirana", "Mini Market", "Fresh Produce",
  "Butchery & Meat", "Fish & Seafood", "Organic Store", "Liquor & Wine", "Tobacco Store",
  "Duty Free", "Convenience Store", "Department Store", "Dairy Booth"
];

const List<String> fnbCanonicalProfiles = [
  "Fine Dining", "Casual Dining", "Express QSR", "Cloud Delivery", "Bakery & Pastry",
  "Cafe / Barista", "Juice & Beverage", "Pizzeria", "Bar & Pub", "Ice Cream & Gelato",
  "Sweet Shop / Mithai", "Banquet & Catering", "Shisha Lounge"
];

const List<String> fashionCanonicalProfiles = [
  "Clothing", "Footwear", "Jewelry & Metals", "Watches", "Eyewear", "Cosmetics",
  "Perfume", "Boutique", "Bridal Wear", "Bags & Luggage", "Accessories", "Innerwear",
  "Kids Fashion", "Sportswear"
];

final Map<String, String> canonicalProfileAliases = {
  "Grocery": "Grocery / Kirana",
  "Kirana": "Grocery / Kirana",
  "Cafe": "Cafe / Barista",
  "Bakery": "Bakery & Pastry",
  "Coffee Shop": "Cafe / Barista",
  "Footwear / Shoes": "Footwear",
  "Shoes": "Footwear",
  "Watch Store": "Watches",
  "Eyewear / Opticals": "Eyewear",
  "Jewelry": "Jewelry & Metals",
  "Departmental Store": "Department Store",
  "Liquor Store": "Liquor & Wine",
  "Tobacco Shop": "Tobacco Store",
  "Duty Free Shop": "Duty Free",
  "Restaurant": "Casual Dining",
  "Fast Food": "Express QSR",
  "Cloud Kitchen": "Cloud Delivery",
  "Ice Cream Parlor": "Ice Cream & Gelato",
  "Sweet Shop": "Sweet Shop / Mithai",
  "Mithai": "Sweet Shop / Mithai",
  "Bar / Pub": "Bar & Pub",
  "Fashion": "Clothing",
};

String resolveCanonicalProfile(String profile, {String? fallback}) {
  final value = (profile ?? '').trim();
  if (value.isEmpty) return fallback ?? '';
  return canonicalProfileAliases[value] ?? value;
}

final Map<String, List<String>> categoryFieldRegistry = {
  // Umbrella Parent Categories
  "Retail": retailStandard,
  "Food & Beverage": fnbStandard,
  "F&B": fnbStandard,
  "Fashion": [...fashionStandard, "apparelCategory", "patternDesign", "fitType", "sleeveNeckType", "careGuide", "fabric", "sizeScale", "color", "hex", "childSku", "barcodeRegistry"],
  "Fashion & Apparel": [...fashionStandard, "apparelCategory", "patternDesign", "fitType", "sleeveNeckType", "careGuide", "fabric", "sizeScale", "color", "hex", "childSku", "barcodeRegistry"],
  "Healthcare": healthcareStandard,
  "Services": ["title", "arabicTitle", "description", "category", "serviceProcedureType", "diagnosticCharge", "labRouting", "costPrice", "sellingPrice", "taxCode"],
  "Wholesale": [...retailStandard, "minimumFloorPrice", "wholesalePrice", "tierDiscount"],
  "Supermarket": [...retailStandard, "department", "planogramId", "warehouseLocation", "reorderLevel", "safetyStock", "caseMultiplier"],
  "Hypermarket": [...retailStandard, "department", "floorZone", "planogramId", "warehouseLocation", "reorderLevel", "safetyStock", "caseMultiplier", "palletStacking", "unitDimensions", "grossWeight", "storageClass"],
  "Grocery / Kirana": [...retailStandard, "allowLooseBilling", "purchaseUnit", "weight", "stockUnit", "inHouseRepack", "conversionFactor", "ingredients", "storageClass", "bakeryShelfLife", "countryOfOrigin"],
  "Mini Market": [...retailStandard, "fastMovingFlag", "planogramId", "reorderLevel", "supplierLeadTime"],
  "Convenience Store": [...retailStandard, "planogramId", "readyToEatItem", "ageRestriction", "reorderLevel", "isRoomServiceAvailable"],
  "Department Store": [...retailStandard, "department", "staffCommissionRate", "planogramId"],
  "Organic Store": [...retailStandard, "organicCertification", "organicCertNo", "discontinueDate", "farmTraceabilityId", "countryOfOrigin"],
  "Fresh Produce": [...retailStandard, "pluCode", "styleCategory", "countryOfOrigin", "harvestDate", "isCatchWeight", "freshnessDuration", "freshnessUnit", "coldStorageIndicator", "isLiveMarketPrice", "wastagePct"],
  "Butchery & Meat": [...retailStandard, "fitType", "styleCategory", "countryOfOrigin", "weight", "isCatchWeight", "wastagePct", "hallmarkCert", "storageCondition", "manufacturingDate", "freshnessDuration", "freshnessUnit", "coldStorageIndicator", "compatibility"],
  "Fish & Seafood": [...retailStandard, "patternDesign", "closureType", "countryOfOrigin", "manufacturingDate", "weight", "isCatchWeight", "storageCondition", "freshnessDuration", "freshnessUnit", "coldStorageIndicator", "recipePrepNotes"],
  "Liquor & Wine": [...retailStandard, "barLiquorClass", "abv", "volume", "collectionEdition", "countryOfOrigin", "ssccBarcode", "healthLicense", "posAgeGate", "containerDepositFee"],
  "Tobacco Store": [...retailStandard, "apparelCategory", "unitsPerStrip", "nicotineContent", "ssccBarcode", "posAgeGate", "hallmarkCert", "manufacturerName", "countryOfOrigin"],
  "Duty Free": [...retailStandard, "importDutyClass", "countryOfOrigin", "passportVerificationRequired", "flightNumberRequired", "currency", "onlinePrice"],
  "Dairy Booth": [...retailStandard, "bakeryType", "nutritionalTransFats", "nutritionalProtein", "manufacturingDate", "freshnessDuration", "freshnessUnit", "storageCondition", "coldStorageIndicator", "containerDepositFee"],
  "Fine Dining": [...fnbStandard, "cuisineType", "winePairing", "kotStation", "recipeVersion", "targetFoodCostPct"],
  "Casual Dining": [...fnbStandard, "cuisineType", "kdsCategory", "courseFireDelay", "recipeVersion", "recipePrepNotes", "targetFoodCostPct"],
  "Express QSR": [...fnbStandard, "aggregatorSku", "packaging", "tamperSeal", "oosBehavior", "expressDispatch", "isCombo"],
  "Cloud Delivery": [...fnbStandard, "virtualBrandId", "multiAggregatorSkuMatrix", "packagingContainer", "insulationPack", "stagingShelf"],
  "Bakery & Pastry": [...fnbStandard, "flavor", "cakeSize", "sponge", "storageTemperature", "shelfLife", "customMessage", "photoPrint", "eggless", "bakeryType"],
  "Cafe / Barista": [...fnbStandard, "cupVolume", "extractionMethod", "steamingTemperature", "beanRoast", "origin", "plantMilk", "extraShot"],
  "Juice & Beverage": [...fnbStandard, "volume", "sugar", "ice", "addIns", "coldPressed"],
  "Pizzeria": [...fnbStandard, "size", "crust", "sauce", "cheeseDip", "seasoning"],
  "Bar & Pub": [...fnbStandard, "abv", "pourVolume", "liquorClass", "exciseId", "happyHour", "ageGate"],
  "Ice Cream & Gelato": [...fnbStandard, "base", "servingFormat", "coneCup", "dryIce"],
  "Sweet Shop / Mithai": [...fnbStandard, "sellingMetric", "fatBase", "shelfLife", "storage", "tare"],
  "Banquet & Catering": [...fnbStandard, "minimumPax", "perHeadCost", "serviceSetup", "liveStation", "hotBoxTransport"],
  "Shisha Lounge": [...fnbStandard, "flavor", "baseLiquid", "duration", "disposablePipe", "ageGate"],
  "Clothing": [...fashionStandard, "apparelCategory", "patternDesign", "fitType", "sleeveNeckType", "careGuide", "fabric", "sizeScale", "color", "hex", "childSku", "barcodeRegistry"],
  "Footwear": [...fashionStandard, "material", "soleMaterial", "closureType", "widthFit", "sizeStandard", "apparelCategory", "upper", "outsole", "heel", "toe", "occasion", "pairWeight", "childSku", "barcode"],
  "Jewelry & Metals": [...fashionStandard, "metalType", "purity", "stoneType", "stoneWeight", "gemstoneCount", "hallmarkCert", "makingChargeMode", "makingChargeRate", "wastagePct"],
  "Watches": [...fashionStandard, "material", "closureType", "styleCategory", "movement", "caliber", "case", "diameter", "thickness", "strap", "glass", "waterResistance", "powerReserve"],
  "Eyewear": [...fashionStandard, "styleCategory", "lensIndex", "frameParameters", "shape", "material", "coatings", "rx"],
  "Cosmetics": [...fashionStandard, "shade", "shadeHexColor", "skinType", "periodAfterOpening", "finish", "volumeWeight", "pao", "crueltyFree", "vegan"],
  "Perfume": [...fashionStandard, "fragranceFamily", "concentration", "topNotes", "middleNotes", "baseNotes"],
  "Boutique": [...fashionStandard, "artisanLabel", "madeToOrder", "collectionEdition", "exclusiveSinglePiece", "designer", "measurementProfile", "rfid", "alteration", "graceDays", "trial", "delivery"],
  "Bridal Wear": [...fashionStandard, "artisanLabel", "madeToOrder", "collectionEdition", "fabricComposition", "designer", "embroidery", "measurementLedger", "rfid", "customization", "trial", "delivery"],
  "Bags & Luggage": [...fashionStandard, "apparelCategory", "material", "volume", "style", "capacity", "tsa", "compartments", "laptopSleeve"],
  "Accessories": [...fashionStandard, "material", "styleCategory", "classification", "giftBox"],
  "Innerwear": [...fashionStandard, "material", "apparelCategory", "careGuide", "silhouette", "coverage", "support", "fabricComposition", "antimicrobial", "bandCupMatrix"],
  "Kids Fashion": [...fashionStandard, "targetAgeGroup", "material", "careGuide", "ageGrowth", "closure", "oekoTex", "organicCotton", "nickelFree", "growthSizeGrid", "childSku"],
  "Sportswear": [...fashionStandard, "material", "fitType", "patternDesign", "activity", "compression", "moistureWicking", "stretch", "quickDry", "upf", "antiOdor", "sizeColorMatrix", "childSku"],
  "Medical Shop": [...healthcareStandard, "exemptionReason", "drugLicenseWholesale"],
  "Pharmacy": [...healthcareStandard, "exemptionReason", "drugLicenseWholesale"],
  "Clinic": [...healthcareStandard, "serviceProcedureType", "diagnosticCharge", "labRouting"],
  "Diagnostics Center": [...healthcareStandard, "specimenType", "labRouting", "referenceRange"],
  "Dental Clinic": [...healthcareStandard, "dentalQuadrant", "serviceProcedureType"],
  "Optical Clinic": [...healthcareStandard, "optometrySph", "optometryCyl", "optometryAxis", "optometryBaseCurve"],
  "Hospital Supply": healthcareStandard,
  "Medical Equipment": healthcareStandard,
  "Ayurvedic Medicine": healthcareStandard,
  "Homeopathy Store": healthcareStandard,
  "Health Supplements": healthcareStandard,
  "Mobile & Accessories": ["title", "brand", "sku", "barcode", "serialNumber", "imei", "modelNumber"],
  "Computers & Laptops": ["title", "brand", "sku", "barcode", "serialNumber", "modelNumber"],
  "Car Parts": ["title", "brand", "sku", "barcode", "partNumber", "oemNumber", "compatibility", "vehicleMake", "vehicleModel"],
};

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
  "title": "PRODUCT NAME",
  "arabicTitle": "ARABIC NAME",
  "description": "DESCRIPTION",
  "barcode": "BARCODE/GTIN",
  "sku": "SKU",
  "brand": "BRAND",
  "category": "CATEGORY",
  "subDepartment": "SUB-DEPT",
  "taxCode": "HSN/TAX CODE",
  "gender": "GENDER",
  "season": "SEASON",
  "material": "MATERIAL",
  "costPrice": "COST PRICE",
  "sellingPrice": "SALE PRICE",
  "mrp": "MRP",
  "wholesalePrice": "WHOLESALE",
  "openingStock": "STOCK",
  "safetyStock": "SAFETY STOCK",
  "reorderLevel": "REORDER LEVEL",
  "warehouseLocation": "LOCATION",
  "genericSalt": "GENERIC/SALT",
  "dosageForm": "DOSAGE FORM",
  "potency": "STRENGTH",
  "healthLicense": "DRUG LICENSE",
  "prescriptionClass": "RX CLASS",
  "kotStation": "KOT STATION",
  "foodClass": "FOOD CLASS",
  "prepTime": "PREP TIME",
  "swiggySku": "SWIGGY SKU",
  "zomatoSku": "ZOMATO SKU",
  "imei": "IMEI",
  "serialNumber": "SERIAL",
  "collectionEdition": "COLLECTION",
  "countryOfOrigin": "ORIGIN",
  "status": "STATUS",
  "multiBarcodes": "SECONDARY BARCODES",
  "freshnessDuration": "FRESHNESS DAYS",
  "freshnessUnit": "FRESHNESS UNIT",
  "coldStorageIndicator": "COLD STORAGE REQ",
  "palletStacking": "PALLET MULTIPLIER",
  "grossWeight": "GROSS WEIGHT",
  "unitDimensions": "SHELF DIMENSIONS",
  "internalBarcode": "INTERNAL BARCODE",
  "vendorSku": "VENDOR SKU",
  "subBrand": "SUB BRAND",
  "manufacturer": "MANUFACTURER",
  "discountType": "DISCOUNT TYPE",
  "discountValue": "DISCOUNT VALUE",
  "marketingTitle": "MARKETING TITLE",
  "urlSlug": "URL SLUG",
  "searchKeywords": "KEYWORDS",
  "metaDescription": "META DESCRIPTION",
  "primaryImageUrl": "PRIMARY IMAGE",
  "galleryUrls": "GALLERY",
};
