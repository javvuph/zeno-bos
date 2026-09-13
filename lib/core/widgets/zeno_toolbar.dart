import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoToolbar extends StatelessWidget {
  final List<Widget> leftActions;
  final List<Widget> rightActions;
  final Widget? center;
  final Color? color;

  const ZenoToolbar({
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
      height: 44, // Synchronized with FilterBar for ZBOS v2.1
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md),
      decoration: BoxDecoration(
        color: color ?? colors.bgTier2,
        border: Border(
            bottom: BorderSide(
                color: colors.borderSubtle, width: ZenoBorderWidth.thin)),
      ),
      child: Row(
        children: [
          if (leftActions.isNotEmpty) ...[
            ...leftActions
                .expand((w) => [w, const SizedBox(width: ZenoSpacing.sm)]),
          ],
          const Spacer(),
          if (center != null) center!,
          const Spacer(),
          if (rightActions.isNotEmpty) ...[
            ...rightActions
                .expand((w) => [const SizedBox(width: ZenoSpacing.sm), w]),
          ],
        ],
      ),
    );
  }
}

class ZenoToolbarAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final String? hint;

  const ZenoToolbarAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final Color textColor =
        isPrimary ? colors.accentPrimary : colors.textPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZenoRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.sm, vertical: ZenoSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: ZenoSizing.iconSM, color: textColor),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: ZenoTypography.micro(textColor)
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                if (hint != null)
                  Text(
                    hint!,
                    style: ZenoTypography.micro(colors.textDisabled)
                        .copyWith(fontSize: 7),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
