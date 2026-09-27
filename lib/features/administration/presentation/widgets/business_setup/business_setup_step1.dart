import 'package:flutter/material.dart';
import 'business_setup_models.dart';
import 'business_setup_constants.dart';
import 'business_setup_theme.dart';
import 'business_setup_step1_cards.dart';

class BusinessSetupStep1 extends StatelessWidget {
  final BusinessSetupData setupData;
  final TextEditingController nameController;
  final TextEditingController legalNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final VoidCallback onFieldChanged;

  const BusinessSetupStep1({
    super.key,
    required this.setupData,
    required this.nameController,
    required this.legalNameController,
    required this.phoneController,
    required this.emailController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    final identityCard = StoreIdentityCard(
      setupData: setupData,
      nameController: nameController,
      legalNameController: legalNameController,
      phoneController: phoneController,
      emailController: emailController,
      onFieldChanged: onFieldChanged,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              identityCard,
              const SizedBox(height: 12),
              _buildClassificationCard(),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 320, child: identityCard),
            const SizedBox(width: 16),
            Expanded(child: _buildClassificationCard()),
          ],
        );
      },
    );
  }

  Widget _buildClassificationCard() {
    final subTypes =
        BusinessSetupConstants.getSubBusinesses(setupData.selectedMainBusiness);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 320,
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: BusinessSetupTheme.sectionTitle("MAIN BUSINESS *"),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: BusinessSetupConstants.mainBusinesses.length,
                    itemBuilder: (context, index) {
                      final item = BusinessSetupConstants.mainBusinesses[index];
                      final isSelected = setupData.selectedMainBusiness == item;

                      return InkWell(
                        onTap: () => _selectMainBusiness(item),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0x1A667EEA)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected
                                  ? BusinessSetupTheme.primaryPurple
                                  : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Radio<String>(
                                value: item,
                                groupValue: setupData.selectedMainBusiness,
                                onChanged: (v) {
                                  if (v != null) _selectMainBusiness(v);
                                },
                                activeColor: BusinessSetupTheme.primaryPurple,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? BusinessSetupTheme.primaryPurple
                                      : BusinessSetupTheme.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 320,
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: BusinessSetupTheme.sectionTitle(
                    "SUB-BUSINESS TYPE *",
                  ),
                ),
                Expanded(
                  child: subTypes.isEmpty
                      ? const Center(
                          child: Text(
                            "No sub-business types configured",
                            style: TextStyle(fontSize: 11),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: subTypes.length,
                          itemBuilder: (context, index) {
                            final item = subTypes[index];
                            final isSelected =
                                setupData.selectedSubBusinesses.contains(item);

                            return InkWell(
                              onTap: () => _toggleSubBusiness(item),
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 8,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0x1A667EEA)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSelected
                                        ? BusinessSetupTheme.primaryPurple
                                        : Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (_) =>
                                          _toggleSubBusiness(item),
                                      activeColor:
                                          BusinessSetupTheme.primaryPurple,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: isSelected
                                              ? BusinessSetupTheme
                                                  .primaryPurple
                                              : BusinessSetupTheme.textDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 320,
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: BusinessSetupTheme.sectionTitle("BUSINESS SCALE *"),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      _buildScaleCard(
                        "🏪 SINGLE STORE",
                        "1 Store / Single Location",
                        BusinessScale.small,
                      ),
                      const SizedBox(height: 8),
                      _buildScaleCard(
                        "🏬 MULTIPLE STORE",
                        "Multiple Stores / Branches",
                        BusinessScale.growing,
                      ),
                      const SizedBox(height: 8),
                      _buildScaleCard(
                        "🏢 ENTERPRISE",
                        "Enterprise / Chain / HQ",
                        BusinessScale.enterprise,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _selectMainBusiness(String business) {
    setupData.selectedMainBusiness = business;

    final validSubTypes = BusinessSetupConstants.getSubBusinesses(business);
    setupData.selectedSubBusinesses = setupData.selectedSubBusinesses
        .where(validSubTypes.contains)
        .toList();

    if (setupData.selectedSubBusinesses.isEmpty && validSubTypes.isNotEmpty) {
      setupData.selectedSubBusinesses = [validSubTypes.first];
    }

    onFieldChanged();
  }

  void _toggleSubBusiness(String item) {
    if (setupData.selectedSubBusinesses.contains(item)) {
      setupData.selectedSubBusinesses.remove(item);
    } else {
      setupData.selectedSubBusinesses.add(item);
    }
    onFieldChanged();
  }

  Widget _buildScaleCard(
    String title,
    String subtitle,
    BusinessScale scale,
  ) {
    final isSelected = setupData.selectedScale == scale;

    return InkWell(
      onTap: () {
        setupData.selectedScale = scale;
        onFieldChanged();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0x1A667EEA)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? BusinessSetupTheme.primaryPurple
                : const Color(0x4D667EEA),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? BusinessSetupTheme.primaryPurple
                    : BusinessSetupTheme.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: BusinessSetupTheme.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
