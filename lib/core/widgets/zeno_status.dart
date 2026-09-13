import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

/// ZenoStatus v1.0
/// Standardized visual status indicators for ZENO BOS.
class ZenoStatusDot extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color? color;
  final bool showGlow;

  const ZenoStatusDot({
    super.key,
    required this.label,
    this.isActive = true,
    this.color,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final Color statusColor =
        color ?? (isActive ? colors.statusSuccess : colors.statusDanger);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
            boxShadow: (showGlow && isActive)
                ? [
                    BoxShadow(
                        color: statusColor.withValues(alpha: 0.4),
                        blurRadius: 4),
                  ]
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label.toUpperCase(),
          style: ZenoTypography.micro(colors.textSecondary).copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class ZenoStatusBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;

  const ZenoStatusBadge({
    super.key,
    required this.label,
    this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ZenoRadius.sm),
        border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: ZenoBorderWidth.hairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label.toUpperCase(),
            style: ZenoTypography.micro(color)
                .copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
