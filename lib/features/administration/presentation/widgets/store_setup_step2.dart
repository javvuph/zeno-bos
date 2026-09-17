import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/localization/country_registry.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

class StoreSetupStep2 extends StatelessWidget {
  final StoreBranch editingStore;
  final TextEditingController nameController;
  final TextEditingController taxIdController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController zipCodeController;
  final bool isShelfPriceTaxInclusive;
  final ValueChanged<String?> onCountryChange;
  final ValueChanged<String?> onStateChange;
  final ValueChanged<bool> onTaxInclusiveChange;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep2({
    super.key,
    required this.editingStore,
    required this.nameController,
    required this.taxIdController,
    required this.addressController,
    required this.cityController,
    required this.zipCodeController,
    required this.isShelfPriceTaxInclusive,
    required this.onCountryChange,
    required this.onStateChange,
    required this.onTaxInclusiveChange,
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
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == editingStore.country.toLowerCase() ||
             c.code.toLowerCase() == editingStore.country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    final availableStates = GlobalSubdivisions.getForCountry(countryProfile.code);
    final selectedState = availableStates.contains(editingStore.state)
        ? editingStore.state
        : (availableStates.isNotEmpty ? availableStates.first : "N/A");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Tax & Jurisdiction
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: _sectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Tax & Jurisdiction"),
                    _buildFormLabel("Country", isRequired: true),
                    ZenoDropdown<String>(
                      label: "",
                      value: countryProfile.name,
                      items: CountryRegistry.countries
                          .map((c) => DropdownMenuItem(
                                value: c.name,
                                child: Text("${c.flagEmoji} ${c.name} (${c.phoneCode})", style: const TextStyle(fontSize: 13)),
                              ))
                          .toList(),
                      onChanged: onCountryChange,
                    ),
                    const SizedBox(height: 15),
                    _buildFormLabel("State / Place of Supply", isRequired: true),
                    ZenoDropdown<String>(
                      label: "",
                      value: selectedState,
                      items: availableStates
                          .map((i) => DropdownMenuItem(
                                value: i,
                                child: Text(i, style: const TextStyle(fontSize: 13)),
                              ))
                          .toList(),
                      onChanged: onStateChange,
                    ),
                    const SizedBox(height: 15),
                    _buildFormLabel("GSTIN Number", isRequired: true),
                    ZenoTextField(
                      controller: taxIdController,
                      hint: "32AAAAAA000A1Z5",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 25),

            // Right Column: Store Address
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: _sectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Store Address"),
                    _buildFormLabel("Street Address / Building", isRequired: true),
                    ZenoTextField(
                      controller: addressController,
                      hint: "Building name, Street, Area",
                    ),
                    const SizedBox(height: 15),
                    _buildFormLabel("City", isRequired: true),
                    ZenoTextField(
                      controller: cityController,
                      hint: "Enter city",
                    ),
                    const SizedBox(height: 15),
                    _buildFormLabel("Postal Code", isRequired: true),
                    ZenoTextField(
                      controller: zipCodeController,
                      hint: "673001",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Info Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x1A667EEA), Color(0x0D00D4FF)],
            ),
            border: const Border(
              left: BorderSide(color: _kPurplePrimary, width: 3),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "✓ State: ${editingStore.state} | Currency: ${editingStore.currency} | Tax: ${editingStore.taxEngine} | Timezone: ${editingStore.timezone}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kPurplePrimary,
            ),
          ),
        ),
      ],
    );
  }
}
