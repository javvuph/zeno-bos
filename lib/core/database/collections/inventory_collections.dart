import 'package:isar/isar.dart';

part 'inventory_collections.g.dart';

@collection
class ProductCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  @Index(unique: true)
  late String sku;

  @Index(unique: true)
  String? barcode;

  late String description;
  late String unit;

  @Index()
  late String categoryId;

  @Index()
  String? brandId;

  late double basePrice;
  late double taxRate;

  // Universal Product Studio Fields
  String? itemType;
  String? status;
  String? businessType;
  String? businessCategory;
  String? gstTaxMode;

  // Supplier Data
  List<String>? supplierIds;
  String? supplierProductName;
  String? supplierPaymentTerms;
  String? supplierContact;
  String? supplierNotes;
  String? supplierProductCode;
  double? supplierPurchaseCost;
  int? supplierMOQ;
  int? supplierLeadTime;
  String? secondarySupplier;

  // Packaging & Conversion Fields
  String? packageType;
  int? unitsPerPackage;
  double? packageQuantity;
  String? stockUnit;
  double? conversionFactor;

  // Industry Specific Fields
  String? material;
  String? metalType;
  String? purity;
  double? weight;
  String? stoneType;
  double? stoneWeight;
  String? jewelrySize;
  String? shade;
  String? skinType;
  String? hairType;
  String? volume;
  String? ingredients;
  String? usageInfo;
  String? fragranceFamily;
  String? concentration;
  String? gender;
  String? scentNotes;
  String? serialNumber;
  String? imei;
  String? modelNumber;
  String? partNumber;
  String? oemNumber;
  String? compatibility;
  String? vehicleMake;
  String? vehicleModel;

  // Fashion Fields
  String? styleCategory;
  String? season;
  String? soleMaterial;
  String? closureType;
  String? widthFit;
  String? sizeStandard;
  String? apparelCategory;
  String? patternDesign;
  String? fitType;
  String? sleeveNeckType;
  String? careGuide;
  String? artisanLabel;
  String? collectionEdition;
  int? productionLeadTime;
  bool? exclusiveSinglePiece;
  bool? madeToOrder;
  String? measurementBust;
  String? measurementWaist;
  String? measurementHip;
  String? measurementFullLength;
  int? gemstoneCount;
  String? hallmarkCert;
  String? makingChargeMode;
  double? makingChargeRate;
  double? wastagePct;
  String? liveRateLink;
  String? brandRange;
  String? shadeHexColor;
  List<String>? safetyCertifications;
  String? periodAfterOpening;
  String? perfumeHouse;
  String? topNotes;
  String? middleNotes;
  String? baseNotes;

  // Advanced Retail Fields
  String? aisleLocation;
  String? countryOfOrigin;
  bool? variableWeightPLU;
  String? pluCode;
  double? tareWeight;
  double? onlinePrice;
  double? maxDiscountPct;
  List<String>? channelEligibility;
  int? expiryWarningThreshold;
  List<String>? searchKeywords;
  String? promotionalBadges;
  String? division;
  bool? privateLabel;
  bool? seasonalProduct;
  double? masterCaseRatio;
  double? grossWeight;
  String? unitDimensions;
  double? packagingDeposit;
  String? importDutyClass;
  double? memberLoyaltyPrice;
  double? loyaltyPointsMultiplier;
  String? storageClass;
  String? floorZone;
  bool? organicCertified;
  String? foodCategory;
  String? ingredientsSummary;
  String? storageCondition;
  List<String>? dietaryBadges;
  bool? fastMovingFlag;
  bool? posHotkeyEnabled;
  String? posHotkeyColor;
  int? ageRestriction;
  bool? readyToEatItem;
  bool? coldStorageIndicator;
  List<String>? multiBarcodes;

  // Marketing & Presence Fields
  String? marketingTitle;
  String? metaDescription;
  String? urlSlug;
  bool? featuredProduct;
  String? productRelationship;
  String? warrantyInfo;
  bool? warrantyAvailable;
  int? warrantyDuration;
  String? warrantyUnit;

  // Food & Beverage Fields
  String? cuisineType;
  String? kotStation;
  String? foodClass;
  String? spiceLevel;
  List<String>? allergens;
  double? calories;
  List<RecipeIngredientEmbed>? recipeBOM;
  String? portionSize;
  int? prepTime;
  double? takeawaySurcharge;
  double? serviceChargePct;
  String? cafeCategory;
  String? temperatureProfile;
  List<String>? cupSizes;
  List<String>? milkOptions;
  List<String>? sugarLevels;
  String? bakeryType;
  String? flavorProfile;
  DateTime? bakeTimestamp;
  int? freshnessDuration;
  String? freshnessUnit;
  String? juiceCategory;
  List<String>? fruitBases;
  bool? isCombo;
  List<String>? comboItems;
  String? hotelDepartment;
  bool? allowRoomFolio;
  double? roomDeliveryCharge;
  String? virtualBrand;
  @ignore
  Map<String, String>? aggregatorMappings;
  String? containerType;
  double? packagingCost;
  String? stallAssignment;
  double? managementRoyaltyPct;

  List<BatchEmbed>? batches;
  List<SupplierRelationshipEmbed>? supplierRelationships;
  List<ProductVariantEmbed>? variants;
  String? customFieldsJson;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  int version = 1;
  String syncStatus = 'pending';
}

@embedded
class BatchEmbed {
  String? uuid;
  String? batchNumber;
  DateTime? manufacturingDate;
  DateTime? expiryDate;
  double? quantity;
  double? purchaseCost;
  double? sellingPrice;
  double? mrp;
  String? supplier;
  String? warehouse;
  String? notes;
}

@embedded
class SupplierRelationshipEmbed {
  String? uuid;
  String? supplierName;
  String? supplierSku;
  String? supplierProductName;
  double? purchaseCost;
  int? moq;
  int? leadTime;
  String? paymentTerms;
  String? notes;
  bool? isPrimary;
}

@embedded
class RecipeIngredientEmbed {
  String? uuid;
  String? ingredientName;
  double? quantity;
  String? unit;
  double? yieldPercentage;
  double? cost;
}

@embedded
class ProductVariantEmbed {
  String? uuid;
  String? productId;
  String? sku;
  String? barcode;
  String? color;
  String? size;
  double? priceAdjustment;
  double? stockLevel;
}

@collection
class CategoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  String? parentId;
  bool isDeleted = false;
}

@collection
class BrandCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  bool isDeleted = false;
}

@collection
class WarehouseCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  @Index(unique: true)
  late String code;

  late String address;
  bool isMain = false;
  bool isDeleted = false;
}

@collection
class StockItemCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String productId;

  @Index()
  late String warehouseId;

  late double quantity;
  late double reservedQuantity;

  DateTime lastUpdated = DateTime.now();
}
