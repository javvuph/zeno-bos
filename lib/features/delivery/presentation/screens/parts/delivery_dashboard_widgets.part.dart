part of '../delivery_dashboard_screen.dart';

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

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;

  const _HeaderButton(
      {required this.label, required this.icon, this.isPrimary = false});

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _DispatchMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _DispatchMetric(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: ZenoTypography.micro(colors.textSecondary)),
            Text("${(value * 100).toInt()}%",
                style: ZenoTypography.micro(color)
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}

class _AgentStatusItem extends StatelessWidget {
  final String name;
  final String status;
  final IconData icon;
  final Color color;

  const _AgentStatusItem({
    required this.name,
    required this.status,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: ZenoTypography.bodyMD(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(status,
                    style: ZenoTypography.micro(color.withValues(alpha: 0.8))
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.location_on_outlined,
              size: 12, color: colors.textSecondary),
        ],
      ),
    );
  }
}
