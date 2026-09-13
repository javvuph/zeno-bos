enum HealthcareSubBusiness {
  medicalShop,
  clinic,
  surgicalOrthopedic,
  opticalEyecare,
  dentalLabSupplies,
  veterinary,
  specialtyColdChain,
}

enum HealthcareOperationalProfile {
  allopathicRx,
  otc,
  controlledDrugs,
  coldChain,
  genericSubstitution,
  ayurvedicHerbal,
  homeopathy,
  surgicalImplants,
  mobilityAids,
  optometry,
  labReagents,
  dentalMaterials,
  veterinaryMedicines,
  supplements,
}

class HealthcareCategoryConfig {
  final String tabTitle;
  final String defaultUom;
  final bool requiresAgeGate;
  final bool hasBatch;
  final String defaultDepartment;
  final String defaultHsnCode;

  const HealthcareCategoryConfig({
    required this.tabTitle,
    required this.defaultUom,
    this.requiresAgeGate = false,
    this.hasBatch = true,
    required this.defaultDepartment,
    required this.defaultHsnCode,
  });
}

final Map<HealthcareOperationalProfile, HealthcareCategoryConfig> healthcareConfigMap = {
  HealthcareOperationalProfile.allopathicRx: const HealthcareCategoryConfig(
    tabTitle: 'CLINICAL & SALT SPECS', defaultUom: 'Strip', defaultDepartment: 'Pharmacy', defaultHsnCode: '3004',
  ),
  HealthcareOperationalProfile.otc: const HealthcareCategoryConfig(
    tabTitle: 'OTC & WELLNESS', defaultUom: 'Piece', defaultDepartment: 'Wellness', defaultHsnCode: '3004',
  ),
  HealthcareOperationalProfile.controlledDrugs: const HealthcareCategoryConfig(
    tabTitle: 'CONTROLLED DRUGS', defaultUom: 'Strip', defaultDepartment: 'Narcotics', defaultHsnCode: '3004',
  ),
  HealthcareOperationalProfile.coldChain: const HealthcareCategoryConfig(
    tabTitle: 'COLD CHAIN SPECS', defaultUom: 'Vial', defaultDepartment: 'Biologics', defaultHsnCode: '3002',
  ),
  HealthcareOperationalProfile.genericSubstitution: const HealthcareCategoryConfig(
    tabTitle: 'GENERIC MAPPING', defaultUom: 'Strip', defaultDepartment: 'Generic Pharmacy', defaultHsnCode: '3004',
  ),
  HealthcareOperationalProfile.ayurvedicHerbal: const HealthcareCategoryConfig(
    tabTitle: 'AYURVEDIC SPECS', defaultUom: 'Bottle', defaultDepartment: 'Ayurveda', defaultHsnCode: '3003',
  ),
  HealthcareOperationalProfile.homeopathy: const HealthcareCategoryConfig(
    tabTitle: 'HOMEOPATHIC SPECS', defaultUom: 'Bottle', defaultDepartment: 'Homeopathy', defaultHsnCode: '3003',
  ),
  HealthcareOperationalProfile.surgicalImplants: const HealthcareCategoryConfig(
    tabTitle: 'SURGICAL IMPLANTS', defaultUom: 'Piece', defaultDepartment: 'Surgical', defaultHsnCode: '9021',
  ),
  HealthcareOperationalProfile.mobilityAids: const HealthcareCategoryConfig(
    tabTitle: 'MOBILITY SPECS', defaultUom: 'Piece', defaultDepartment: 'Orthopedic', defaultHsnCode: '9021',
  ),
  HealthcareOperationalProfile.optometry: const HealthcareCategoryConfig(
    tabTitle: 'OPTOMETRY SPECS', defaultUom: 'Pair', defaultDepartment: 'Optical', defaultHsnCode: '9001',
  ),
  HealthcareOperationalProfile.labReagents: const HealthcareCategoryConfig(
    tabTitle: 'LAB & REAGENTS', defaultUom: 'Bottle', defaultDepartment: 'Laboratory', defaultHsnCode: '3822',
  ),
  HealthcareOperationalProfile.dentalMaterials: const HealthcareCategoryConfig(
    tabTitle: 'DENTAL MATERIALS', defaultUom: 'Piece', defaultDepartment: 'Dental', defaultHsnCode: '3006',
  ),
  HealthcareOperationalProfile.veterinaryMedicines: const HealthcareCategoryConfig(
    tabTitle: 'VETERINARY SPECS', defaultUom: 'Strip', defaultDepartment: 'Veterinary', defaultHsnCode: '3004',
  ),
  HealthcareOperationalProfile.supplements: const HealthcareCategoryConfig(
    tabTitle: 'SUPPLEMENTS SPECS', defaultUom: 'Container', defaultDepartment: 'Nutraceuticals', defaultHsnCode: '2106',
  ),
};

HealthcareOperationalProfile getHealthcareOperationalProfile(String category, String profile) {
  if (profile.contains("Rx") || profile.contains("Allopathic")) return HealthcareOperationalProfile.allopathicRx;
  if (profile.contains("OTC")) return HealthcareOperationalProfile.otc;
  if (profile.contains("Controlled") || profile.contains("Narcotic")) return HealthcareOperationalProfile.controlledDrugs;
  if (profile.contains("Cold-Chain") || profile.contains("Vaccine")) return HealthcareOperationalProfile.coldChain;
  if (profile.contains("Generic")) return HealthcareOperationalProfile.genericSubstitution;
  if (profile.contains("Ayurvedic") || profile.contains("Herbal")) return HealthcareOperationalProfile.ayurvedicHerbal;
  if (profile.contains("Homeopathy")) return HealthcareOperationalProfile.homeopathy;
  if (profile.contains("Implant") || profile.contains("Surgical")) return HealthcareOperationalProfile.surgicalImplants;
  if (profile.contains("Mobility") || profile.contains("Patient Care")) return HealthcareOperationalProfile.mobilityAids;
  if (profile.contains("Ophthalmic") || profile.contains("Contact Lens")) return HealthcareOperationalProfile.optometry;
  if (profile.contains("Diagnostic") || profile.contains("Reagent")) return HealthcareOperationalProfile.labReagents;
  if (profile.contains("Dental")) return HealthcareOperationalProfile.dentalMaterials;
  if (profile.contains("Veterinary")) return HealthcareOperationalProfile.veterinaryMedicines;
  if (profile.contains("Nutraceutical") || profile.contains("Supplement")) return HealthcareOperationalProfile.supplements;
  return HealthcareOperationalProfile.otc;
}
