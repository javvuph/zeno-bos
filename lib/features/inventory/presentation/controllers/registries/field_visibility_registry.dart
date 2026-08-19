import '../../../domain/models/product_studio_enums.dart';

final List<String> retailStandard = [
  "title", "arabicTitle", "description", "barcode", "multiBarcodes", "sku", "posShortThermalName",
  "barcodeType", "eslId", "productClassification", "brandType", "brand", "category",
  "subDepartment", "returnPolicy", "taxCode", "productLifecycleStatus", "isQuickPOSSale"
];

final List<String> fashionStandard = [
  "title", "description", "brand", "sku", "barcode", "gender", "targetAgeGroup", "countryOfOrigin", "season", "collectionEdition", "taxCode", "rfidTagId", "returnPolicy", "status", "isQuickPOSSale"
];

final List<String> fnbStandard = [
  "title", "arabicTitle", "description", "sku", "posShortThermalName", "category", "fineDiningCourse", "foodClass", "spiceLevel", "prepTime", "featuredProduct", "packagingSurcharge", "taxCode", "isCombo", "isQuickPOSSale"
];

final List<String> healthcareStandard = [
  "title", "genericSalt", "brand", "potency", "dosageForm", "sku", "barcode", "healthLicense", "unit", "unitsPerStrip", "stripsPerBox", "prescriptionClass", "allowLooseBilling", "taxCode"
];

final Map<String, List<String>> categoryFieldRegistry = {
  // Retail
  "Supermarket": [...retailStandard, "department", "planogramId", "warehouseLocation", "reorderLevel", "safetyStock", "caseMultiplier"],
  "Hypermarket": [...retailStandard, "department", "floorZone", "planogramId", "warehouseLocation", "reorderLevel", "safetyStock", "caseMultiplier", "palletStacking", "unitDimensions", "grossWeight", "storageClass"],
  "Grocery": [...retailStandard, "allowLooseBilling", "purchaseUnit", "weight", "stockUnit", "inHouseRepack", "conversionFactor", "ingredients", "storageClass", "bakeryShelfLife", "countryOfOrigin"],
  "Mini Market": [...retailStandard, "fastMovingFlag", "planogramId", "reorderLevel", "supplierLeadTime"],
  "Convenience Store": [...retailStandard, "planogramId", "readyToEatItem", "ageRestriction", "reorderLevel", "isRoomServiceAvailable"],
  "Departmental Store": [...retailStandard, "department", "staffCommissionRate", "planogramId"],
  "Organic Store": [...retailStandard, "organicCertification", "organicCertNo", "discontinueDate", "farmTraceabilityId", "countryOfOrigin"],
  "Fresh Produce": [...retailStandard, "pluCode", "styleCategory", "countryOfOrigin", "harvestDate", "isCatchWeight", "freshnessDuration", "freshnessUnit", "coldStorageIndicator", "isLiveMarketPrice", "wastagePct"],
  "Butchery": [...retailStandard, "fitType", "styleCategory", "countryOfOrigin", "weight", "isCatchWeight", "wastagePct", "hallmarkCert", "storageCondition", "manufacturingDate", "freshnessDuration", "freshnessUnit", "coldStorageIndicator", "compatibility"],
  "Fish & Seafood": [...retailStandard, "patternDesign", "closureType", "countryOfOrigin", "manufacturingDate", "weight", "isCatchWeight", "storageCondition", "freshnessDuration", "freshnessUnit", "coldStorageIndicator", "recipePrepNotes"],
  "Liquor Store": [...retailStandard, "barLiquorClass", "abv", "volume", "collectionEdition", "countryOfOrigin", "ssccBarcode", "healthLicense", "posAgeGate", "containerDepositFee"],
  "Tobacco Shop": [...retailStandard, "apparelCategory", "unitsPerStrip", "nicotineContent", "ssccBarcode", "posAgeGate", "hallmarkCert", "manufacturerName", "countryOfOrigin"],
  "Duty Free Shop": [...retailStandard, "importDutyClass", "countryOfOrigin", "passportVerificationRequired", "flightNumberRequired", "currency", "onlinePrice"],
  "Dairy Booth": [...retailStandard, "bakeryType", "nutritionalTransFats", "nutritionalProtein", "manufacturingDate", "freshnessDuration", "freshnessUnit", "storageCondition", "coldStorageIndicator", "containerDepositFee"],
  "Gift Shop": retailStandard,
  "General Store": retailStandard,
  "Kiosk": retailStandard,
  "Pop-up Store": retailStandard,
  
  // Fashion
  "Shoes": [...fashionStandard, "material", "soleMaterial", "closureType", "widthFit", "sizeStandard", "apparelCategory"],
  "Clothing": [...fashionStandard, "apparelCategory", "patternDesign", "fitType", "sleeveNeckType", "careGuide"],
  "Boutique": [...fashionStandard, "artisanLabel", "madeToOrder", "collectionEdition", "exclusiveSinglePiece"],
  "Jewelry": [...fashionStandard, "metalType", "purity", "stoneType", "stoneWeight", "gemstoneCount", "hallmarkCert", "makingChargeMode", "makingChargeRate", "wastagePct"],
  "Watch Store": [...fashionStandard, "material", "closureType", "soleMaterial", "widthFit", "styleCategory"],
  "Eyewear / Opticals": [...fashionStandard, "styleCategory", "lensIndex", "frameParameters"],
  "Cosmetics": [...fashionStandard, "shade", "shadeHexColor", "skinType", "periodAfterOpening"],
  "Perfume": [...fashionStandard, "fragranceFamily", "concentration", "topNotes", "middleNotes", "baseNotes"],
  "Bags & Luggage": [...fashionStandard, "apparelCategory", "material", "volume"],
  "Accessories": [...fashionStandard, "material", "styleCategory"],
  "Innerwear": [...fashionStandard, "material", "apparelCategory", "careGuide"],
  "Bridal Wear": [...fashionStandard, "artisanLabel", "madeToOrder", "collectionEdition", "fabricComposition"],
  "Kids Fashion": [...fashionStandard, "targetAgeGroup", "material", "careGuide"],
  "Sportswear": [...fashionStandard, "material", "fitType", "patternDesign"],

  // F&B
  "Restaurant": [...fnbStandard, "cuisineType", "kotStation", "kdsCategory", "courseFireDelay", "recipeVersion", "targetFoodCostPct"],
  "Fine Dining": [...fnbStandard, "cuisineType", "winePairing", "kotStation", "recipeVersion", "targetFoodCostPct"],
  "Cafe": [...fnbStandard, "cupSizes", "milkOptions", "sugarLevels", "flavorProfile", "bakeryType"],
  "Coffee Shop": [...fnbStandard, "cupSizes", "milkOptions", "flavorProfile"],
  "Bakery": [...fnbStandard, "cakeSize", "cakeShape", "cakeFilling", "cakeFrosting", "bakeryShelfLife"],
  "Juice Shop": [...fnbStandard, "juiceCategory", "fruitBases", "freshnessDuration", "freshnessUnit"],
  "Fast Food": [...fnbStandard, "swiggySku", "zomatoSku", "uberEatsSku", "talabatSku"],
  "Cloud Kitchen": [...fnbStandard, "containerType", "packagingCost", "stallAssignment", "managementRoyaltyPct"],
  "Ice Cream Parlor": [...fnbStandard, "flavorProfile", "bakeryType", "freshnessDuration"],
  "Catering Service": [...fnbStandard, "minPax", "maxPax", "setupInclusions"],
  "Bar / Pub": [...fnbStandard, "barLiquorClass", "abv", "posAgeGate"],
  "Bistro": fnbStandard,
  "Food Court": fnbStandard,

  // Healthcare
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

  // Others
  "Mobile & Accessories": ["title", "brand", "sku", "barcode", "serialNumber", "imei", "modelNumber"],
  "Computers & Laptops": ["title", "brand", "sku", "barcode", "serialNumber", "modelNumber"],
  "Car Parts": ["title", "brand", "sku", "barcode", "partNumber", "oemNumber", "compatibility", "vehicleMake", "vehicleModel"],
};

final Map<BusinessScale, List<String>> scaleFieldRegistry = {
  BusinessScale.small: [],
  BusinessScale.growing: ["warehouseLocation", "reorderLevel", "safetyStock"],
  BusinessScale.enterprise: ["warehouseLocation", "reorderLevel", "safetyStock", "floorZone", "planogramId", "palletStacking", "unitDimensions", "grossWeight"],
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
};
