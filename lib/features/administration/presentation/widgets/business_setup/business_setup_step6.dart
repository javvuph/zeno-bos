import 'package:flutter/material.dart';
import 'business_setup_models.dart';
import 'business_setup_constants.dart';
import 'business_setup_theme.dart';

class BusinessSetupStep6 extends StatelessWidget {
  final BusinessSetupData setupData;
  final VoidCallback onFieldChanged;

  const BusinessSetupStep6({
    super.key,
    required this.setupData,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Subsystem Config
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BusinessSetupTheme.formSectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupTheme.sectionTitle("AI Subsystem Config"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: BusinessSetupConstants.aiConfigOptions.map((cfg) {
                        final isSelected = setupData.selectedAiConfigs.contains(cfg);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              setupData.selectedAiConfigs.remove(cfg);
                            } else {
                              setupData.selectedAiConfigs.add(cfg);
                            }
                            onFieldChanged();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0x1A667EEA),
                              border: Border.all(color: const Color(0x4D667EEA)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              cfg,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: BusinessSetupTheme.primaryPurple,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),

            // Workflow Approvals
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BusinessSetupTheme.formSectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupTheme.sectionTitle("Workflow Approvals"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: BusinessSetupConstants.workflowApprovalOptions.map((wf) {
                        final isSelected = setupData.selectedWorkflowApprovals.contains(wf);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              setupData.selectedWorkflowApprovals.remove(wf);
                            } else {
                              setupData.selectedWorkflowApprovals.add(wf);
                            }
                            onFieldChanged();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0x1A667EEA),
                              border: Border.all(color: const Color(0x4D667EEA)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              wf,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: BusinessSetupTheme.primaryPurple,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Full Width: Configuration Preview
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BusinessSetupTheme.formSectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BusinessSetupTheme.sectionTitle("Configuration Preview"),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0x1A00D4FF),
                  border: const Border(
                    left: BorderSide(color: Color(0xFF00D4FF), width: 3),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🏪 RETAIL Optimized", style: TextStyle(fontSize: 11, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.6)),
                    Text("📍 Counter-Service", style: TextStyle(fontSize: 11, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.6)),
                    Text("📊 FIFO Costing", style: TextStyle(fontSize: 11, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.6)),
                    Text("🔧 Standard (Predictive Disabled)", style: TextStyle(fontSize: 11, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.6)),
                    Text("⚡ Direct Processing", style: TextStyle(fontSize: 11, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.6)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
