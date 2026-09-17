import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'business_setup_models.dart';
import 'business_setup_theme.dart';

class BusinessSetupStep4 extends StatelessWidget {
  final BusinessSetupData setupData;
  final VoidCallback onFieldChanged;

  const BusinessSetupStep4({
    super.key,
    required this.setupData,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Store Access
        SizedBox(
          width: 250,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BusinessSetupTheme.sectionTitle("Store Access"),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.qr_code_2, size: 60, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "QR Code",
                  style: TextStyle(fontSize: 12, color: BusinessSetupTheme.textMuted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Right: Digital Sync
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BusinessSetupTheme.sectionTitle("Digital Sync"),
                BusinessSetupTheme.formLabel("System Generated ID"),
                ZenoTextField(
                  initialValue: setupData.systemId,
                  readOnly: true,
                ),
                const SizedBox(height: 12),
                BusinessSetupTheme.formLabel("Digital Store URL (Auto-Synced)"),
                ZenoTextField(
                  initialValue: setupData.storeUrl,
                  readOnly: true,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: setupData.autoPrintPos,
                      onChanged: (v) {
                        setupData.autoPrintPos = v ?? false;
                        onFieldChanged();
                      },
                      activeColor: BusinessSetupTheme.primaryPurple,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Auto-Print POS Receipts",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: BusinessSetupTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
