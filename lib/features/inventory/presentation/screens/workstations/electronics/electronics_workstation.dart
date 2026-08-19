import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/registries/electronics_config.dart';
import 'electronics_basic_tab.dart';
import 'electronics_serial_tab.dart';
import 'specs/smartphones_specs_tab.dart';
import 'specs/laptops_specs_tab.dart';
import 'specs/audio_wearables_specs_tab.dart';
import 'specs/televisions_specs_tab.dart';
import 'specs/large_appliances_specs_tab.dart';
import 'specs/small_appliances_specs_tab.dart';
import 'specs/gaming_specs_tab.dart';
import 'specs/cameras_specs_tab.dart';
import 'specs/it_networking_specs_tab.dart';
import 'specs/refurbished_grading_specs_tab.dart';
import 'specs/components_specs_tab.dart';
import 'specs/drones_robotics_specs_tab.dart';
import 'specs/power_solar_specs_tab.dart';
import 'specs/cctv_specs_tab.dart';
import '../inventory_price_pillar.dart';
import '../suppliers_section.dart';
import '../tax_section.dart';
import '../media_pillar.dart';
import '../advanced_section.dart';

class ElectronicsWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final Widget Function(ZenoSemanticColors) buildStickyFooter;
  const ElectronicsWorkstation({super.key, required this.controller, required this.colors, required this.buildStickyFooter});

  @override
  Widget build(BuildContext context) {
    final profile = getElectronicsOperationalProfile(controller.product.businessCategory, controller.product.template);
    final config = electronicsConfigMap[profile]!;
    
    return Container(
      color: colors.bgTier1,
      child: Column(children: [
        _buildTopTabs(config),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: _buildActiveTab(profile, config))),
        buildStickyFooter(colors),
      ]),
    );
  }

  Widget _buildTopTabs(ElectronicsCategoryConfig config) {
    final sections = [
      {'id': ProductStudioSection.electronicsBasic, 'label': 'DEVICE IDENTITY'},
      {'id': ProductStudioSection.electronicsSpecs, 'label': config.tabTitle},
      {'id': ProductStudioSection.electronicsSerial, 'label': 'SERIAL & IMEI'},
      {'id': ProductStudioSection.inventoryPrice, 'label': 'INVENTORY & PRICE'},
      {'id': ProductStudioSection.suppliers, 'label': 'SUPPLIERS'},
      {'id': ProductStudioSection.tax, 'label': 'TAX'},
      {'id': ProductStudioSection.media, 'label': 'MEDIA'},
      {'id': ProductStudioSection.advanced, 'label': 'ADVANCED'},
    ];
    return Container(
      height: 40, decoration: BoxDecoration(color: colors.bgTier2, border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(children: sections.map((s) {
        final id = s['id'] as ProductStudioSection; final isActive = controller.activeSection == id;
        return InkWell(onTap: () => controller.setSection(id), child: Container(
          height: 40, padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? colors.accentPrimary : Colors.transparent, width: 2))),
          child: Center(child: Text((s['label'] as String), style: TextStyle(fontSize: 9, color: isActive ? colors.accentPrimary : colors.textDisabled, fontWeight: isActive ? FontWeight.w900 : FontWeight.w700, letterSpacing: 1.1))),
        ));
      }).toList()),
    );
  }

  Widget _buildActiveTab(ElectronicsOperationalProfile profile, ElectronicsCategoryConfig config) {
    switch (controller.activeSection) {
      case ProductStudioSection.electronicsBasic: return ElectronicsBasicTab(controller: controller, colors: colors);
      case ProductStudioSection.electronicsSpecs: return _getSpecTab(profile);
      case ProductStudioSection.electronicsSerial: return ElectronicsSerialTab(controller: controller, colors: colors, config: config);
      case ProductStudioSection.inventoryPrice: return InventoryPricePillar(controller: controller, colors: colors);
      case ProductStudioSection.suppliers: return SuppliersSection(controller: controller, colors: colors);
      case ProductStudioSection.tax: return TaxSection(controller: controller, colors: colors);
      case ProductStudioSection.media: return MediaPillar(controller: controller, colors: colors);
      case ProductStudioSection.advanced: return AdvancedSection(controller: controller, colors: colors);
      default: return ElectronicsBasicTab(controller: controller, colors: colors);
    }
  }

  Widget _getSpecTab(ElectronicsOperationalProfile profile) {
    switch (profile) {
      case ElectronicsOperationalProfile.smartphones: return SmartphonesSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.laptopsDesktops: return LaptopsSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.audioWearables: return AudioWearablesSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.televisionsHomeCinema: return TelevisionsSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.largeAppliances: return LargeAppliancesSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.smallAppliances: return SmallAppliancesSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.gamingGear: return GamingSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.camerasPhotography: return CamerasSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.itNetworkingGear: return ItNetworkingSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.refurbishedGrading: return RefurbishedGradingSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.electronicComponents: return ComponentsSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.dronesRobotics: return DronesRoboticsSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.powerSolarBatteries: return PowerSolarSpecsTab(controller: controller, colors: colors);
      case ElectronicsOperationalProfile.cctvSmartHome: return CctvSpecsTab(controller: controller, colors: colors);
    }
  }
}
