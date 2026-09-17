part of '../ai_dashboard_screen.dart';

class _ContextNodeItem extends StatelessWidget {
  final String module;
  final String status;
  final ZenoSemanticColors colors;
  const _ContextNodeItem(
      {required this.module, required this.status, required this.colors});

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
          const Icon(Icons.hub_outlined, size: 14, color: Color(0xFF00F0FF)),
          const SizedBox(width: 12),
          Expanded(
              child: Text(module,
                  style: ZenoTypography.micro(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.bold))),
          Text(status,
              style: ZenoTypography.micro(const Color(0xFF00FF88))
                  .copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  final dynamic recommendation;
  final ZenoSemanticColors colors;
  const _RecommendationItem(
      {required this.recommendation, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.lg),
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(
            color: recommendation.impactColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: recommendation.impactColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(recommendation.impact.name.toUpperCase(),
                    style: ZenoTypography.micro(recommendation.impactColor)
                        .copyWith(fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(recommendation.title.toUpperCase(),
                      style: ZenoTypography.caption(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.w900))),
              Text("${(recommendation.confidence * 100).toInt()}% CONFIDENCE",
                  style: ZenoTypography.micro(colors.textDisabled)),
            ],
          ),
          const SizedBox(height: 12),
          Text(recommendation.description,
              style: ZenoTypography.bodyMD(colors.textSecondary)),
          const SizedBox(height: 16),
          Row(
            children: [
              _ActionBtn(
                label: "EXECUTE ACTION",
                color: colors.accentPrimary,
                onPressed: () => NavigationController()
                    .navigateTo(recommendation.suggestedAction['route']),
              ),
              const SizedBox(width: ZenoSpacing.md),
              _ActionBtn(
                label: "EXPLAIN WHY",
                color: colors.textDisabled,
                onPressed: () => _showExplanation(context, recommendation),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showExplanation(BuildContext context, dynamic rec) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.bgTier1,
        title: Text("RECOMMENDATION LOGIC",
            style: ZenoTypography.headlineSM(colors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("REASONING",
                style: ZenoTypography.micro(colors.accentPrimary)
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(rec.reasoning,
                style: ZenoTypography.bodyMD(colors.textSecondary)),
            const SizedBox(height: 16),
            Text("DATA SOURCES",
                style: ZenoTypography.micro(colors.accentPrimary)
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: (rec.dataUsed as List<String>)
                  .map((d) =>
                      Chip(label: Text(d), backgroundColor: colors.bgTier3))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PredictionCard extends StatelessWidget {
  final dynamic prediction;
  final ZenoSemanticColors colors;
  const _PredictionCard({required this.prediction, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border: Border.all(color: colors.borderSubtle)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prediction.targetMetric.toUpperCase(),
              style: ZenoTypography.micro(colors.textDisabled)
                  .copyWith(letterSpacing: 1)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$${(prediction.forecastValue / 1000).toStringAsFixed(1)}K",
                  style: ZenoTypography.displayLG(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(width: 8),
              Text(
                  "${prediction.growthRate > 0 ? '+' : ''}${prediction.growthRate.toStringAsFixed(1)}%",
                  style: ZenoTypography.caption(prediction.growthRate > 0
                          ? const Color(0xFF00FF88)
                          : Colors.red)
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Text(prediction.timeframe.toUpperCase(),
              style: ZenoTypography.micro(colors.accentPrimary)),
        ],
      ),
    );
  }
}
