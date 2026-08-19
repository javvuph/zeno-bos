import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

/// ZenoStatusBar v1.0
/// Standardized footer for all ZENO BOS workspaces.
class ZenoStatusBar extends StatelessWidget {
  final List<Widget> leftActions;
  final List<Widget> rightActions;
  final Widget? center;
  final Color? color;

  const ZenoStatusBar({
    super.key,
    this.leftActions = const [],
    this.rightActions = const [],
    this.center,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: ZenoSizing.statusBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md),
      decoration: BoxDecoration(
        color: color ?? colors.bgTier2,
        border: Border(
            top: BorderSide(
                color: colors.borderSubtle, width: ZenoBorderWidth.thin)),
      ),
      child: Row(
        children: [
          if (leftActions.isNotEmpty) ...[
            ...leftActions
                .expand((w) => [w, const _StatusBarDivider()])
                .toList()
              ..removeLast(),
          ],
          const Spacer(),
          if (center != null) center!,
          const Spacer(),
          if (rightActions.isNotEmpty) ...[
            ...rightActions
                .expand((w) => [const _StatusBarDivider(), w])
                .toList()
              ..removeLast(),
          ],
        ],
      ),
    );
  }
}

class _StatusBarDivider extends StatelessWidget {
  const _StatusBarDivider();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: 1,
      height: 12,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md),
    );
  }
}

class ZenoStatusBarIndicator extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const ZenoStatusBarIndicator({
    super.key,
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final Color indicatorColor = color ?? colors.textSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: indicatorColor),
        const SizedBox(width: 6),
        Text(
          label.toUpperCase(),
          style: ZenoTypography.micro(colors.textPrimary).copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
