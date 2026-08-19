import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class StockSummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final ZenoSemanticColors colors;
  final Color? color;

  const StockSummaryItem({
    super.key,
    required this.label,
    required this.value,
    required this.colors,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: ZenoTypography.micro(colors.textDisabled)),
        const SizedBox(height: 4),
        Text(value,
            style: ZenoTypography.headlineMD(color ?? colors.textPrimary)
                .copyWith(fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class StockFilterChip extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isWarning;

  const StockFilterChip({
    super.key,
    required this.label,
    required this.colors,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.md, vertical: 6),
      decoration: BoxDecoration(
        color: isWarning
            ? colors.statusWarning.withValues(alpha: 0.1)
            : colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(
            color: isWarning
                ? colors.statusWarning.withValues(alpha: 0.3)
                : colors.borderSubtle),
      ),
      child: Text(label,
          style: ZenoTypography.micro(
              isWarning ? colors.statusWarning : colors.textSecondary)),
    );
  }
}

class StockActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;

  const StockActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.lg, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}
