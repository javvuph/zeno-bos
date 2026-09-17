part of '../ai_chat_screen.dart';

class _ChatAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _ChatAction(
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
              .copyWith(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isSelected;
  const _HistoryItem(
      {required this.label, required this.colors, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(
            color: isSelected
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : colors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(isSelected ? Icons.psychology : Icons.history_outlined,
              size: 14,
              color: isSelected ? colors.accentPrimary : colors.textDisabled),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label.toUpperCase(),
                  style: ZenoTypography.micro(isSelected
                          ? colors.accentPrimary
                          : colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis)),
        ],
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
