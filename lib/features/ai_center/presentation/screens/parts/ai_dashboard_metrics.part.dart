part of '../ai_dashboard_screen.dart';

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  const _ActionBtn(
      {required this.label, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4)),
        child: Text(label,
            style: ZenoTypography.micro(color)
                .copyWith(fontWeight: FontWeight.bold)),
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

class _AIHeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;

  const _AIHeaderButton(
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
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _AIInsightMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _AIInsightMetric(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label.toUpperCase(),
                style: ZenoTypography.micro(color)
                    .copyWith(fontWeight: FontWeight.w900)),
            Text("${(value * 100).toInt()}%",
                style: ZenoTypography.caption(color).copyWith(
                    fontWeight: FontWeight.w900,
                    fontFamily: ZenoTypography.monoFamily)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

class _ModelStatusItem extends StatelessWidget {
  final String name;
  final String status;
  final IconData icon;
  final Color color;
  final ZenoSemanticColors colors;

  const _ModelStatusItem({
    required this.name,
    required this.status,
    required this.icon,
    required this.color,
    required this.colors,
  });

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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: ZenoTypography.caption(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w900)),
                Text(status,
                    style: ZenoTypography.micro(color)
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.check_circle_outline,
              size: 14, color: color.withValues(alpha: 0.5)),
        ],
      ),
    );
  }
}
