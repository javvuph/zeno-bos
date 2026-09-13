import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

/// ZenoEmptyState v1.0
/// Standardized empty workspace UI for ZENO BOS.
class ZenoEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final Widget? aiSuggestion;

  const ZenoEmptyState({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.aiSuggestion,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ZenoSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON WITH SOFT GLOW
            Container(
              padding: const EdgeInsets.all(ZenoSpacing.lg),
              decoration: BoxDecoration(
                color: colors.bgTier3,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: colors.textDisabled),
            ),
            const SizedBox(height: ZenoSpacing.xl),

            // TEXT CONTENT
            Text(
              title.toUpperCase(),
              style: ZenoTypography.headlineSM(colors.textPrimary).copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: ZenoSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: ZenoTypography.bodyLG(colors.textSecondary)
                    .copyWith(height: 1.5),
              ),
            ),

            const SizedBox(height: ZenoSpacing.xl),

            // ACTIONS
            if (primaryActionLabel != null && onPrimaryAction != null)
              ZenoButton(
                label: primaryActionLabel!,
                onPressed: onPrimaryAction,
                size: ZenoButtonSize.lg,
              ),

            if (aiSuggestion != null) ...[
              const SizedBox(height: ZenoSpacing.xxl),
              aiSuggestion!,
            ],
          ],
        ),
      ),
    );
  }
}
