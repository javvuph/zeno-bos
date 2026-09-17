import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/localization/country_registry.dart';
import 'business_setup_models.dart';
import 'business_setup_theme.dart';

class BusinessSetupStep2 extends StatelessWidget {
  final BusinessSetupData setupData;
  final TextEditingController taxIdController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController zipCodeController;
  final VoidCallback onFieldChanged;

  const BusinessSetupStep2({
    super.key,
    required this.setupData,
    required this.taxIdController,
    required this.addressController,
    required this.cityController,
    required this.zipCodeController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == setupData.country.toLowerCase() ||
             c.code.toLowerCase() == setupData.country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    final availableStates = GlobalSubdivisions.getForCountry(countryProfile.code);
    final selectedState = availableStates.contains(setupData.state)
        ? setupData.state
        : (availableStates.isNotEmpty ? availableStates.first : "N/A");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Tax & Jurisdiction
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BusinessSetupTheme.formSectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupTheme.sectionTitle("Tax & Jurisdiction"),
                    BusinessSetupTheme.formLabel("Country", isRequired: true),
                    ZenoDropdown<String>(
                      label: "",
                      value: countryProfile.name,
                      items: CountryRegistry.countries
                          .map((c) => DropdownMenuItem(
                                value: c.name,
                                child: Text("${c.flagEmoji} ${c.name} (${c.phoneCode})", style: const TextStyle(fontSize: 12)),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setupData.country = v;
                          onFieldChanged();
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    BusinessSetupTheme.formLabel("State / Place of Supply", isRequired: true),
                    ZenoDropdown<String>(
                      label: "",
                      value: selectedState,
                      items: availableStates
                          .map((i) => DropdownMenuItem(
                                value: i,
                                child: Text(i, style: const TextStyle(fontSize: 12)),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setupData.state = v;
                          onFieldChanged();
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    BusinessSetupTheme.formLabel("GSTIN Number", isRequired: true),
                    ZenoTextField(
                      controller: taxIdController,
                      hint: "32AAAAAA000A1Z5",
                      onChanged: (v) {
                        setupData.taxId = v;
                        onFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),

            // Right Column: Store Address
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BusinessSetupTheme.formSectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupTheme.sectionTitle("Store Address"),
                    BusinessSetupTheme.formLabel("Street Address / Building", isRequired: true),
                    ZenoTextField(
                      controller: addressController,
                      hint: "Building name, Street, Area",
                      onChanged: (v) {
                        setupData.address = v;
                        onFieldChanged();
                      },
                    ),
                    const SizedBox(height: 12),
                    BusinessSetupTheme.formLabel("City", isRequired: true),
                    ZenoTextField(
                      controller: cityController,
                      hint: "Enter city",
                      onChanged: (v) {
                        setupData.city = v;
                        onFieldChanged();
                      },
                    ),
                    const SizedBox(height: 12),
                    BusinessSetupTheme.formLabel("Postal Code", isRequired: true),
                    ZenoTextField(
                      controller: zipCodeController,
                      hint: "673001",
                      onChanged: (v) {
                        setupData.zipCode = v;
                        onFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Info Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x1A667EEA), Color(0x0D00D4FF)],
            ),
            border: const Border(
              left: BorderSide(color: BusinessSetupTheme.primaryPurple, width: 3),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "✓ State: ${setupData.state} | Currency: INR (₹) | Tax: GSTIN | Timezone: ${setupData.timezone}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: BusinessSetupTheme.primaryPurple,
            ),
          ),
        ),
      ],
    );
  }
}
