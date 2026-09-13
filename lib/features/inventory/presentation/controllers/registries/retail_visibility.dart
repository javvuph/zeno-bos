import 'shared_visibility.dart';

final Map<String, List<String>> retailProfileFields = {
  "Hypermarket": [
    ...retailStandard, ...retailEnterpriseFields, "department", "floorZone", "planogramId",
    "warehouseLocation", "reorderLevel", "safetyStock", "caseMultiplier", "palletStacking",
    "unitDimensions", "grossWeight", "storageClass", "aisle", "bay", "rack", "shelfTier",
    "binSlot", "facingCount", "minDisplayQuantity", "maxDisplayQuantity",
  ],
  "Supermarket": [
    ...retailStandard, ...retailEnterpriseFields, "department", "planogramId", "warehouseLocation",
    "reorderLevel", "safetyStock", "caseMultiplier", "outerCartonBarcode", "masterCaseMultiplier",
    "grossWeight", "unitDimensions",
  ],
  "Grocery / Kirana": [
    ...retailStandard, ...retailEnterpriseFields, "allowLooseBilling", "purchaseUnit",
    "weight", "stockUnit", "inHouseRepack", "conversionFactor", "ingredients", "storageClass",
    "bakeryShelfLife", "countryOfOrigin", "bulkSourceUnit", "repackPackSize",
  ],
  "Mini Market": [
    ...retailStandard, ...retailEnterpriseFields, "fastMovingFlag", "planogramId", "reorderLevel",
    "supplierLeadTime", "floorZone", "aisle", "shelfTier", "binIdentifier", "minDisplayQuantity",
    "fastDropRefillTrigger",
  ],
  "Fresh Produce": [
    ...retailStandard, ...retailEnterpriseFields, "pluCode", "scalePrecisionMode",
    "tareWeightDeduction", "priceBasis", "isCatchWeight", "styleCategory", "countryOfOrigin",
    "harvestDate", "freshnessDuration", "freshnessUnit", "coldStorageIndicator",
    "isLiveMarketPrice", "wastagePct", "botanicalVariety", "farmOrigin",
  ],
  "Butchery & Meat": [
    ...retailStandard, ...retailEnterpriseFields, "animalSpecies", "cutType", "cuttingMasterCode",
    "netPackWeight", "isCatchWeight", "wastagePct", "halalCertId", "halalBatchNo",
    "slaughterhouseCode", "slaughterDate", "storageTemperature", "storageCondition",
    "freshnessDuration", "freshnessUnit", "coldStorageIndicator",
  ],
  "Fish & Seafood": [
    ...retailStandard, ...retailEnterpriseFields, "marineSpecies", "seafoodCut",
    "commercialGrade", "faoCatchZone", "landingPortDate", "storageTemperature",
    "maxDisplayHoursOnIceBed", "isCatchWeight", "cleaningDressingService", "countryOfOrigin",
    "weight", "storageCondition", "freshnessDuration", "freshnessUnit", "coldStorageIndicator",
  ],
  "Organic Store": [
    ...retailStandard, ...retailEnterpriseFields, "organicCertification", "organicCertNo",
    "discontinueDate", "farmTraceabilityId", "countryOfOrigin", "organicStandard",
    "organicAgencyName", "organicLicenseNo", "organicLicenseExpiryDate", "certifiedFarmId",
    "harvestBatchRef", "organicCertifiedToggle",
  ],
  "Liquor & Wine": [
    ...retailStandard, ...retailEnterpriseFields, "barLiquorClass", "abv", "volume",
    "collectionEdition", "countryOfOrigin", "ssccBarcode", "healthLicense", "posAgeGate",
    "containerDepositFee", "beverageType", "bottleVolume", "vintageYear", "appellationRegion",
    "stateExciseSerialBarcode", "permitRef", "bottleReturnDeposit", "ageGate",
  ],
  "Tobacco Store": [
    ...retailStandard, ...retailEnterpriseFields, "tobaccoClassification", "packSize",
    "stickCount", "nicotineContent", "tarContent", "ssccBarcode", "trackTraceStampId",
    "healthWarningVariantId", "manufacturerLicense", "posAgeGate", "ageGate",
    "manufacturerName", "countryOfOrigin",
  ],
  "Duty Free": [
    ...retailStandard, ...retailEnterpriseFields, "importDutyClass", "countryOfOrigin",
    "passportVerificationRequired", "flightNumberRequired", "currency", "onlinePrice",
    "travelCategory", "destinationRestrictions", "baseCurrency", "allowanceClass",
    "customsRef", "boardingPassScanMandate",
  ],
  "Convenience Store": [
    ...retailStandard, ...retailEnterpriseFields, "planogramId", "readyToEatItem",
    "ageRestriction", "reorderLevel", "isRoomServiceAvailable", "foodServiceCategory",
    "grabAndGoBinLocation", "shelfRefillTrigger", "readyToEatToggle", "quickPosScanKey",
    "instantDeliveryAppSync",
  ],
  "Department Store": [
    ...retailStandard, ...retailEnterpriseFields, "department", "staffCommissionRate",
    "planogramId", "concessionBrandId", "departmentFloor", "sectionZone", "fixtureGondolaCode",
    "displayShelfCapacity", "minDisplayUnits",
  ],
  "Dairy Booth": [
    ...retailStandard, ...retailEnterpriseFields, "milkType", "milkFatPct", "snfPct",
    "processingDate", "shelfLifeDays", "storageTemperature", "storageCondition",
    "coldStorageIndicator", "crateCapacityMultiplier", "crateDepositAmount",
    "coldChainActiveMonitor", "freshnessDuration", "freshnessUnit", "containerDepositFee",
  ],
};
