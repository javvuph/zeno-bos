import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

/// ZenoLoadingState v1.0
/// Standardized loading indicators and skeletons for ZENO BOS.
class ZenoLoadingState extends StatelessWidget {
  final bool isOverlay;
  final String? message;

  const ZenoLoadingState({
    super.key,
    this.isOverlay = false,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: colors.accentPrimary,
            strokeWidth: 2,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!.toUpperCase(),
              style: ZenoTypography.micro(colors.textSecondary),
            ),
          ],
        ],
      ),
    );

    if (isOverlay) {
      return Container(
        color: colors.bgTier1.withValues(alpha: 0.7),
        child: content,
      );
    }

    return content;
  }
}

class ZenoSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;

  const ZenoSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(radius ?? ZenoRadius.sm),
      ),
    );
  }
}
