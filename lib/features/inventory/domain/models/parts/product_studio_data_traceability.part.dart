part of '../product_studio_data.dart';

/// Traceability, Expiry, and Quality Control fields.
mixin ProductStudioDataTraceability {
  bool enableBatchTracking = false;
  bool enableExpiryTracking = false;
  bool batchExpiryMandatory = false;
  bool breakBulkAllowed = false;
  bool caseSerialTracking = false;
  bool mtcRequired = false;
  bool bulkNarcoticLogging = false;
  bool coldChainLogger = false;
  int expiryWarningThreshold = 0;
  int expiryAlertThreshold = 0;
  int freshnessDuration = 0;
  String freshnessUnit = "";
  DateTime? manufacturingDate;
  DateTime? sterilizationExpiry;
  String periodAfterOpening = "";
  bool isRecalledBatch = false;
  String dataLoggerSerialId = "";
  String inspectionId = "";
  String rfidId = "";

  // Misc Enterprise V3.5 Fields
  String productRelationship = "";
  String warrantyInfo = "";
  bool warrantyAvailable = false;
  int warrantyDuration = 0;
  String warrantyUnit = "";
  String warrantyContract = "";
  String fragranceFamily = "";
  String concentration = "";
  String scentNotes = "";
  String perfumeHouse = "";
  String topNotes = "";
  String middleNotes = "";
  String baseNotes = "";
  String ingredients = "";
  String usageInfo = "";
  int productionLeadTime = 0;
  String brandRange = "";
  String skinType = "";
  String hairType = "";
  String volume = "";
  bool sparePartsBreakdown = false;
  double abv = 0.0;
  bool ageGate = false;
  double baleWeight = 0.0;
  double rollLength = 0.0;
  bool isCatchWeight = false;
  int scaleWeightPrecision = 2;
  double variableWeightTolerance = 0.0;
  double tareWeightDeduction = 0.0;
  String unitPriceComparisonBase = "";
  bool isCrossDockingAllowed = false;
  bool isVmiEnabled = false;
  bool inHouseRepack = false;
  String nicotineContent = "";
  bool passportVerificationRequired = false;
  bool flightNumberRequired = false;
  double multiBuyBundlePrice = 0.0;
  int multiBuyQtyTrigger = 0;
  int multiBuyMaxQtyPerBill = 0;
  double compensationCess = 0.0;
  double minOrderValue = 0.0;
  String temperatureProfile = "";
  String cosmeticGrade = "";
  String batteryHealth = "";
  String sellerWarranty = "";
  String replacedParts = "";
  double peakOutput = 0.0;
  String solarChargeController = "";
  String nightVision = "";
  String focalLength = "";
  bool inverterTechnology = false;
  bool dishwasherSafe = false;
  bool originalBoxIncluded = false;
  bool pureSineWave = false;
  bool obstacleAvoidance = false;
  bool nightVisionEnabled = false;
  bool seasonalProduct = false;
  bool isFoldable = false;
  bool isMotorized = false;
  bool isRentalAvailable = false;
  bool fastMovingFlag = false;
  String takeoffWeight = "";
  String flightTime = "";
  String transmissionRange = "";
  String batteryChemistry = "";
  String template = "General";
  int? ageRestriction;
  BusinessScale? businessScale;
  ItemType itemType = ItemType.stockProduct;
  
  // Scoping fields
  String businessType = "Retail";
  String businessCategory = "Supermarket";

  // Additional Industry Helpers
  String stallAssignment = "";
  double managementRoyaltyPct = 0.0;
  String foodCategory = "";
  String ingredientsSummary = "";
  List<String> dietaryBadges = [];
  List<String> cupSizes = [];
  List<String> fruitBases = [];
  List<String> comboItems = [];
  bool allowRoomFolio = false;
  double roomDeliveryCharge = 0.0;
  double takeawaySurcharge = 0.0;
  bool variableWeightPLU = false;
  List<String> channelEligibility = [];
  String division = "";
  bool privateLabel = false;
  String posHotkeyColor = "";
  String cancellationPolicy = "";
  String repairCustomerImei = "";
  String repairComplaintLog = "";

  // Dynamic Objects
  List<Batch> batches = [];
  Map<String, String> profileData = {}; 
  List<String> modifierGroups = [];
  Map<String, List<MediaAsset>> colorMediaLibrary = {};
}
