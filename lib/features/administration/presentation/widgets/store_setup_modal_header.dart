import 'package:flutter/material.dart';

class StoreSetupModalHeader extends StatelessWidget {
  final int activeTab;
  final int totalSteps;
  final String stepTitle;
  final String industry;
  final String subType;
  final ValueChanged<int> onTabSelected;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupModalHeader({
    super.key,
    required this.activeTab,
    required this.totalSteps,
    required this.stepTitle,
    required this.industry,
    required this.subType,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final progressPct = ((activeTab + 1) / totalSteps * 100).round();
    final allTabs = [
      "1. Store & Business",
      "2. Regional & Tax",
      "3. Operations & POS",
      "4. Online Store & QR",
      "5. Team & Access",
      "6. Enterprise Workflows",
    ];
    final visibleTabs = allTabs.take(totalSteps).toList();
    final subText = "$industry • $subType";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text(
                  "🏪 Business Setup",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 260,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0x33667EEA),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: (activeTab + 1) / totalSteps,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [_kPurplePrimary, _kPurpleSecondary],
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Step ${activeTab + 1} of $totalSteps ($progressPct%)",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF667EEA),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Tab Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(visibleTabs.length, (index) {
              final isActive = activeTab == index;
              return InkWell(
                onTap: () => onTabSelected(index),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  margin: const EdgeInsets.only(right: 24),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isActive ? _kPurplePrimary : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    visibleTabs[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isActive ? _kPurplePrimary : const Color(0xFF333333),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 24),

        // Step Header Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x26667EEA), Color(0x1A764BA2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: const Border(
              bottom: BorderSide(color: Color(0x33667EEA), width: 2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Step ${activeTab + 1} of $totalSteps: $stepTitle ($progressPct%)",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPurplePrimary,
                ),
              ),
              Text(
                subText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
