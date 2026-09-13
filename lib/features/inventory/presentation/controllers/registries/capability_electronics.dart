import '../../../domain/models/product_studio_enums.dart';

final List<ProductStudioSection> _standardElectronics = [
  ProductStudioSection.electronicsBasic,
  ProductStudioSection.electronicsSpecs,
  ProductStudioSection.electronicsSerial,
  ProductStudioSection.inventoryPrice,
  ProductStudioSection.suppliers,
  ProductStudioSection.tax,
  ProductStudioSection.media,
  ProductStudioSection.advanced,
];

final Map<String, List<ProductStudioSection>> electronicsCapabilities = {
  "Mobiles & Tablets": _standardElectronics,
  "Computers & Laptops": _standardElectronics,
  "TVs & Home Entertainment": _standardElectronics,
  "Audio": _standardElectronics,
  "Appliances": _standardElectronics,
  "Gaming": _standardElectronics,
  "Cameras": _standardElectronics,
  "Networking": _standardElectronics,
  "Refurbished": _standardElectronics,
  "Electronic Components": _standardElectronics,
  "Drones": _standardElectronics,
  "Power / Solar": _standardElectronics,
  "CCTV / Smart Home": _standardElectronics,
};
