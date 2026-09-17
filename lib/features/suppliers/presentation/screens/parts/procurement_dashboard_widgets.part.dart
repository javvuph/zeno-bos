part of '../procurement_dashboard_screen.dart';

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

class _InsightRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _InsightRow(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: ZenoTypography.caption(colors.textSecondary)),
        Text(value,
            style: ZenoTypography.bodyLG(color)
                .copyWith(fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _HeaderButton(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
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

class _ReplenishItem extends StatelessWidget {
  final String product;
  final int qty;
  final String urgency;
  final Color color;
  final ZenoSemanticColors colors;

  const _ReplenishItem(
      {required this.product,
      required this.qty,
      required this.urgency,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.md),
      child: AnimatedContainer(
        duration: ZenoDuration.fast,
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
          color: colors.bgTier3.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: colors.bgTier4, shape: BoxShape.circle),
              child: Icon(Icons.inventory_2_outlined,
                  size: 16, color: colors.textDisabled),
            ),
            const SizedBox(width: ZenoSpacing.lg),
            Expanded(
                child: Text(product.toUpperCase(),
                    style: ZenoTypography.bodyMD(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold))),
            Text("QTY: $qty",
                style: ZenoTypography.micro(colors.textSecondary)),
            const SizedBox(width: ZenoSpacing.xl),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.2))),
              child: Text(urgency,
                  style: ZenoTypography.micro(color)
                      .copyWith(fontWeight: FontWeight.w900)),
            ),
            const SizedBox(width: ZenoSpacing.md),
            Icon(Icons.chevron_right, size: 16, color: colors.textDisabled),
          ],
        ),
      ),
    );
  }
}
