import 'sku.dart';
import 'barcode.dart';
import 'category.dart';
import 'brand.dart';
import 'unit.dart';
import 'tax_profile.dart';
import 'product_variant.dart';
import 'product_enums.dart';
import 'batch.dart';
import 'supplier_relationship.dart';
import 'recipe_ingredient.dart';
import 'product_studio_enums.dart';
import 'product_industry_fields.dart';
import 'combo_item.dart';

export 'extensions/product_extensions.dart';

class Product {
  final String id, name, warehouseLocation, businessType, businessCategory, gstTaxMode;
  final String? description, manufacturer, supplierProductName, supplierProductCode, secondarySupplier, supplierPaymentTerms, supplierContact, supplierNotes, packageType, stockUnit;
  final SKU sku; final Barcode? barcode; final Category? category; final Brand? brand; final Unit unit; final TaxProfile? taxProfile;
  final List<ProductVariant> variants; final List<Batch> batches; final List<SupplierRelationship> supplierRelationships;
  final double basePrice, baseCost, mrp, wholesalePrice, discountPct, discountAmount, openingStock, minStock, maxStock, reorderLevel, conversionFactor, packageQuantity, supplierPurchaseCost;
  final DateTime createdAt, updatedAt;
  final ItemType itemType; final ProductStatus status;
  final BusinessScale businessScale;
  final int unitsPerPackage, supplierMOQ, supplierLeadTime;
  final List<String> tags, supplierIds;
  final ProductIndustryFields industry; final Map<String, dynamic> customFields;
  final bool batchTracking, serialTracking;

  const Product({
    required this.id, required this.name, this.description, required this.sku, this.barcode, this.category, this.brand, required this.unit, this.taxProfile,
    this.variants = const [], this.batches = const [], this.supplierRelationships = const [],
    this.basePrice = 0.0, this.baseCost = 0.0, this.mrp = 0.0, this.wholesalePrice = 0.0, this.discountPct = 0.0, this.discountAmount = 0.0, this.openingStock = 0.0,
    this.warehouseLocation = "", required this.createdAt, required this.updatedAt, this.itemType = ItemType.stockProduct, this.status = ProductStatus.active,
    this.businessScale = BusinessScale.small,
    this.manufacturer, this.tags = const [], this.minStock = 0.0, this.maxStock = 0.0, this.reorderLevel = 0.0, this.batchTracking = false, this.serialTracking = false,
    this.supplierIds = const [], this.supplierProductName, this.supplierProductCode, this.supplierPurchaseCost = 0.0, this.supplierMOQ = 0, this.supplierLeadTime = 0,
    this.secondarySupplier, this.supplierPaymentTerms, this.supplierContact, this.supplierNotes, this.businessType = "Retail", this.businessCategory = "Supermarket",
    this.gstTaxMode = "Intra-State", this.packageType, this.unitsPerPackage = 1, this.packageQuantity = 0.0, this.stockUnit, this.conversionFactor = 1.0,
    this.industry = const ProductIndustryFields(), this.customFields = const {},
  });

  bool get hasVariants => variants.isNotEmpty;

  double get stockLevel {
    if (hasVariants) {
      return variants.fold<double>(0.0, (sum, v) => sum + v.stockLevel);
    }
    return openingStock;
  }

  int roundStock(double value) => value.round();

  // Proxy getters for industry fields
  String? get material => industry.material; String? get metalType => industry.metalType; String? get purity => industry.purity;
  double? get weight => industry.weight; String? get stoneType => industry.stoneType; double? get stoneWeight => industry.stoneWeight;
  String? get jewelrySize => industry.jewelrySize; String? get shade => industry.shade; String? get skinType => industry.skinType;
  String? get hairType => industry.hairType; String? get volume => industry.volume; String? get ingredients => industry.ingredients;
  String? get usageInfo => industry.usageInfo; String? get fragranceFamily => industry.fragranceFamily; String? get concentration => industry.concentration;
  String? get gender => industry.gender; String? get scentNotes => industry.scentNotes; String? get serialNumber => industry.serialNumber;
  String? get imei => industry.imei; String? get modelNumber => industry.modelNumber; String? get partNumber => industry.partNumber;
  String? get oemNumber => industry.oemNumber; String? get compatibility => industry.compatibility; String? get vehicleMake => industry.vehicleMake;
  String? get vehicleModel => industry.vehicleModel; String? get styleCategory => industry.styleCategory; String? get season => industry.season;
  String? get soleMaterial => industry.soleMaterial; String? get closureType => industry.closureType; String? get widthFit => industry.widthFit;
  String? get sizeStandard => industry.sizeStandard; String? get apparelCategory => industry.apparelCategory; String? get patternDesign => industry.patternDesign;
  String? get fitType => industry.fitType; String? get sleeveNeckType => industry.sleeveNeckType; String? get careGuide => industry.careGuide;
  String? get artisanLabel => industry.artisanLabel; String? get collectionEdition => industry.collectionEdition; int? get productionLeadTime => industry.productionLeadTime;
  bool get exclusiveSinglePiece => industry.exclusiveSinglePiece; bool get madeToOrder => industry.madeToOrder;
  String? get measurementBust => industry.measurementBust; String? get measurementWaist => industry.measurementWaist; String? get measurementHip => industry.measurementHip;
  String? get measurementFullLength => industry.measurementFullLength; int? get gemstoneCount => industry.gemstoneCount; String? get hallmarkCert => industry.hallmarkCert;
  String? get makingChargeMode => industry.makingChargeMode; double? get makingChargeRate => industry.makingChargeRate; double? get wastagePct => industry.wastagePct;
  String? get liveRateLink => industry.liveRateLink; String? get brandRange => industry.brandRange; String? get shadeHexColor => industry.shadeHexColor;
  List<String> get safetyCertifications => industry.safetyCertifications; String? get periodAfterOpening => industry.periodAfterOpening;
  String? get perfumeHouse => industry.perfumeHouse; String? get topNotes => industry.topNotes; String? get middleNotes => industry.middleNotes;
  String? get baseNotes => industry.baseNotes; String? get aisleLocation => industry.aisleLocation; String? get countryOfOrigin => industry.countryOfOrigin;
  bool get variableWeightPLU => industry.variableWeightPLU; String? get pluCode => industry.pluCode; double get tareWeight => industry.tareWeight;
  double get onlinePrice => industry.onlinePrice; double get maxDiscountPct => industry.maxDiscountPct; List<String> get channelEligibility => industry.channelEligibility;
  int get expiryWarningThreshold => industry.expiryWarningThreshold; List<String> get searchKeywords => industry.searchKeywords;
  String? get promotionalBadges => industry.promotionalBadges; String? get division => industry.division; bool get privateLabel => industry.privateLabel;
  bool get seasonalProduct => industry.seasonalProduct; double get masterCaseRatio => industry.masterCaseRatio; double get grossWeight => industry.grossWeight;
  String? get unitDimensions => industry.unitDimensions; double get packagingDeposit => industry.packagingDeposit; String? get importDutyClass => industry.importDutyClass;
  double get memberLoyaltyPrice => industry.memberLoyaltyPrice; double get loyaltyPointsMultiplier => industry.loyaltyPointsMultiplier;
  String? get storageClass => industry.storageClass; String? get floorZone => industry.floorZone; bool get organicCertified => industry.organicCertified;
  String? get foodCategory => industry.foodCategory; String? get ingredientsSummary => industry.ingredientsSummary; String? get storageCondition => industry.storageCondition;
  List<String> get dietaryBadges => industry.dietaryBadges; bool get fastMovingFlag => industry.fastMovingFlag; bool get posHotkeyEnabled => industry.posHotkeyEnabled;
  String? get posHotkeyColor => industry.posHotkeyColor; int? get ageRestriction => industry.ageRestriction; bool get readyToEatItem => industry.readyToEatItem;
  bool get coldStorageIndicator => industry.coldStorageIndicator; List<String> get multiBarcodes => industry.multiBarcodes;
  String? get marketingTitle => industry.marketingTitle; String? get urlSlug => industry.urlSlug; String? get metaDescription => industry.metaDescription;
  bool get featuredProduct => industry.featuredProduct; String? get productRelationship => industry.productRelationship; String? get warrantyInfo => industry.warrantyInfo;
  bool get warrantyAvailable => industry.warrantyAvailable; int? get warrantyDuration => industry.warrantyDuration; String? get warrantyUnit => industry.warrantyUnit;
  String? get cuisineType => industry.cuisineType; String? get kotStation => industry.kotStation; String? get foodClass => industry.foodClass;
  String? get spiceLevel => industry.spiceLevel; List<String> get allergens => industry.allergens; double get calories => industry.calories;
  List<RecipeIngredient> get recipeBOM => industry.recipeBOM; String? get portionSize => industry.portionSize; int get prepTime => industry.prepTime;
  double get takeawaySurcharge => industry.takeawaySurcharge; double get serviceChargePct => industry.serviceChargePct; String? get cafeCategory => industry.cafeCategory;
  String? get temperatureProfile => industry.temperatureProfile; List<String> get cupSizes => industry.cupSizes; List<String> get milkOptions => industry.milkOptions;
  List<String> get sugarLevels => industry.sugarLevels; String? get bakeryType => industry.bakeryType; String? get flavorProfile => industry.flavorProfile;
  DateTime? get bakeTimestamp => industry.bakeTimestamp; int get freshnessDuration => industry.freshnessDuration; String? get freshnessUnit => industry.freshnessUnit;
  String? get juiceCategory => industry.juiceCategory; List<String> get fruitBases => industry.fruitBases; bool get isCombo => industry.isCombo;
  List<ComboItem> get comboItems => industry.comboItems; String? get hotelDepartment => industry.hotelDepartment; bool get allowRoomFolio => industry.allowRoomFolio;
  double get roomDeliveryCharge => industry.roomDeliveryCharge; String? get virtualBrand => industry.virtualBrand;
  Map<String, String> get aggregatorMappings => industry.aggregatorMappings; String? get containerType => industry.containerType;
  double get packagingCost => industry.packagingCost; String? get stallAssignment => industry.stallAssignment; double get managementRoyaltyPct => industry.managementRoyaltyPct;
  String? get targetAgeGroup => industry.targetAgeGroup;
  DateTime? get scheduledTrialDate => industry.scheduledTrialDate;
  DateTime? get promisedDeliveryDate => industry.promisedDeliveryDate;
  DateTime? get harvestDate => industry.harvestDate;
  DateTime? get contractPricingEffectiveFrom => industry.contractPricingEffectiveFrom;
  DateTime? get contractPricingEffectiveTo => industry.contractPricingEffectiveTo;
  String? get therapeuticCategory => industry.therapeuticCategory;
  String? get indicationCategory => industry.indicationCategory;
  String? get selfMedicationWarning => industry.selfMedicationWarning;
  String? get drugSchedule => industry.drugSchedule;
  String? get controlledRegisterId => industry.controlledRegisterId;
  String? get dataLoggerSerialId => industry.dataLoggerSerialId;
  String? get masterMoleculeCode => industry.masterMoleculeCode;
  String? get genericAlternative => industry.genericAlternative;
  String? get classicalReference => industry.classicalReference;
  String? get homeopathyLatinName => industry.homeopathyLatinName;
  String? get homeopathyPotencyScale => industry.homeopathyPotencyScale;
  String? get homeopathyDilution => industry.homeopathyDilution;
  String? get homeopathyMotherTincture => industry.homeopathyMotherTincture;
  String? get implantType => industry.implantType;
  String? get biocompatibilityGrade => industry.biocompatibilityGrade;
  String? get udiCode => industry.udiCode;
  String? get weightCapacity => industry.weightCapacity;
  String? get rentalPeriod => industry.rentalPeriod;
  String? get optometrySph => industry.optometrySph;
  String? get optometryCyl => industry.optometryCyl;
  String? get optometryAxis => industry.optometryAxis;
  String? get optometryBaseCurve => industry.optometryBaseCurve;
  String? get optometryDiameter => industry.optometryDiameter;
  String? get optometryMoistureContent => industry.optometryMoistureContent;
  String? get optometryReplacementSchedule => industry.optometryReplacementSchedule;
  String? get reagentType => industry.reagentType;
  String? get reagentSensitivity => industry.reagentSensitivity;
  String? get curingTime => industry.curingTime;
  String? get settingExpansion => industry.settingExpansion;
  String? get targetSpecies => industry.targetSpecies;
  String? get animalWeightRange => industry.animalWeightRange;
  String? get meatWithdrawalPeriod => industry.meatWithdrawalPeriod;
  String? get milkWithdrawalPeriod => industry.milkWithdrawalPeriod;
  String? get activeNutrient => industry.activeNutrient;
  double get minStorageTemp => industry.minStorageTemp;
  double get maxStorageTemp => industry.maxStorageTemp;
  double get maxRoomTempExposure => industry.maxRoomTempExposure;
  double get nutrientPercentage => industry.nutrientPercentage;
  bool get coldChainRequired => industry.coldChainRequired;
  bool get substitutionAllowed => industry.substitutionAllowed;
  bool get isFoldable => industry.isFoldable;
  bool get isMotorized => industry.isMotorized;
  bool get isRentalAvailable => industry.isRentalAvailable;
  DateTime? get sterilizationExpiry => industry.sterilizationExpiry;
  String? get ramSize => industry.ramSize; String? get internalStorage => industry.internalStorage; String? get chipset => industry.chipset;
  String? get screenSize => industry.screenSize; String? get batteryCapacity => industry.batteryCapacity; String? get connectivity => industry.connectivity;
  String? get simSlots => industry.simSlots; String? get colorFinish => industry.colorFinish; String? get processor => industry.processor;
  String? get ramGeneration => industry.ramGeneration; String? get dedicatedGpu => industry.dedicatedGpu; String? get osVersion => industry.osVersion;
  String? get audioType => industry.audioType; String? get driverSize => industry.driverSize; String? get bluetoothVersion => industry.bluetoothVersion;
  String? get batteryLife => industry.batteryLife; String? get panelTechnology => industry.panelTechnology; String? get resolution => industry.resolution;
  String? get refreshRate => industry.refreshRate; String? get smartTvOs => industry.smartTvOs; String? get hdrFormat => industry.hdrFormat;
  String? get hdmiPorts => industry.hdmiPorts; String? get energyRating => industry.energyRating; String? get refrigerantType => industry.refrigerantType;
  double get annualEnergyConsumption => industry.annualEnergyConsumption; String? get motorWattage => industry.motorWattage; String? get jarCapacity => industry.jarCapacity;
  String? get speedControls => industry.speedControls; String? get heatingElements => industry.heatingElements; String? get gamingPlatform => industry.gamingPlatform;
  String? get gamingEdition => industry.gamingEdition; int? get controllerCount => industry.controllerCount; String? get includedGames => industry.includedGames;
  String? get sensorType => industry.sensorType; String? get megapixels => industry.megapixels; String? get lensMount => industry.lensMount;
  String? get maxVideoResolution => industry.maxVideoResolution; String? get isoRange => industry.isoRange; String? get imageStabilization => industry.imageStabilization;
  String? get shutterRating => industry.shutterRating; String? get networkingDeviceType => industry.networkingDeviceType; String? get portConfig => industry.portConfig;
  String? get wirelessBandwidth => industry.wirelessBandwidth; String? get cosmeticGrade => industry.cosmeticGrade; String? get batteryHealth => industry.batteryHealth;
  String? get inspectionId => industry.inspectionId; String? get sellerWarranty => industry.sellerWarranty; String? get replacedParts => industry.replacedParts;
  String? get operatingVoltage => industry.operatingVoltage; String? get mountingType => industry.mountingType; String? get packageForm => industry.packageForm;
  int? get pinCount => industry.pinCount; String? get takeoffWeight => industry.takeoffWeight; String? get flightTime => industry.flightTime;
  String? get transmissionRange => industry.transmissionRange; String? get batteryChemistry => industry.batteryChemistry; String? get peakOutput => industry.peakOutput;
  String? get solarChargeController => industry.solarChargeController; String? get nightVision => industry.nightVision; String? get focalLength => industry.focalLength;
  String? get iotProtocol => industry.iotProtocol; String? get weatherproofRating => industry.weatherproofRating;
  bool get fastChargingSupported => industry.fastChargingSupported; bool get ancSupported => industry.ancSupported; bool get inverterTechnology => industry.inverterTechnology;
  bool get dishwasherSafe => industry.dishwasherSafe; bool get poeSupported => industry.poeSupported; bool get rackMountable => industry.rackMountable;
  bool get originalBoxIncluded => industry.originalBoxIncluded; bool get pureSineWave => industry.pureSineWave; bool get obstacleAvoidance => industry.obstacleAvoidance;
  bool get nightVisionEnabled => industry.nightVisionEnabled; bool get mandatorySerialScan => industry.mandatorySerialScan;
}
