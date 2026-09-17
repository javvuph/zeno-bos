part of '../automation_hub_screen.dart';

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

class _WorkflowItem extends StatelessWidget {
  final String label;
  final String status;
  final Color color;
  final ZenoSemanticColors colors;
  const _WorkflowItem(
      {required this.label,
      required this.status,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(color: colors.borderSubtle)),
      child: Row(
        children: [
          Icon(Icons.bolt, size: 14, color: color),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label,
                  style: ZenoTypography.caption(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.bold))),
          Text(status,
              style: ZenoTypography.micro(color)
                  .copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _TriggerStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;
  const _TriggerStat(
      {required this.label,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.lg),
      child: Row(
        children: [
          Text(label,
              style: ZenoTypography.micro(colors.textDisabled)
                  .copyWith(letterSpacing: 1)),
          const Spacer(),
          Text(value,
              style: ZenoTypography.headlineSM(color).copyWith(
                  fontWeight: FontWeight.w900,
                  fontFamily: ZenoTypography.monoFamily)),
        ],
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  const _HeaderBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
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

class _ActionBtn extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  const _ActionBtn({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colors.borderSubtle),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZenoRadius.md)),
        ),
        child: Text(label,
            style: ZenoTypography.caption(colors.accentPrimary)
                .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1)),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ZenoSemanticColors colors;
  const _FilterChip(
      {required this.label, this.isSelected = false, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : colors.bgTier3,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isSelected
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : colors.borderSubtle),
      ),
      child: Text(label,
          style: ZenoTypography.micro(
                  isSelected ? colors.accentPrimary : colors.textSecondary)
              .copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
