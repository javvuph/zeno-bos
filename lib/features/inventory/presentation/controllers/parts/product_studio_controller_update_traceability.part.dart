part of '../product_studio_controller.dart';

extension ProductStudioControllerUpdateTraceability on ProductStudioController {
  void _updateTraceabilityFields(ProductStudioData p, {
    bool? enableBatchTracking, bool? enableExpiryTracking, bool? batchExpiryMandatory,
    bool? breakBulkAllowed, bool? caseSerialTracking, bool? mtcRequired,
    bool? bulkNarcoticLogging, bool? coldChainLogger, int? expiryWarningThreshold,
    int? expiryAlertThreshold, int? freshnessDuration, String? freshnessUnit,
    int? unitsPerStrip, bool? allowLooseBilling,
    bool? capWeighed, bool? capPluCode, bool? capBulk, bool? capRepack,
    bool? capTare, bool? capCatchWeight, bool? capVariant, bool? capDeposit,
    bool? capColdChain, bool? capAgeRestriction,
    String? scaleMode, String? pluType, String? bulkSourceProduct,
    double? availableBulkQuantity, String? repackSourceProduct,
    double? repackConversionRatio, double? minWeight, double? maxWeight, String? tareMode, int? minAge,
    String? legalReference, String? depositType, double? depositAmount,
    String? variantGroup, String? variantType,
    DateTime? manufacturingDate, DateTime? sterilizationExpiry,
    String? periodAfterOpening, bool? isRecalledBatch,
    String? dataLoggerSerialId, String? inspectionId, String? rfidId,
    String? productRelationship, String? warrantyInfo, bool? warrantyAvailable,
    int? warrantyDuration, String? warrantyUnit, String? warrantyContract,
    String? fragranceFamily, String? concentration, String? scentNotes,
    String? perfumeHouse, String? topNotes, String? middleNotes, String? baseNotes,
    String? ingredients, String? usageInfo, int? productionLeadTime,
    String? brandRange, String? skinType, String? hairType, String? volume,
    bool? sparePartsBreakdown, double? abv, bool? ageGate, double? baleWeight,
    double? rollLength, bool? isCatchWeight, int? scaleWeightPrecision,
    double? variableWeightTolerance, double? tareWeightDeduction,
    String? unitPriceComparisonBase, bool? isCrossDockingAllowed,
    bool? isVmiEnabled, bool? inHouseRepack, String? nicotineContent,
    bool? passportVerificationRequired, bool? flightNumberRequired,
    double? multiBuyBundlePrice, int? multiBuyQtyTrigger,
    int? multiBuyMaxQtyPerBill, double? compensationCess, double? minOrderValue,
    String? temperatureProfile, String? cosmeticGrade, String? batteryHealth,
    String? sellerWarranty, String? replacedParts, double? peakOutput,
    String? solarChargeController, String? nightVision, String? focalLength,
    bool? inverterTechnology, bool? dishwasherSafe, bool? originalBoxIncluded,
    bool? pureSineWave, bool? obstacleAvoidance, bool? nightVisionEnabled,
    bool? mandatorySerialScan, bool? seasonalProduct, bool? isFoldable,
    bool? isMotorized, bool? isRentalAvailable, bool? fastMovingFlag,
    String? takeoffWeight, String? flightTime, String? transmissionRange,
    String? batteryChemistry, String? template, int? ageRestriction,
    BusinessScale? businessScale, dynamic itemType, String? businessType,
    String? businessCategory, String? stallAssignment, double? managementRoyaltyPct,
    String? foodCategory, String? ingredientsSummary, List<String>? dietaryBadges,
    List<String>? cupSizes, List<String>? fruitBases, List<String>? comboItems,
    bool? allowRoomFolio, double? roomDeliveryCharge, double? takeawaySurcharge,
    bool? variableWeightPLU, List<String>? channelEligibility, String? division,
    bool? privateLabel, String? posHotkeyColor, String? cancellationPolicy,
    String? repairCustomerImei, String? repairComplaintLog,
  }) {
    if (enableBatchTracking != null) p.enableBatchTracking = enableBatchTracking;
    if (enableExpiryTracking != null) p.enableExpiryTracking = enableExpiryTracking;
    if (batchExpiryMandatory != null) p.batchExpiryMandatory = batchExpiryMandatory;
    if (breakBulkAllowed != null) p.breakBulkAllowed = breakBulkAllowed;
    if (caseSerialTracking != null) p.caseSerialTracking = caseSerialTracking;
    if (mtcRequired != null) p.mtcRequired = mtcRequired;
    if (bulkNarcoticLogging != null) p.bulkNarcoticLogging = bulkNarcoticLogging;
    if (coldChainLogger != null) p.coldChainLogger = coldChainLogger;
    if (expiryWarningThreshold != null) p.expiryWarningThreshold = expiryWarningThreshold;
    if (expiryAlertThreshold != null) p.expiryAlertThreshold = expiryAlertThreshold;
    if (freshnessDuration != null) p.freshnessDuration = freshnessDuration;
    if (freshnessUnit != null) p.freshnessUnit = freshnessUnit;
    if (unitsPerStrip != null) p.unitsPerStrip = unitsPerStrip;
    if (allowLooseBilling != null) p.allowLooseBilling = allowLooseBilling;
    if (capWeighed != null) p.capWeighed = capWeighed;
    if (capPluCode != null) p.capPluCode = capPluCode;
    if (capBulk != null) p.capBulk = capBulk;
    if (capRepack != null) p.capRepack = capRepack;
    if (capTare != null) p.capTare = capTare;
    if (capCatchWeight != null) p.capCatchWeight = capCatchWeight;
    if (capVariant != null) p.capVariant = capVariant;
    if (capDeposit != null) p.capDeposit = capDeposit;
    if (capColdChain != null) p.capColdChain = capColdChain;
    if (capAgeRestriction != null) p.capAgeRestriction = capAgeRestriction;
    if (scaleMode != null) p.scaleMode = scaleMode;
    if (pluType != null) p.pluType = pluType;
    if (bulkSourceProduct != null) p.bulkSourceProduct = bulkSourceProduct;
    if (availableBulkQuantity != null) p.availableBulkQuantity = availableBulkQuantity;
    if (repackSourceProduct != null) p.repackSourceProduct = repackSourceProduct;
    if (repackConversionRatio != null) p.repackConversionRatio = repackConversionRatio;
    if (minWeight != null) p.minWeight = minWeight;
    if (maxWeight != null) p.maxWeight = maxWeight;
    if (tareMode != null) p.tareMode = tareMode;
    if (minAge != null) p.minAge = minAge;
    if (legalReference != null) p.legalReference = legalReference;
    if (depositType != null) p.depositType = depositType;
    if (depositAmount != null) p.depositAmount = depositAmount;
    if (variantGroup != null) p.variantGroup = variantGroup;
    if (variantType != null) p.variantType = variantType;
    if (manufacturingDate != null) p.manufacturingDate = manufacturingDate;
    if (sterilizationExpiry != null) p.sterilizationExpiry = sterilizationExpiry;
    if (periodAfterOpening != null) p.periodAfterOpening = periodAfterOpening;
    if (isRecalledBatch != null) p.isRecalledBatch = isRecalledBatch;
    if (dataLoggerSerialId != null) p.dataLoggerSerialId = dataLoggerSerialId;
    if (inspectionId != null) p.inspectionId = inspectionId;
    if (rfidId != null) p.rfidId = rfidId;
    if (productRelationship != null) p.productRelationship = productRelationship;
    if (warrantyInfo != null) p.warrantyInfo = warrantyInfo;
    if (warrantyAvailable != null) p.warrantyAvailable = warrantyAvailable;
    if (warrantyDuration != null) p.warrantyDuration = warrantyDuration;
    if (warrantyUnit != null) p.warrantyUnit = warrantyUnit;
    if (warrantyContract != null) p.warrantyContract = warrantyContract;
    if (fragranceFamily != null) p.fragranceFamily = fragranceFamily;
    if (concentration != null) p.concentration = concentration;
    if (scentNotes != null) p.scentNotes = scentNotes;
    if (perfumeHouse != null) p.perfumeHouse = perfumeHouse;
    if (topNotes != null) p.topNotes = topNotes;
    if (middleNotes != null) p.middleNotes = middleNotes;
    if (baseNotes != null) p.baseNotes = baseNotes;
    if (ingredients != null) p.ingredients = ingredients;
    if (usageInfo != null) p.usageInfo = usageInfo;
    if (productionLeadTime != null) p.productionLeadTime = productionLeadTime;
    if (brandRange != null) p.brandRange = brandRange;
    if (skinType != null) p.skinType = skinType;
    if (hairType != null) p.hairType = hairType;
    if (volume != null) p.volume = volume;
    if (sparePartsBreakdown != null) p.sparePartsBreakdown = sparePartsBreakdown;
    if (abv != null) p.abv = abv;
    if (ageGate != null) p.ageGate = ageGate;
    if (baleWeight != null) p.baleWeight = baleWeight;
    if (rollLength != null) p.rollLength = rollLength;
    if (isCatchWeight != null) p.isCatchWeight = isCatchWeight;
    if (scaleWeightPrecision != null) p.scaleWeightPrecision = scaleWeightPrecision;
    if (variableWeightTolerance != null) p.variableWeightTolerance = variableWeightTolerance;
    if (tareWeightDeduction != null) p.tareWeightDeduction = tareWeightDeduction;
    if (unitPriceComparisonBase != null) p.unitPriceComparisonBase = unitPriceComparisonBase;
    if (isCrossDockingAllowed != null) p.isCrossDockingAllowed = isCrossDockingAllowed;
    if (isVmiEnabled != null) p.isVmiEnabled = isVmiEnabled;
    if (inHouseRepack != null) p.inHouseRepack = inHouseRepack;
    if (nicotineContent != null) p.nicotineContent = nicotineContent;
    if (passportVerificationRequired != null) p.passportVerificationRequired = passportVerificationRequired;
    if (flightNumberRequired != null) p.flightNumberRequired = flightNumberRequired;
    if (multiBuyBundlePrice != null) p.multiBuyBundlePrice = multiBuyBundlePrice;
    if (multiBuyQtyTrigger != null) p.multiBuyQtyTrigger = multiBuyQtyTrigger;
    if (multiBuyMaxQtyPerBill != null) p.multiBuyMaxQtyPerBill = multiBuyMaxQtyPerBill;
    if (compensationCess != null) p.compensationCess = compensationCess;
    if (minOrderValue != null) p.minOrderValue = minOrderValue;
    if (temperatureProfile != null) p.temperatureProfile = temperatureProfile;
    if (cosmeticGrade != null) p.cosmeticGrade = cosmeticGrade;
    if (batteryHealth != null) p.batteryHealth = batteryHealth;
    if (sellerWarranty != null) p.sellerWarranty = sellerWarranty;
    if (replacedParts != null) p.replacedParts = replacedParts;
    if (peakOutput != null) p.peakOutput = peakOutput;
    if (solarChargeController != null) p.solarChargeController = solarChargeController;
    if (nightVision != null) p.nightVision = nightVision;
    if (focalLength != null) p.focalLength = focalLength;
    if (inverterTechnology != null) p.inverterTechnology = inverterTechnology;
    if (dishwasherSafe != null) p.dishwasherSafe = dishwasherSafe;
    if (originalBoxIncluded != null) p.originalBoxIncluded = originalBoxIncluded;
    if (pureSineWave != null) p.pureSineWave = pureSineWave;
    if (obstacleAvoidance != null) p.obstacleAvoidance = obstacleAvoidance;
    if (nightVisionEnabled != null) p.nightVisionEnabled = nightVisionEnabled;
    if (mandatorySerialScan != null) p.mandatorySerialScan = mandatorySerialScan;
    if (seasonalProduct != null) p.seasonalProduct = seasonalProduct;
    if (isFoldable != null) p.isFoldable = isFoldable;
    if (isMotorized != null) p.isMotorized = isMotorized;
    if (isRentalAvailable != null) p.isRentalAvailable = isRentalAvailable;
    if (fastMovingFlag != null) p.fastMovingFlag = fastMovingFlag;
    if (takeoffWeight != null) p.takeoffWeight = takeoffWeight;
    if (flightTime != null) p.flightTime = flightTime;
    if (transmissionRange != null) p.transmissionRange = transmissionRange;
    if (batteryChemistry != null) p.batteryChemistry = batteryChemistry;
    if (template != null) p.template = template;
    if (ageRestriction != null) p.ageRestriction = ageRestriction;
    if (businessScale != null) p.businessScale = businessScale;
    if (itemType != null) p.itemType = itemType;
    if (businessType != null) p.businessType = businessType;
    if (businessCategory != null) p.businessCategory = businessCategory;
    if (stallAssignment != null) p.stallAssignment = stallAssignment;
    if (managementRoyaltyPct != null) p.managementRoyaltyPct = managementRoyaltyPct;
    if (foodCategory != null) p.foodCategory = foodCategory;
    if (ingredientsSummary != null) p.ingredientsSummary = ingredientsSummary;
    if (dietaryBadges != null) p.dietaryBadges = dietaryBadges;
    if (cupSizes != null) p.cupSizes = cupSizes;
    if (fruitBases != null) p.fruitBases = fruitBases;
    if (comboItems != null) p.comboItems = comboItems.map((e) => ComboItem(sku: e)).toList();
    if (allowRoomFolio != null) p.allowRoomFolio = allowRoomFolio;
    if (roomDeliveryCharge != null) p.roomDeliveryCharge = roomDeliveryCharge;
    if (takeawaySurcharge != null) p.takeawaySurcharge = takeawaySurcharge;
    if (variableWeightPLU != null) p.variableWeightPLU = variableWeightPLU;
    if (channelEligibility != null) p.channelEligibility = channelEligibility;
    if (division != null) p.division = division;
    if (privateLabel != null) p.privateLabel = privateLabel;
    if (posHotkeyColor != null) p.posHotkeyColor = posHotkeyColor;
    if (cancellationPolicy != null) p.cancellationPolicy = cancellationPolicy;
    if (repairCustomerImei != null) p.repairCustomerImei = repairCustomerImei;
    if (repairComplaintLog != null) p.repairComplaintLog = repairComplaintLog;
  }
}
