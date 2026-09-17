part of '../customer_list_screen.dart';

class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  final VoidCallback? onTap;
  const _FilterTab(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isPrimary;
  final VoidCallback? onPressed;
  const _ActionBtn(
      {required this.label,
      required this.colors,
      this.isPrimary = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.lg, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
      child: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  const _IconAction({required this.icon, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
