import 'package:flutter/material.dart';
import 'business_setup_models.dart';
import 'business_setup_theme.dart';

class BusinessSetupMainHeader extends StatelessWidget {
  final BusinessSetupData setupData;
  final int currentStep;
  final int totalSteps;
  final String stepTitle;
  final ValueChanged<int> onTabSelected;

  const BusinessSetupMainHeader({
    super.key,
    required this.setupData,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitle,
    required this.onTabSelected,
  });

  List<String> getVisibleTabs() {
    const all = [
      "1. Store & Business",
      "2. Regional & Tax",
      "3. Operations & POS",
      "4. Online Store & QR",
      "5. Team & Access",
      "6. Enterprise Workflows",
    ];
    return all.take(totalSteps).toList();
  }

  @override
  Widget build(BuildContext context) {
    final progressPct = setupData.getProgressPercentage().round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "🏪 Business Setup",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: BusinessSetupTheme.textDark,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 240,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0x33667EEA),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: (progressPct / 100).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: BusinessSetupTheme.bgGradient,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Progress: $progressPct%",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: BusinessSetupTheme.primaryPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Tab Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(getVisibleTabs().length, (index) {
              final isActive = currentStep == index;
              return InkWell(
                onTap: () => onTabSelected(index),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isActive ? BusinessSetupTheme.primaryPurple : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    getVisibleTabs()[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isActive ? BusinessSetupTheme.primaryPurple : BusinessSetupTheme.textDark,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        // Step Title Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x26667EEA), Color(0x1A764BA2)],
            ),
            border: const Border(bottom: BorderSide(color: Color(0x33667EEA), width: 2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Step ${currentStep + 1} of $totalSteps: $stepTitle",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: BusinessSetupTheme.primaryPurple,
                ),
              ),
              Text(
                "${setupData.selectedMainBusiness} • ${setupData.selectedScale.name.toUpperCase()}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: BusinessSetupTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
