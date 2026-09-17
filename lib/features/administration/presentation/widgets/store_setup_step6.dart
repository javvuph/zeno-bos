import 'package:flutter/material.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

class StoreSetupStep6 extends StatelessWidget {
  final StoreBranch editingStore;
  final StoreSetupController controller;
  final VoidCallback onStateChanged;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep6({
    super.key,
    required this.editingStore,
    required this.controller,
    required this.onStateChanged,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Subsystem Config
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: _sectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("AI Subsystem Config"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.aiConfigs.map((cfg) {
                        final isSelected = editingStore.aiConfig.contains(cfg);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              editingStore.aiConfig.remove(cfg);
                            } else {
                              editingStore.aiConfig.add(cfg);
                            }
                            onStateChanged();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                                color: _kPurplePrimary,
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
            const SizedBox(width: 25),

            // Workflow Approvals
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: _sectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Workflow Approvals"),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.workflowApprovals.map((wf) {
                        final isSelected = editingStore.workflowApprovals.contains(wf);
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              editingStore.workflowApprovals.remove(wf);
                            } else {
                              editingStore.workflowApprovals.add(wf);
                            }
                            onStateChanged();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                                color: _kPurplePrimary,
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
        const SizedBox(height: 25),

        // Full Width: Configuration Preview
        Container(
          padding: const EdgeInsets.all(25),
          decoration: _sectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Configuration Preview"),
              Container(
                padding: const EdgeInsets.all(15),
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
                    Text("🏪 RETAIL Optimized", style: TextStyle(fontSize: 12, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.8)),
                    Text("📍 Counter-Service", style: TextStyle(fontSize: 12, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.8)),
                    Text("📊 FIFO Costing", style: TextStyle(fontSize: 12, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.8)),
                    Text("🔧 Standard (Predictive Disabled)", style: TextStyle(fontSize: 12, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.8)),
                    Text("⚡ Direct Processing", style: TextStyle(fontSize: 12, color: Color(0xFF00D4FF), fontFamily: 'monospace', height: 1.8)),
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
