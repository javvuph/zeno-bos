part of '../finance_dashboard_screen.dart';

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

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

class _FinanceHeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const _FinanceHeaderButton(
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

class _FinanceMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _FinanceMetric(
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
            Text(label, style: ZenoTypography.bodyMD(colors.textSecondary)),
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

class _ReportRow extends StatelessWidget {
  final String label;
  final String route;
  final ZenoSemanticColors colors;
  const _ReportRow(
      {required this.label, required this.route, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: ZenoTypography.bodyMD(colors.textPrimary)),
      trailing: Icon(Icons.chevron_right, size: 16, color: colors.textDisabled),
      contentPadding: EdgeInsets.zero,
      onTap: () => NavigationController().openTab(route),
    );
  }
}

class _LedgerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final Color color;

  const _LedgerItem({
    required this.title,
    required this.subtitle,
    required this.amount,
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
            width: 4,
            height: 24,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: ZenoTypography.bodyLG(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: ZenoTypography.bodyMD(colors.textSecondary)),
              ],
            ),
          ),
          Text(amount,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}
