part of '../admin_dashboard_screen.dart';

class _GovernanceAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isToggle;
  final bool value;
  final VoidCallback onTap;
  const _GovernanceAction(
      {required this.label,
      required this.icon,
      required this.color,
      this.isToggle = false,
      this.value = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(ZenoRadius.md),
            border: Border.all(color: color.withValues(alpha: 0.1))),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 12),
            Expanded(
                child: Text(label,
                    style: ZenoTypography.micro(color)
                        .copyWith(fontWeight: FontWeight.bold))),
            if (isToggle)
              Switch(
                  value: value,
                  onChanged: (v) => onTap(),
                  activeTrackColor: color)
            else
              Icon(Icons.chevron_right, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}

class _MonitorStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;
  const _MonitorStat(
      {required this.label,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: ZenoTypography.micro(colors.textDisabled)),
        const SizedBox(height: 4),
        Text(value,
            style: ZenoTypography.caption(color).copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: ZenoTypography.monoFamily)),
      ],
    );
  }
}

class _BranchNode extends StatelessWidget {
  final dynamic branch;
  final bool isSelected;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  const _BranchNode(
      {required this.branch,
      this.isSelected = false,
      required this.onTap,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            Icon(Icons.storefront_outlined,
                size: 16,
                color: isSelected ? colors.accentPrimary : colors.textDisabled),
            const SizedBox(width: 12),
            Expanded(
                child: Text(branch.name.toUpperCase(),
                    style: ZenoTypography.micro(isSelected
                            ? colors.accentPrimary
                            : colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold))),
            if (isSelected)
              Icon(Icons.check_circle, size: 14, color: colors.statusSuccess),
          ],
        ),
      ),
    );
  }
}

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final ZenoSemanticColors colors;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: ZenoSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ZenoTypography.micro(colors.textDisabled)),
            const SizedBox(height: 2),
            Text(value,
                style: ZenoTypography.headlineMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
          ],
        ),
      ],
    );
  }
}

class _AdminHeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _AdminHeaderBtn(
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
      label: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
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
