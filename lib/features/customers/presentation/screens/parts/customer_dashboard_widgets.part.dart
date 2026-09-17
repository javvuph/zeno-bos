part of '../customer_dashboard_screen.dart';

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isNegative;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      this.isNegative = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
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
  final VoidCallback? onPressed;

  const _HeaderButton(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgSurface,
        foregroundColor: colors.textPrimary,
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _CRMInsightMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _CRMInsightMetric(
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
            Text(label,
                style: TextStyle(fontSize: 12, color: colors.textSecondary)),
            Text("${(value * 100).toInt()}%",
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: color)),
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

class _CustomerListItem extends StatelessWidget {
  final String name;
  final String info;
  final IconData icon;
  final Color color;

  const _CustomerListItem({
    required this.name,
    required this.info,
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
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary)),
                Text(info,
                    style:
                        TextStyle(fontSize: 11, color: colors.textSecondary)),
              ],
            ),
          ),
          Icon(Icons.trending_up,
              size: 12, color: const Color(0xFF38ef7d).withValues(alpha: 0.6)),
        ],
      ),
    );
  }
}
