part of '../attendance_hub_screen.dart';

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final ZenoSemanticColors colors;
  final Color? color;
  const _SummaryItem(
      {required this.label,
      required this.value,
      required this.colors,
      this.color});

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

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  final bool isWarning;
  const _FilterChip(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors,
      this.isWarning = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.md, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : (isWarning
                ? colors.statusWarning.withValues(alpha: 0.1)
                : colors.bgTier3),
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(
            color: isSelected
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : (isWarning
                    ? colors.statusWarning.withValues(alpha: 0.3)
                    : colors.borderSubtle)),
      ),
      child: Row(
        children: [
          Text(label,
              style: ZenoTypography.micro(isSelected
                  ? colors.accentPrimary
                  : (isWarning ? colors.statusWarning : colors.textSecondary))),
          const SizedBox(width: 8),
          Text(count.toString(),
              style: ZenoTypography.micro(isSelected
                      ? colors.accentPrimary
                      : (isWarning
                          ? colors.statusWarning
                          : colors.textDisabled))
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _HubButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _HubButton(
      {required this.label,
      required this.icon,
      required this.colors,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.bgTier3,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        side: BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _AttendanceLogItem extends StatelessWidget {
  final String name;
  final String time;
  final String status;
  final ZenoSemanticColors colors;
  const _AttendanceLogItem(
      {required this.name,
      required this.time,
      required this.status,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(Icons.person_outline, size: 14, color: colors.textDisabled),
          const SizedBox(width: 12),
          Text(name,
              style: ZenoTypography.bodyMD(colors.textPrimary)
                  .copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(time, style: ZenoTypography.micro(colors.textDisabled)),
          const SizedBox(width: 16),
          Text(status,
              style: ZenoTypography.micro(colors.statusSuccess)
                  .copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
