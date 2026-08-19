part of '../product_studio_data.dart';

/// Specialized sector fields (Industrial, Wholesale, Services, etc.)
mixin ProductStudioDataSpecialized {
  // Industrial & Wholesale
  String masterTradeSku = "";
  String primaryTradeUnit = "";
  String tradeCreditTerms = "";
  String temperatureStorage = "";
  String prePackRatio = "";
  String shrinkageGrade = "";
  String materialGrade = "";
  String freightClass = "";
  String industrialUom = "";
  String incoterms = "";
  String freightSurcharge = "";
  String gaugeThickness = "";
  String rmaPolicy = "";
  String tierUomMapping = "";
  String returnPolicy = "";
  String customsPortOfEntry = "";
  String ssccBarcode = "";
  String masterOuterBarcode = "";
  double masterCaseRatio = 0.0;
  int caseMultiplier = 1;
  int palletStacking = 1;
  String organicCertification = "";
  String organicCertNo = "";
  bool organicCertified = false;
  String farmTraceabilityId = "";
  DateTime? harvestDate;

  // Services
  String serviceCategory = "";
  String serviceDeliveryMode = "";
  int serviceDuration = 0;
  String serviceDurationUnit = "";
  String billingModel = "";
  int bufferTime = 0;
  String therapistRoom = "";
  double staffCommissionRate = 0.0;
  String pricingMetric = "";
  List<String> careTreatments = [];
  List<String> allocatedStaff = [];
  double diagnosisCharge = 0.0;
  String serviceWarranty = "";
  String slaPriority = "";
  String consultationFormat = "";
  String meetingPlatform = "";
  String batchTiming = "";
  bool courseMaterialProvided = false;
  int batchSeatCapacity = 0;
  String membershipFrequency = "";
  String trainerInclusion = "";
  List<String> accessPrivileges = [];
  double admissionFee = 0.0;
  String pausePolicy = "";
  String resourceAssignment = "";
  int advanceBookingHours = 0;
  double advanceDepositPct = 0.0;
  double buyerCreditLimit = 0.0;
  String assignedSalesRepresentative = "";
  String territoryAllocation = "";
  bool isAppointmentRequired = false;

  // Specialized Retail (Optics, Auto, etc.)
  String opticalProductType = "";
  String lensIndex = "";
  List<String> lensCoating = [];
  String frameParameters = "";
  String optometrySph = "";
  String optometryCyl = "";
  String optometryAxis = "";
  String optometryBaseCurve = "";
  String optometryDiameter = "";
  String optometryMoistureContent = "";
  String optometryReplacementSchedule = "";
  String udiCode = "";
  String implantType = "";
  String classicalReference = "";
  String vehicleMake = "";
  String vehicleModel = "";
  String operatingVoltage = "";
  String mountingType = "";
  String packageForm = "";
  int pinCount = 0;
  String networkingDeviceType = "";
  String portConfig = "";
  String wirelessBandwidth = "";
  String iotProtocol = "";
  String weatherproofRating = "";
  bool poeSupported = false;
  bool rackMountable = false;
}
