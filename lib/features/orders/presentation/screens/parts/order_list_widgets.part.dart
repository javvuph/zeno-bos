part of '../order_list_screen.dart';

class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  final bool isWarning;
  const _FilterTab(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors,
      this.isWarning = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: ZenoTypography.micro(isSelected
                    ? colors.accentPrimary
                    : (isWarning ? colors.statusWarning : colors.textDisabled))
                .copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w900 : FontWeight.w600)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: isSelected
                  ? colors.accentPrimary.withValues(alpha: 0.1)
                  : (isWarning
                      ? colors.statusWarning.withValues(alpha: 0.1)
                      : colors.bgTier3),
              borderRadius: BorderRadius.circular(4)),
          child: Text(count.toString(),
              style: ZenoTypography.micro(isSelected
                  ? colors.accentPrimary
                  : (isWarning ? colors.statusWarning : colors.textSecondary))),
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onTap;
  const _ActionBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label,
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
      ),
    );
  }
}
