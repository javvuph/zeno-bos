import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/localization/country_registry.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';
import 'business_setup_selector.dart';

class StoreSetupStep1 extends StatelessWidget {
  final StoreBranch editingStore;
  final StoreSetupController controller;
  final TextEditingController nameController;
  final TextEditingController legalNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final bool isConfigLocked;
  final bool isAdmin;
  final Function(String?, String?, String?, {bool isToggle}) onConfigChange;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep1({
    super.key,
    required this.editingStore,
    required this.controller,
    required this.nameController,
    required this.legalNameController,
    required this.phoneController,
    required this.emailController,
    required this.isConfigLocked,
    required this.isAdmin,
    required this.onConfigChange,
  });

  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0x14667EEA), Color(0x0D764BA2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: const Color(0x33667EEA)),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 18,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPurplePrimary, _kPurpleSecondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kPurplePrimary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF666666),
              letterSpacing: 0.5,
            ),
          ),
          if (isRequired)
            const Text(
              " *",
              style: TextStyle(
                color: Colors.red,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialCode = CountryRegistry.countries
        .firstWhere(
          (c) => c.name.toLowerCase() == editingStore.country.toLowerCase(),
          orElse: () => CountryRegistry.defaultCountry,
        )
        .phoneCode;

    final storeIdentitySection = Container(
      padding: const EdgeInsets.all(25),
      decoration: _sectionDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Store Identity"),
          _buildFormLabel("Store / Business Name", isRequired: true),
          ZenoTextField(
            controller: nameController,
            hint: "Tagsole Main",
          ),
          const SizedBox(height: 15),
          _buildFormLabel("Legal / Company Name", isRequired: true),
          ZenoTextField(
            controller: legalNameController,
            hint: "Tagsole Apparel Private Limited",
          ),
          const SizedBox(height: 15),
          _buildFormLabel("Store WhatsApp / Phone", isRequired: true),
          ZenoTextField(
            controller: phoneController,
            hint: "+91",
            prefix: Padding(
              padding: const EdgeInsets.only(left: 10, right: 6),
              child: Text(
                dialCode,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildFormLabel("Store Email (Optional)"),
          ZenoTextField(
            controller: emailController,
            hint: "branch@zeno.store",
          ),
        ],
      ),
    );

    final classificationSelector = BusinessSetupSelector(
      mainBusinesses: controller.industries,
      subBusinesses: controller.getSubTypes(editingStore.industry),
      scales: controller.businessSizes,
      selectedMain: editingStore.industry,
      enabledSubs: editingStore.enabledSubTypes,
      selectedScale: editingStore.businessSize,
      onMainChanged: (v) => onConfigChange(v, null, null),
      onSubToggled: (v) => onConfigChange(null, v, null, isToggle: true),
      onScaleChanged: (v) => onConfigChange(null, null, v),
      isLocked: isConfigLocked && !isAdmin,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              storeIdentitySection,
              const SizedBox(height: 25),
              classificationSelector,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 320,
              child: storeIdentitySection,
            ),
            const SizedBox(width: 25),
            Expanded(
              child: classificationSelector,
            ),
          ],
        );
      },
    );
  }
}
