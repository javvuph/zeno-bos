import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class CompletionWizard extends StatelessWidget {
  final double percentage;
  final List<String> missingRequirements;
  final Function(String) onFixRequirement;

  const CompletionWizard({
    super.key,
    required this.percentage,
    required this.missingRequirements,
    required this.onFixRequirement,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // THE "ROUND BOX" (Completeness Gauge)
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 6,
                      backgroundColor: colors.bgTier3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percentage > 80
                            ? colors.statusSuccess
                            : colors.amberGold,
                      ),
                    ),
                  ),
                  Text(
                    "${percentage.toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PRODUCT HEALTH",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: colors.textDisabled,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      percentage == 100 ? "OPTIMIZED" : "ACTIONS REQUIRED",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: percentage == 100
                            ? colors.statusSuccess
                            : colors.amberGold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (missingRequirements.isNotEmpty) ...[
            Text(
              "COMPLETENESS CHECKLIST",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: colors.textDisabled,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            ...missingRequirements
                .map((req) => _buildRequirementItem(req, colors)),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome, size: 14),
              label: const Text("AUTO-FIX WITH AI",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accentPurple.withValues(alpha: 0.1),
                foregroundColor: colors.accentPurple,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String req, ZenoSemanticColors colors) {
    return InkWell(
      onTap: () => onFixRequirement(req),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                size: 12, color: colors.amberGold),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                req,
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 12, color: colors.textDisabled),
          ],
        ),
      ),
    );
  }
}
