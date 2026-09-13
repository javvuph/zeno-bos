import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? color;

  const ZenoChip({
    super.key,
    required this.label,
    this.icon,
    this.onDelete,
    this.onTap,
    this.isSelected = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final Color chipColor =
        color ?? (isSelected ? colors.accentPrimary : colors.bgTier3);
    final Color textColor = isSelected ? Colors.white : colors.textPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZenoRadius.sm),
      child: AnimatedContainer(
        duration: ZenoDuration.fast,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.sm, vertical: ZenoSpacing.xs),
        decoration: BoxDecoration(
          color: isSelected ? chipColor : chipColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(ZenoRadius.sm),
          border: Border.all(
            color: isSelected ? chipColor : colors.borderSubtle,
            width: ZenoBorderWidth.thin,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: textColor),
              const SizedBox(width: 4),
            ],
            Text(
              label.toUpperCase(),
              style: ZenoTypography.micro(textColor)
                  .copyWith(fontWeight: FontWeight.w800),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.close,
                    size: 12, color: textColor.withValues(alpha: 0.6)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
