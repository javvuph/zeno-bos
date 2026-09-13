part of '../product_studio_controller.dart';

extension ProductStudioControllerUpdateSpecialized on ProductStudioController {
  void _updateSpecializedFields(ProductStudioData p, {
    String? masterTradeSku, String? primaryTradeUnit, String? tradeCreditTerms,
    String? temperatureStorage, String? prePackRatio, String? shrinkageGrade,
    String? materialGrade, String? freightClass, String? industrialUom,
    String? incoterms, String? freightSurcharge, String? gaugeThickness,
    String? rmaPolicy, String? tierUomMapping, String? returnPolicy,
    String? customsPortOfEntry, String? ssccBarcode, String? masterOuterBarcode,
    double? masterCaseRatio, int? caseMultiplier, int? palletStacking,
    String? organicCertification, String? organicCertNo, bool? organicCertified,
    String? farmTraceabilityId, DateTime? harvestDate,
    String? serviceCategory, String? serviceDeliveryMode, int? serviceDuration,
    String? serviceDurationUnit, String? billingModel, int? bufferTime,
    String? therapistRoom, double? staffCommissionRate, String? pricingMetric,
    List<String>? careTreatments, List<String>? allocatedStaff, double? diagnosisCharge,
    String? serviceWarranty, String? slaPriority, String? consultationFormat,
    String? meetingPlatform, String? batchTiming, bool? courseMaterialProvided,
    int? batchSeatCapacity, String? membershipFrequency, String? trainerInclusion,
    List<String>? accessPrivileges, double? admissionFee, String? pausePolicy,
    String? resourceAssignment, int? advanceBookingHours, double? advanceDepositPct,
    double? buyerCreditLimit, String? assignedSalesRepresentative,
    String? territoryAllocation, bool? isAppointmentRequired,
    String? opticalProductType, String? lensIndex, List<String>? lensCoating,
    String? frameParameters, String? optometrySph, String? optometryCyl,
    String? optometryAxis, String? optometryBaseCurve, String? optometryDiameter,
    String? optometryMoistureContent, String? optometryReplacementSchedule,
    String? udiCode, String? implantType, String? classicalReference,
    String? vehicleMake, String? vehicleModel, String? operatingVoltage,
    String? mountingType, String? packageForm, int? pinCount,
    String? networkingDeviceType, String? portConfig, String? wirelessBandwidth,
    String? iotProtocol, String? weatherproofRating, bool? poeSupported,
    bool? rackMountable,
  }) {
    if (masterTradeSku != null) p.masterTradeSku = masterTradeSku;
    if (primaryTradeUnit != null) p.primaryTradeUnit = primaryTradeUnit;
    if (tradeCreditTerms != null) p.tradeCreditTerms = tradeCreditTerms;
    if (temperatureStorage != null) p.temperatureStorage = temperatureStorage;
    if (prePackRatio != null) p.prePackRatio = prePackRatio;
    if (shrinkageGrade != null) p.shrinkageGrade = shrinkageGrade;
    if (materialGrade != null) p.materialGrade = materialGrade;
    if (freightClass != null) p.freightClass = freightClass;
    if (industrialUom != null) p.industrialUom = industrialUom;
    if (incoterms != null) p.incoterms = incoterms;
    if (freightSurcharge != null) p.freightSurcharge = freightSurcharge;
    if (gaugeThickness != null) p.gaugeThickness = gaugeThickness;
    if (rmaPolicy != null) p.rmaPolicy = rmaPolicy;
    if (tierUomMapping != null) p.tierUomMapping = tierUomMapping;
    if (returnPolicy != null) p.returnPolicy = returnPolicy;
    if (customsPortOfEntry != null) p.customsPortOfEntry = customsPortOfEntry;
    if (ssccBarcode != null) p.ssccBarcode = ssccBarcode;
    if (masterOuterBarcode != null) p.masterOuterBarcode = masterOuterBarcode;
    if (masterCaseRatio != null) p.masterCaseRatio = masterCaseRatio;
    if (caseMultiplier != null) p.caseMultiplier = caseMultiplier;
    if (palletStacking != null) p.palletStacking = palletStacking;
    if (organicCertification != null) p.organicCertification = organicCertification;
    if (organicCertNo != null) p.organicCertNo = organicCertNo;
    if (organicCertified != null) p.organicCertified = organicCertified;
    if (farmTraceabilityId != null) p.farmTraceabilityId = farmTraceabilityId;
    if (harvestDate != null) p.harvestDate = harvestDate;
    if (serviceCategory != null) p.serviceCategory = serviceCategory;
    if (serviceDeliveryMode != null) p.serviceDeliveryMode = serviceDeliveryMode;
    if (serviceDuration != null) p.serviceDuration = serviceDuration;
    if (serviceDurationUnit != null) p.serviceDurationUnit = serviceDurationUnit;
    if (billingModel != null) p.billingModel = billingModel;
    if (bufferTime != null) p.bufferTime = bufferTime;
    if (therapistRoom != null) p.therapistRoom = therapistRoom;
    if (staffCommissionRate != null) p.staffCommissionRate = staffCommissionRate;
    if (pricingMetric != null) p.pricingMetric = pricingMetric;
    if (careTreatments != null) p.careTreatments = careTreatments;
    if (allocatedStaff != null) p.allocatedStaff = allocatedStaff;
    if (diagnosisCharge != null) p.diagnosisCharge = diagnosisCharge;
    if (serviceWarranty != null) p.serviceWarranty = serviceWarranty;
    if (slaPriority != null) p.slaPriority = slaPriority;
    if (consultationFormat != null) p.consultationFormat = consultationFormat;
    if (meetingPlatform != null) p.meetingPlatform = meetingPlatform;
    if (batchTiming != null) p.batchTiming = batchTiming;
    if (courseMaterialProvided != null) p.courseMaterialProvided = courseMaterialProvided;
    if (batchSeatCapacity != null) p.batchSeatCapacity = batchSeatCapacity;
    if (membershipFrequency != null) p.membershipFrequency = membershipFrequency;
    if (trainerInclusion != null) p.trainerInclusion = trainerInclusion;
    if (accessPrivileges != null) p.accessPrivileges = accessPrivileges;
    if (admissionFee != null) p.admissionFee = admissionFee;
    if (pausePolicy != null) p.pausePolicy = pausePolicy;
    if (resourceAssignment != null) p.resourceAssignment = resourceAssignment;
    if (advanceBookingHours != null) p.advanceBookingHours = advanceBookingHours;
    if (advanceDepositPct != null) p.advanceDepositPct = advanceDepositPct;
    if (buyerCreditLimit != null) p.buyerCreditLimit = buyerCreditLimit;
    if (assignedSalesRepresentative != null) p.assignedSalesRepresentative = assignedSalesRepresentative;
    if (territoryAllocation != null) p.territoryAllocation = territoryAllocation;
    if (isAppointmentRequired != null) p.isAppointmentRequired = isAppointmentRequired;
    if (opticalProductType != null) p.opticalProductType = opticalProductType;
    if (lensIndex != null) p.lensIndex = lensIndex;
    if (lensCoating != null) p.lensCoating = lensCoating;
    if (frameParameters != null) p.frameParameters = frameParameters;
    if (optometrySph != null) p.optometrySph = optometrySph;
    if (optometryCyl != null) p.optometryCyl = optometryCyl;
    if (optometryAxis != null) p.optometryAxis = optometryAxis;
    if (optometryBaseCurve != null) p.optometryBaseCurve = optometryBaseCurve;
    if (optometryDiameter != null) p.optometryDiameter = optometryDiameter;
    if (optometryMoistureContent != null) p.optometryMoistureContent = optometryMoistureContent;
    if (optometryReplacementSchedule != null) p.optometryReplacementSchedule = optometryReplacementSchedule;
    if (udiCode != null) p.udiCode = udiCode;
    if (implantType != null) p.implantType = implantType;
    if (classicalReference != null) p.classicalReference = classicalReference;
    if (vehicleMake != null) p.vehicleMake = vehicleMake;
    if (vehicleModel != null) p.vehicleModel = vehicleModel;
    if (operatingVoltage != null) p.operatingVoltage = operatingVoltage;
    if (mountingType != null) p.mountingType = mountingType;
    if (packageForm != null) p.packageForm = packageForm;
    if (pinCount != null) p.pinCount = pinCount;
    if (networkingDeviceType != null) p.networkingDeviceType = networkingDeviceType;
    if (portConfig != null) p.portConfig = portConfig;
    if (wirelessBandwidth != null) p.wirelessBandwidth = wirelessBandwidth;
    if (iotProtocol != null) p.iotProtocol = iotProtocol;
    if (weatherproofRating != null) p.weatherproofRating = weatherproofRating;
    if (poeSupported != null) p.poeSupported = poeSupported;
    if (rackMountable != null) p.rackMountable = rackMountable;
  }
}
