enum ElectronicsCategory {
  mobilesTablets,
  laptopsComputers,
  consumerAudioVideo,
  homeAppliances,
  gamingConsoles,
  camerasOptics,
  itNetworking,
  refurbishedPreOwned,
  electronicComponents,
  dronesRobotics,
  powerSolarBatteries,
  cctvSmartHome,
}

enum ElectronicsOperationalProfile {
  smartphones,
  laptopsDesktops,
  audioWearables,
  televisionsHomeCinema,
  largeAppliances,
  smallAppliances,
  gamingGear,
  camerasPhotography,
  itNetworkingGear,
  refurbishedGrading,
  electronicComponents,
  dronesRobotics,
  powerSolarBatteries,
  cctvSmartHome,
}

class ElectronicsCategoryConfig {
  final String tabTitle;
  final bool requiresSerialTracking;
  final bool requiresImei;
  final bool requiresWarranty;
  final String defaultHsnCode;

  const ElectronicsCategoryConfig({
    required this.tabTitle,
    this.requiresSerialTracking = true,
    this.requiresImei = false,
    this.requiresWarranty = true,
    required this.defaultHsnCode,
  });
}

final Map<ElectronicsOperationalProfile, ElectronicsCategoryConfig> electronicsConfigMap = {
  ElectronicsOperationalProfile.smartphones: const ElectronicsCategoryConfig(
    tabTitle: 'SMARTPHONE SPECS', requiresImei: true, defaultHsnCode: '8517',
  ),
  ElectronicsOperationalProfile.laptopsDesktops: const ElectronicsCategoryConfig(
    tabTitle: 'COMPUTING SPECS', defaultHsnCode: '8471',
  ),
  ElectronicsOperationalProfile.audioWearables: const ElectronicsCategoryConfig(
    tabTitle: 'AUDIO & WEARABLES', defaultHsnCode: '8518',
  ),
  ElectronicsOperationalProfile.televisionsHomeCinema: const ElectronicsCategoryConfig(
    tabTitle: 'TELEVISION SPECS', defaultHsnCode: '8528',
  ),
  ElectronicsOperationalProfile.largeAppliances: const ElectronicsCategoryConfig(
    tabTitle: 'LARGE APPLIANCES', defaultHsnCode: '8418',
  ),
  ElectronicsOperationalProfile.smallAppliances: const ElectronicsCategoryConfig(
    tabTitle: 'SMALL APPLIANCES', defaultHsnCode: '8509',
  ),
  ElectronicsOperationalProfile.gamingGear: const ElectronicsCategoryConfig(
    tabTitle: 'GAMING SPECS', defaultHsnCode: '9504',
  ),
  ElectronicsOperationalProfile.camerasPhotography: const ElectronicsCategoryConfig(
    tabTitle: 'CAMERA SPECS', defaultHsnCode: '8525',
  ),
  ElectronicsOperationalProfile.itNetworkingGear: const ElectronicsCategoryConfig(
    tabTitle: 'NETWORKING SPECS', defaultHsnCode: '8517',
  ),
  ElectronicsOperationalProfile.refurbishedGrading: const ElectronicsCategoryConfig(
    tabTitle: 'GRADING & CONDITION', defaultHsnCode: '8517',
  ),
  ElectronicsOperationalProfile.electronicComponents: const ElectronicsCategoryConfig(
    tabTitle: 'COMPONENT SPECS', requiresSerialTracking: false, defaultHsnCode: '8542',
  ),
  ElectronicsOperationalProfile.dronesRobotics: const ElectronicsCategoryConfig(
    tabTitle: 'DRONE SPECS', defaultHsnCode: '8806',
  ),
  ElectronicsOperationalProfile.powerSolarBatteries: const ElectronicsCategoryConfig(
    tabTitle: 'POWER SPECS', defaultHsnCode: '8504',
  ),
  ElectronicsOperationalProfile.cctvSmartHome: const ElectronicsCategoryConfig(
    tabTitle: 'CCTV & SMART HOME', defaultHsnCode: '8525',
  ),
};

ElectronicsOperationalProfile getElectronicsOperationalProfile(String category, String profile) {
  if (profile == "Smartphones" || category.contains("Mobile")) return ElectronicsOperationalProfile.smartphones;
  if (profile == "Laptops & Desktops" || category.contains("Computer")) return ElectronicsOperationalProfile.laptopsDesktops;
  if (profile == "Audio & Wearables" || category.contains("Audio")) return ElectronicsOperationalProfile.audioWearables;
  if (profile == "Televisions & Home Cinema" || category.contains("TV")) return ElectronicsOperationalProfile.televisionsHomeCinema;
  if (profile == "Large Appliances") return ElectronicsOperationalProfile.largeAppliances;
  if (profile == "Small Appliances") return ElectronicsOperationalProfile.smallAppliances;
  if (profile == "Gaming Gear") return ElectronicsOperationalProfile.gamingGear;
  if (profile == "Cameras & Photography") return ElectronicsOperationalProfile.camerasPhotography;
  if (profile == "IT & Networking") return ElectronicsOperationalProfile.itNetworkingGear;
  if (profile == "Refurbished & Grading") return ElectronicsOperationalProfile.refurbishedGrading;
  if (profile == "Electronic Components") return ElectronicsOperationalProfile.electronicComponents;
  if (profile == "Drones & Robotics") return ElectronicsOperationalProfile.dronesRobotics;
  if (profile == "Power & Batteries") return ElectronicsOperationalProfile.powerSolarBatteries;
  if (profile == "CCTV & IoT") return ElectronicsOperationalProfile.cctvSmartHome;
  return ElectronicsOperationalProfile.smartphones;
}
