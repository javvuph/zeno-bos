part of '../chart_of_accounts_screen.dart';

class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  const _FilterTab(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: ZenoTypography.micro(
                    isSelected ? colors.accentPrimary : colors.textDisabled)
                .copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w900 : FontWeight.w600)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: isSelected
                  ? colors.accentPrimary.withValues(alpha: 0.1)
                  : colors.bgTier3,
              borderRadius: BorderRadius.circular(4)),
          child: Text(count.toString(),
              style: ZenoTypography.micro(
                  isSelected ? colors.accentPrimary : colors.textSecondary)),
        ),
      ],
    );
  }
}

class _COAButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _COAButton(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
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

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconAction({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, size: 16, color: color),
    );
  }
}
