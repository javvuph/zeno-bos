import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'business_setup_models.dart';
import 'business_setup_constants.dart';
import 'business_setup_theme.dart';

class BusinessSetupStep5 extends StatelessWidget {
  final BusinessSetupData setupData;
  final TextEditingController staffPinController;
  final VoidCallback onFieldChanged;

  const BusinessSetupStep5({
    super.key,
    required this.setupData,
    required this.staffPinController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Full Width: Branch Personnel
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BusinessSetupTheme.formSectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BusinessSetupTheme.sectionTitle("Branch Personnel"),
              Container(
                width: double.infinity,
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
                child: const Text(
                  "Staff Accounts: 0 of 10 Used (GROWING Scale)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: BusinessSetupTheme.primaryPurple,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0x0D667EEA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "No staff members assigned yet. Add your first cashier below.",
                    style: TextStyle(fontSize: 12, color: BusinessSetupTheme.textMuted),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Two Columns: Assign Staff & Roles
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BusinessSetupTheme.formSectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupTheme.sectionTitle("Assign Staff Member"),
                    BusinessSetupTheme.formLabel("Staff Email / Username", isRequired: true),
                    ZenoTextField(
                      initialValue: setupData.staffEmail,
                      hint: "cashier@zeno.store",
                      onChanged: (v) {
                        setupData.staffEmail = v;
                        onFieldChanged();
                      },
                    ),
                    const SizedBox(height: 12),
                    BusinessSetupTheme.formLabel("4-Digit PIN", isRequired: true),
                    ZenoTextField(
                      controller: staffPinController,
                      hint: "1234",
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        setupData.staffPin = v;
                        onFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BusinessSetupTheme.formSectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupTheme.sectionTitle("Role & Permissions"),
                    BusinessSetupTheme.formLabel("Role", isRequired: true),
                    ZenoDropdown<String>(
                      label: "",
                      value: setupData.staffRole,
                      items: BusinessSetupConstants.staffRoles
                          .map((r) => DropdownMenuItem(value: r, child: Text(r, style: const TextStyle(fontSize: 12))))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setupData.staffRole = v;
                          onFieldChanged();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0x1A4CAF50),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          "✓ Permission: Billing & Cash Management",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
