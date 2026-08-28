import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/registries/healthcare_config.dart';
import '../../widgets/product_studio_tabs.dart';
import 'healthcare_basic_tab.dart';
import 'specs/clinical_salt_specs_tab.dart';
import 'specs/otc_wellness_specs_tab.dart';
import 'specs/controlled_drugs_specs_tab.dart';
import 'specs/cold_chain_specs_tab.dart';
import 'specs/generic_mapping_specs_tab.dart';
import 'specs/ayurvedic_specs_tab.dart';
import 'specs/homeopathic_specs_tab.dart';
import 'specs/surgical_implants_specs_tab.dart';
import 'specs/mobility_specs_tab.dart';
import 'specs/optometry_specs_tab.dart';
import 'specs/lab_reagents_specs_tab.dart';
import 'specs/dental_materials_specs_tab.dart';
import 'specs/veterinary_specs_tab.dart';
import 'specs/supplements_specs_tab.dart';
import '../inventory_price_pillar.dart';
import '../suppliers_section.dart';
import '../tax_section.dart';
import '../batch_section.dart';
import '../expiry_section.dart';
import '../media_pillar.dart';
import '../advanced_section.dart';

class HealthcareWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final Widget Function(ZenoSemanticColors) buildStickyFooter;
  const HealthcareWorkstation({super.key, required this.controller, required this.colors, required this.buildStickyFooter});

  @override
  Widget build(BuildContext context) {
    final profile = getHealthcareOperationalProfile(controller.product.businessCategory, controller.product.template);
    final config = healthcareConfigMap[profile]!;
    
    return Container(
      color: colors.bgTier1,
      child: Column(children: [
        ProductStudioTabs(controller: controller, profileTitle: config.tabTitle),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: _buildActiveTab(profile),
          ),
        ),
        buildStickyFooter(colors),
      ]),
    );
  }

  Widget _buildActiveTab(HealthcareOperationalProfile profile) {
    switch (controller.activeSection) {
      case ProductStudioSection.healthcareBasic: return HealthcareBasicTab(controller: controller, colors: colors);
      case ProductStudioSection.healthcareClinical: return _getSpecTab(profile);
      case ProductStudioSection.batch: return BatchSection(controller: controller, colors: colors);
      case ProductStudioSection.expiry: return ExpirySection(controller: controller, colors: colors);
      case ProductStudioSection.inventoryPrice: return InventoryPricePillar(controller: controller, colors: colors);
      case ProductStudioSection.suppliers: return SuppliersSection(controller: controller, colors: colors);
      case ProductStudioSection.tax: return TaxSection(controller: controller, colors: colors);
      case ProductStudioSection.media: return MediaPillar(controller: controller, colors: colors);
      case ProductStudioSection.advanced: return AdvancedSection(controller: controller, colors: colors);
      default: return HealthcareBasicTab(controller: controller, colors: colors);
    }
  }

  Widget _getSpecTab(HealthcareOperationalProfile profile) {
    switch (profile) {
      case HealthcareOperationalProfile.allopathicRx: return ClinicalSaltSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.otc: return OtcWellnessSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.controlledDrugs: return ControlledDrugsSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.coldChain: return ColdChainSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.genericSubstitution: return GenericMappingSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.ayurvedicHerbal: return AyurvedicSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.homeopathy: return HomeopathicSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.surgicalImplants: return SurgicalImplantsSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.mobilityAids: return MobilitySpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.optometry: return OptometrySpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.labReagents: return LabReagentsSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.dentalMaterials: return DentalMaterialsSpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.veterinaryMedicines: return VeterinarySpecsTab(controller: controller, colors: colors);
      case HealthcareOperationalProfile.supplements: return SupplementsSpecsTab(controller: controller, colors: colors);
    }
  }
}
