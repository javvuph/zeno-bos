part of '../product_studio_controller.dart';

extension ProductStudioControllerUpdateIndustry on ProductStudioController {
  void _updateIndustryFields(ProductStudioData p, {
    String? hotelDepartment, String? juiceCategory, String? cafeCategory, String? bakeryType,
    String? digitalMenuDescription, String? preparationSlaWindow, String? fineDiningCourse,
    String? winePairing, String? kdsCategory, String? kotStation, String? foodClass,
    String? spiceLevel, List<String>? allergens, double? calories, int? prepTime,
    int? courseFireDelay, String? recipeVersion, String? recipePrepNotes,
    double? nutritionalProtein, double? nutritionalCarbs, double? nutritionalTransFats,
    String? nutritionalBreakdown, double? dineInPrice, double? takeawayPrice,
    double? aggregatorPrice, double? packagingSurcharge, double? roomServiceMarkupPct,
    double? paxPrice, double? targetFoodCostPct, bool? isExpressPrep,
    bool? customMessageAllowed, bool? extraShotAllowed, bool? isRoomServiceAvailable,
    String? swiggySku, String? zomatoSku, String? uberEatsSku, String? talabatSku,
    String? flavorProfile, List<String>? sugarLevels, List<String>? milkOptions,
    String? portionSize, bool? isCombo, String? virtualBrand, bool? readyToEatItem,
    String? cuisineType, DateTime? bakeTimestamp, double? serviceChargePct,
    String? apparelCategory, String? styleCategory, String? season, String? material,
    String? fabricComposition, String? patternDesign, String? fitType,
    String? sleeveNeckType, String? careGuide, String? artisanLabel, String? collectionEdition,
    String? soleMaterial, String? closureType, String? widthFit, String? sizeStandard,
    String? gender, String? targetAgeGroup, bool? exclusiveSinglePiece, bool? madeToOrder,
    String? measurementBust, String? measurementWaist, String? measurementHip,
    String? measurementFullLength, String? measurementProfile, String? colorFinish,
    String? shade, String? shadeHexColor,
    String? therapeuticCategory, String? indicationCategory, String? drugSchedule,
    String? genericSalt, String? dosageForm, String? prescriptionClass, bool? isNarcotic,
    String? healthLicense, List<String>? assignedDoctors, String? dentalQuadrant,
    bool? consentRequired, String? specimenType, String? fastingRequirement,
    int? tat, String? labRouting, String? referenceRange, String? deviceTrackingType,
    int? calibrationFrequency, bool? biomedicalTraining, String? hazardousGrade,
    String? modelNumber, String? partNumber, String? oemNumber, String? serialNumber,
    String? imei, String? compatibility, String? ramSize, String? internalStorage,
    String? chipset, String? screenSize, String? batteryCapacity, String? connectivity,
    String? simSlots, String? processor, String? ramGeneration, String? dedicatedGpu,
    String? osVersion, String? audioType, String? driverSize, String? bluetoothVersion,
    String? batteryLife, String? panelTechnology, String? resolution,
    String? refreshRate, String? smartTvOs, String? hdrFormat, String? hdmiPorts,
    String? energyRating, String? refrigerantType, double? annualEnergyConsumption,
    String? motorWattage, String? jarCapacity, String? speedControls,
    String? heatingElements, String? gamingPlatform, String? gamingEdition,
    int? controllerCount, String? includedGames, String? sensorType,
    String? megapixels, String? lensMount, String? maxVideoResolution,
    String? isoRange, String? imageStabilization, String? shutterRating,
    bool? fastChargingSupported, bool? ancSupported,
    String? metalType, String? purity, String? stoneType, double? weight, double? stoneWeight,
    String? jewelrySize, int? gemstoneCount, String? makingChargeMode,
    double? makingChargeRate, double? wastagePct, String? liveRateLink,
    List<String>? safetyCertifications, String? containerType, String? cakeSize,
    String? cakeShape, String? cakeFilling, String? cakeFrosting,
    String? coffeeServingTemp, String? barPourMetric, String? mealPlanInclusions,
    String? eventType, String? setupInclusions, String? selfMedicationWarning,
    String? controlledRegisterId, String? masterMoleculeCode, String? genericAlternative,
    String? homeopathyLatinName, String? homeopathyPotencyScale, String? homeopathyDilution,
    String? homeopathyMotherTincture, String? biocompatibilityGrade,
    String? weightCapacity, String? rentalPeriod, String? reagentType,
    String? reagentSensitivity, String? curingTime, String? settingExpansion,
    String? targetSpecies, String? animalWeightRange, String? meatWithdrawalPeriod,
    String? milkWithdrawalPeriod, String? activeNutrient, double? minStorageTemp,
    double? maxStorageTemp, double? maxRoomTempExposure, double? nutrientPercentage,
    bool? substitutionAllowed, DateTime? contractPricingEffectiveFrom,
    DateTime? contractPricingEffectiveTo, DateTime? scheduledTrialDate,
    DateTime? promisedDeliveryDate,
  }) {
    if (hotelDepartment != null) p.hotelDepartment = hotelDepartment;
    if (juiceCategory != null) p.juiceCategory = juiceCategory;
    if (cafeCategory != null) p.cafeCategory = cafeCategory;
    if (bakeryType != null) p.bakeryType = bakeryType;
    if (digitalMenuDescription != null) p.digitalMenuDescription = digitalMenuDescription;
    if (preparationSlaWindow != null) p.preparationSlaWindow = preparationSlaWindow;
    if (fineDiningCourse != null) p.fineDiningCourse = fineDiningCourse;
    if (winePairing != null) p.winePairing = winePairing;
    if (kdsCategory != null) p.kdsCategory = kdsCategory;
    if (kotStation != null) p.kotStation = kotStation;
    if (foodClass != null) p.foodClass = foodClass;
    if (spiceLevel != null) p.spiceLevel = spiceLevel;
    if (allergens != null) p.allergens = allergens;
    if (calories != null) p.calories = calories;
    if (prepTime != null) p.prepTime = prepTime;
    if (courseFireDelay != null) p.courseFireDelay = courseFireDelay;
    if (recipeVersion != null) p.recipeVersion = recipeVersion;
    if (recipePrepNotes != null) p.recipePrepNotes = recipePrepNotes;
    if (nutritionalProtein != null) p.nutritionalProtein = nutritionalProtein;
    if (nutritionalCarbs != null) p.nutritionalCarbs = nutritionalCarbs;
    if (nutritionalTransFats != null) p.nutritionalTransFats = nutritionalTransFats;
    if (nutritionalBreakdown != null) p.nutritionalBreakdown = nutritionalBreakdown;
    if (dineInPrice != null) p.dineInPrice = dineInPrice;
    if (takeawayPrice != null) p.takeawayPrice = takeawayPrice;
    if (aggregatorPrice != null) p.aggregatorPrice = aggregatorPrice;
    if (packagingSurcharge != null) p.packagingSurcharge = packagingSurcharge;
    if (roomServiceMarkupPct != null) p.roomServiceMarkupPct = roomServiceMarkupPct;
    if (paxPrice != null) p.paxPrice = paxPrice;
    if (targetFoodCostPct != null) p.targetFoodCostPct = targetFoodCostPct;
    if (isExpressPrep != null) p.isExpressPrep = isExpressPrep;
    if (customMessageAllowed != null) p.customMessageAllowed = customMessageAllowed;
    if (extraShotAllowed != null) p.extraShotAllowed = extraShotAllowed;
    if (isRoomServiceAvailable != null) p.isRoomServiceAvailable = isRoomServiceAvailable;
    if (swiggySku != null) p.swiggySku = swiggySku;
    if (zomatoSku != null) p.zomatoSku = zomatoSku;
    if (uberEatsSku != null) p.uberEatsSku = uberEatsSku;
    if (talabatSku != null) p.talabatSku = talabatSku;
    if (flavorProfile != null) p.flavorProfile = flavorProfile;
    if (sugarLevels != null) p.sugarLevels = sugarLevels;
    if (milkOptions != null) p.milkOptions = milkOptions;
    if (portionSize != null) p.portionSize = portionSize;
    if (isCombo != null) p.isCombo = isCombo;
    if (virtualBrand != null) p.virtualBrand = virtualBrand;
    if (readyToEatItem != null) p.readyToEatItem = readyToEatItem;
    if (cuisineType != null) p.cuisineType = cuisineType;
    if (bakeTimestamp != null) p.bakeTimestamp = bakeTimestamp;
    if (serviceChargePct != null) p.serviceChargePct = serviceChargePct;
    if (apparelCategory != null) p.apparelCategory = apparelCategory;
    if (styleCategory != null) p.styleCategory = styleCategory;
    if (season != null) p.season = season;
    if (material != null) p.material = material;
    if (fabricComposition != null) p.fabricComposition = fabricComposition;
    if (patternDesign != null) p.patternDesign = patternDesign;
    if (fitType != null) p.fitType = fitType;
    if (sleeveNeckType != null) p.sleeveNeckType = sleeveNeckType;
    if (careGuide != null) p.careGuide = careGuide;
    if (artisanLabel != null) p.artisanLabel = artisanLabel;
    if (collectionEdition != null) p.collectionEdition = collectionEdition;
    if (soleMaterial != null) p.soleMaterial = soleMaterial;
    if (closureType != null) p.closureType = closureType;
    if (widthFit != null) p.widthFit = widthFit;
    if (sizeStandard != null) p.sizeStandard = sizeStandard;
    if (gender != null) p.gender = gender;
    if (targetAgeGroup != null) p.targetAgeGroup = targetAgeGroup;
    if (exclusiveSinglePiece != null) p.exclusiveSinglePiece = exclusiveSinglePiece;
    if (madeToOrder != null) p.madeToOrder = madeToOrder;
    if (measurementBust != null) p.measurementBust = measurementBust;
    if (measurementWaist != null) p.measurementWaist = measurementWaist;
    if (measurementHip != null) p.measurementHip = measurementHip;
    if (measurementFullLength != null) p.measurementFullLength = measurementFullLength;
    if (measurementProfile != null) p.measurementProfile = measurementProfile;
    if (colorFinish != null) p.colorFinish = colorFinish;
    if (shade != null) p.shade = shade;
    if (shadeHexColor != null) p.shadeHexColor = shadeHexColor;
    if (therapeuticCategory != null) p.therapeuticCategory = therapeuticCategory;
    if (indicationCategory != null) p.indicationCategory = indicationCategory;
    if (drugSchedule != null) p.drugSchedule = drugSchedule;
    if (genericSalt != null) p.genericSalt = genericSalt;
    if (dosageForm != null) p.dosageForm = dosageForm;
    if (prescriptionClass != null) p.prescriptionClass = prescriptionClass;
    if (isNarcotic != null) p.isNarcotic = isNarcotic;
    if (healthLicense != null) p.healthLicense = healthLicense;
    if (assignedDoctors != null) p.assignedDoctors = assignedDoctors;
    if (dentalQuadrant != null) p.dentalQuadrant = dentalQuadrant;
    if (consentRequired != null) p.consentRequired = consentRequired;
    if (specimenType != null) p.specimenType = specimenType;
    if (fastingRequirement != null) p.fastingRequirement = fastingRequirement;
    if (tat != null) p.tat = tat;
    if (labRouting != null) p.labRouting = labRouting;
    if (referenceRange != null) p.referenceRange = referenceRange;
    if (deviceTrackingType != null) p.deviceTrackingType = deviceTrackingType;
    if (calibrationFrequency != null) p.calibrationFrequency = calibrationFrequency;
    if (biomedicalTraining != null) p.biomedicalTraining = biomedicalTraining;
    if (hazardousGrade != null) p.hazardousGrade = hazardousGrade;
    if (modelNumber != null) p.modelNumber = modelNumber;
    if (partNumber != null) p.partNumber = partNumber;
    if (oemNumber != null) p.oemNumber = oemNumber;
    if (serialNumber != null) p.serialNumber = serialNumber;
    if (imei != null) p.imei = imei;
    if (compatibility != null) p.compatibility = compatibility;
    if (ramSize != null) p.ramSize = ramSize;
    if (internalStorage != null) p.internalStorage = internalStorage;
    if (chipset != null) p.chipset = chipset;
    if (screenSize != null) p.screenSize = screenSize;
    if (batteryCapacity != null) p.batteryCapacity = batteryCapacity;
    if (connectivity != null) p.connectivity = connectivity;
    if (simSlots != null) p.simSlots = simSlots;
    if (processor != null) p.processor = processor;
    if (ramGeneration != null) p.ramGeneration = ramGeneration;
    if (dedicatedGpu != null) p.dedicatedGpu = dedicatedGpu;
    if (osVersion != null) p.osVersion = osVersion;
    if (audioType != null) p.audioType = audioType;
    if (driverSize != null) p.driverSize = driverSize;
    if (bluetoothVersion != null) p.bluetoothVersion = bluetoothVersion;
    if (batteryLife != null) p.batteryLife = batteryLife;
    if (panelTechnology != null) p.panelTechnology = panelTechnology;
    if (resolution != null) p.resolution = resolution;
    if (refreshRate != null) p.refreshRate = refreshRate;
    if (smartTvOs != null) p.smartTvOs = smartTvOs;
    if (hdrFormat != null) p.hdrFormat = hdrFormat;
    if (hdmiPorts != null) p.hdmiPorts = hdmiPorts;
    if (energyRating != null) p.energyRating = energyRating;
    if (refrigerantType != null) p.refrigerantType = refrigerantType;
    if (annualEnergyConsumption != null) p.annualEnergyConsumption = annualEnergyConsumption;
    if (motorWattage != null) p.motorWattage = motorWattage;
    if (jarCapacity != null) p.jarCapacity = jarCapacity;
    if (speedControls != null) p.speedControls = speedControls;
    if (heatingElements != null) p.heatingElements = heatingElements;
    if (gamingPlatform != null) p.gamingPlatform = gamingPlatform;
    if (gamingEdition != null) p.gamingEdition = gamingEdition;
    if (controllerCount != null) p.controllerCount = controllerCount;
    if (includedGames != null) p.includedGames = includedGames;
    if (sensorType != null) p.sensorType = sensorType;
    if (megapixels != null) p.megapixels = megapixels;
    if (lensMount != null) p.lensMount = lensMount;
    if (maxVideoResolution != null) p.maxVideoResolution = maxVideoResolution;
    if (isoRange != null) p.isoRange = isoRange;
    if (imageStabilization != null) p.imageStabilization = imageStabilization;
    if (shutterRating != null) p.shutterRating = shutterRating;
    if (fastChargingSupported != null) p.fastChargingSupported = fastChargingSupported;
    if (ancSupported != null) p.ancSupported = ancSupported;
    if (metalType != null) p.metalType = metalType;
    if (purity != null) p.purity = purity;
    if (stoneType != null) p.stoneType = stoneType;
    if (weight != null) p.weight = weight;
    if (stoneWeight != null) p.stoneWeight = stoneWeight;
    if (jewelrySize != null) p.jewelrySize = jewelrySize;
    if (gemstoneCount != null) p.gemstoneCount = gemstoneCount;
    if (makingChargeMode != null) p.makingChargeMode = makingChargeMode;
    if (makingChargeRate != null) p.makingChargeRate = makingChargeRate;
    if (wastagePct != null) p.wastagePct = wastagePct;
    if (liveRateLink != null) p.liveRateLink = liveRateLink;
    if (safetyCertifications != null) p.safetyCertifications = safetyCertifications;
    if (containerType != null) p.containerType = containerType;
    if (cakeSize != null) p.cakeSize = cakeSize;
    if (cakeShape != null) p.cakeShape = cakeShape;
    if (cakeFilling != null) p.cakeFilling = cakeFilling;
    if (cakeFrosting != null) p.cakeFrosting = cakeFrosting;
    if (coffeeServingTemp != null) p.coffeeServingTemp = coffeeServingTemp;
    if (barPourMetric != null) p.barPourMetric = barPourMetric;
    if (mealPlanInclusions != null) p.mealPlanInclusions = mealPlanInclusions;
    if (eventType != null) p.eventType = eventType;
    if (setupInclusions != null) p.setupInclusions = setupInclusions;
    if (selfMedicationWarning != null) p.selfMedicationWarning = selfMedicationWarning;
    if (controlledRegisterId != null) p.controlledRegisterId = controlledRegisterId;
    if (masterMoleculeCode != null) p.masterMoleculeCode = masterMoleculeCode;
    if (genericAlternative != null) p.genericAlternative = genericAlternative;
    if (homeopathyLatinName != null) p.homeopathyLatinName = homeopathyLatinName;
    if (homeopathyPotencyScale != null) p.homeopathyPotencyScale = homeopathyPotencyScale;
    if (homeopathyDilution != null) p.homeopathyDilution = homeopathyDilution;
    if (homeopathyMotherTincture != null) p.homeopathyMotherTincture = homeopathyMotherTincture;
    if (biocompatibilityGrade != null) p.biocompatibilityGrade = biocompatibilityGrade;
    if (weightCapacity != null) p.weightCapacity = weightCapacity;
    if (rentalPeriod != null) p.rentalPeriod = rentalPeriod;
    if (reagentType != null) p.reagentType = reagentType;
    if (reagentSensitivity != null) p.reagentSensitivity = reagentSensitivity;
    if (curingTime != null) p.curingTime = curingTime;
    if (settingExpansion != null) p.settingExpansion = settingExpansion;
    if (targetSpecies != null) p.targetSpecies = targetSpecies;
    if (animalWeightRange != null) p.animalWeightRange = animalWeightRange;
    if (meatWithdrawalPeriod != null) p.meatWithdrawalPeriod = meatWithdrawalPeriod;
    if (milkWithdrawalPeriod != null) p.milkWithdrawalPeriod = milkWithdrawalPeriod;
    if (activeNutrient != null) p.activeNutrient = activeNutrient;
    if (minStorageTemp != null) p.minStorageTemp = minStorageTemp;
    if (maxStorageTemp != null) p.maxStorageTemp = maxStorageTemp;
    if (maxRoomTempExposure != null) p.maxRoomTempExposure = maxRoomTempExposure;
    if (nutrientPercentage != null) p.nutrientPercentage = nutrientPercentage;
    if (substitutionAllowed != null) p.substitutionAllowed = substitutionAllowed;
    if (contractPricingEffectiveFrom != null) p.contractPricingEffectiveFrom = contractPricingEffectiveFrom;
    if (contractPricingEffectiveTo != null) p.contractPricingEffectiveTo = contractPricingEffectiveTo;
    if (scheduledTrialDate != null) p.scheduledTrialDate = scheduledTrialDate;
    if (promisedDeliveryDate != null) p.promisedDeliveryDate = promisedDeliveryDate;
  }
}
