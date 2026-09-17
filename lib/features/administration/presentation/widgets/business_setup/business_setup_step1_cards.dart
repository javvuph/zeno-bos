import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'business_setup_models.dart';
import 'business_setup_theme.dart';

class StoreIdentityCard extends StatelessWidget {
  final BusinessSetupData setupData;
  final TextEditingController nameController;
  final TextEditingController legalNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final VoidCallback onFieldChanged;

  const StoreIdentityCard({
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BusinessSetupTheme.formSectionDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BusinessSetupTheme.sectionTitle("Store Identity"),
          BusinessSetupTheme.formLabel("Store / Business Name", isRequired: true),
          ZenoTextField(
            controller: nameController,
            hint: "Tagsole Main",
            onChanged: (v) {
              setupData.storeName = v;
              onFieldChanged();
            },
          ),
          const SizedBox(height: 8),
          BusinessSetupTheme.formLabel("Legal / Company Name", isRequired: true),
          ZenoTextField(
            controller: legalNameController,
            hint: "Tagsole Apparel Private Limited",
            onChanged: (v) {
              setupData.legalName = v;
              onFieldChanged();
            },
          ),
          const SizedBox(height: 8),
          BusinessSetupTheme.formLabel("Store WhatsApp / Phone", isRequired: true),
          ZenoTextField(
            controller: phoneController,
            hint: "+91",
            onChanged: (v) {
              setupData.phone = v;
              onFieldChanged();
            },
          ),
          const SizedBox(height: 8),
          BusinessSetupTheme.formLabel("Store Email (Optional)"),
          ZenoTextField(
            controller: emailController,
            hint: "branch@zeno.store",
            onChanged: (v) {
              setupData.email = v;
              onFieldChanged();
            },
          ),
        ],
      ),
    );
  }
}
