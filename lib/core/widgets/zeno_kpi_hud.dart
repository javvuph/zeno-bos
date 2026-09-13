import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoKpiData {
  final String label;
  final String value;
  final String? change;
  final bool isPositive;
  final IconData icon;
  final Color? color;

  const ZenoKpiData({
    required this.label,
    required this.value,
    this.change,
    this.isPositive = true,
    required this.icon,
    this.color,
  });
}

/// ZenoKpiHud v2.1
/// Ultra high-density tactical metrics bar with integrated trend visualization.
class ZenoKpiHud extends StatelessWidget {
  final List<ZenoKpiData> metrics;

  const ZenoKpiHud({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 80, // Even more compact for operational speed
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: ZenoBorderWidth.hairline,
          ),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl),
        itemCount: metrics.length,
        separatorBuilder: (_, __) => Container(
          width: 1,
          margin: const EdgeInsets.symmetric(vertical: 20),
          color: colors.borderSubtle.withValues(alpha: 0.3),
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
          child: _buildMetric(metrics[index], colors),
        ),
      ),
    );
  }

  Widget _buildMetric(ZenoKpiData data, ZenoSemanticColors colors) {
    final Color accent = data.color ?? colors.accentPrimary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(ZenoSpacing.sm),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(ZenoRadius.sm),
          ),
          child: Icon(data.icon, color: accent, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data.label.toUpperCase(),
              style: ZenoTypography.micro(colors.textSecondary)
                  .copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  data.value,
                  style: ZenoTypography.headlineSM(colors.textPrimary).copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    fontFamily: ZenoTypography.monoFamily,
                  ),
                ),
                if (data.change != null) ...[
                  const SizedBox(width: 8),
                  _buildTrend(data, colors),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrend(ZenoKpiData data, ZenoSemanticColors colors) {
    final Color trendColor =
        data.isPositive ? colors.statusSuccess : colors.statusDanger;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: trendColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            data.isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
            size: 10,
            color: trendColor,
          ),
          const SizedBox(width: 2),
          Text(
            data.change!,
            style: ZenoTypography.micro(trendColor).copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
