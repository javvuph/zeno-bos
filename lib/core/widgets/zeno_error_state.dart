import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

/// ZenoErrorState v1.0
/// Standardized error reporting UI for ZENO BOS.
class ZenoErrorState extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  final String? techDetails;

  const ZenoErrorState({
    super.key,
    required this.error,
    this.onRetry,
    this.techDetails,
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
            Icon(Icons.error_outline_rounded,
                size: 48, color: colors.statusDanger),
            const SizedBox(height: ZenoSpacing.xl),
            Text(
              "System Exception".toUpperCase(),
              style: ZenoTypography.headlineSM(colors.statusDanger)
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: ZenoSpacing.md),
            Text(
              error,
              textAlign: TextAlign.center,
              style: ZenoTypography.bodyLG(colors.textPrimary),
            ),
            if (techDetails != null) ...[
              const SizedBox(height: ZenoSpacing.lg),
              Container(
                padding: const EdgeInsets.all(ZenoSpacing.md),
                decoration: BoxDecoration(
                  color: colors.bgTier3,
                  borderRadius: BorderRadius.circular(ZenoRadius.md),
                ),
                child: Text(
                  techDetails!,
                  style: ZenoTypography.micro(colors.textDisabled)
                      .copyWith(fontFamily: ZenoTypography.monoFamily),
                ),
              ),
            ],
            const SizedBox(height: ZenoSpacing.xl),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onRetry != null)
                  ZenoButton(
                    label: "Retry Operation",
                    onPressed: onRetry,
                    icon: Icons.refresh,
                  ),
                const SizedBox(width: 12),
                ZenoButton(
                  label: "Report Issue",
                  variant: ZenoButtonVariant.secondary,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
