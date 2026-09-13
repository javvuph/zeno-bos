import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../controllers/ai_controller.dart';

class AIDashboardScreen extends StatefulWidget {
  const AIDashboardScreen({super.key});

  @override
  State<AIDashboardScreen> createState() => _AIDashboardScreenState();
}

class _AIDashboardScreenState extends State<AIDashboardScreen> {
  late final AIController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<AIController>();
    controller.addListener(_onUpdate);
    controller.refreshIntelligence();
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "AI Command Center".toUpperCase(),
          subtitle:
              "MASTER CONTROL FOR NEURAL NETWORKS, PREDICTIVE ANALYTICS, AND SYSTEM-WIDE AUTOMATIONS.",
          actions: [
            _AIHeaderButton(
              label: "MODEL HEALTH",
              icon: Icons.monitor_heart_outlined,
              colors: colors,
              onPressed: () =>
                  NavigationController().navigateTo('ai/reports/summary'),
            ),
            const SizedBox(width: ZenoSpacing.md),
            _AIHeaderButton(
              label: "AI WORKSPACE",
              icon: Icons.workspaces_outlined,
              isPrimary: true,
              colors: colors,
              onPressed: () =>
                  NavigationController().navigateTo('ai/command/assistant'),
            ),
          ],
        ),
        // STICKY KPI SUMMARY
        _buildStickyKPI(colors),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Intelligence Feed & Recommendations
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ZenoCard(
                            title: "EXECUTIVE RECOMMENDATIONS",
                            trailing: Text(
                                "${controller.recommendations.length} ACTIONABLE"),
                            child: controller.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Column(
                                    children: [
                                      ...controller.recommendations.map((r) =>
                                          _RecommendationItem(
                                              recommendation: r,
                                              colors: colors)),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "AI STRATEGIC PULSE",
                            child: Column(
                              children: [
                                _AIInsightMetric(
                                  label: "RETENTION SCORE",
                                  value: 0.88,
                                  color: const Color(0xFF38ef7d),
                                ),
                                const SizedBox(height: ZenoSpacing.lg),
                                _AIInsightMetric(
                                  label: "LOYALTY ENGAGEMENT",
                                  value: 0.74,
                                  color: const Color(0xFFFFD700),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "PREDICTIVE ANALYTICS",
                            child: controller.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: ZenoSpacing.lg,
                                    mainAxisSpacing: ZenoSpacing.lg,
                                    childAspectRatio: 2.2,
                                    children: [
                                      ...controller.predictions.map((p) =>
                                          _PredictionCard(
                                              prediction: p, colors: colors)),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: ZenoSpacing.lg),

                    // Model Status & Context
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ZenoCard(
                            title: "SYSTEM CONTEXT NODES",
                            child: Column(
                              children: [
                                ...controller.lastGlobalContext.keys
                                    .where((k) => k != 'error')
                                    .map((k) => _ContextNodeItem(
                                          module: k.toUpperCase(),
                                          status: "INTEGRATED",
                                          colors: colors,
                                        )),
                              ],
                            ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "MODEL ECOSYSTEM",
                            child: Column(
                              children: [
                                ...controller.models
                                    .take(3)
                                    .map((m) => _ModelStatusItem(
                                          name: m.name.toUpperCase(),
                                          status: m.isEnabled
                                              ? "ACTIVE • PRIMARY"
                                              : "STANDBY",
                                          icon: Icons.bolt,
                                          color: const Color(0xFF00F0FF),
                                          colors: colors,
                                        )),
                                const SizedBox(height: ZenoSpacing.md),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () => NavigationController()
                                        .navigateTo('ai/reports/summary'),
                                    child: Text("MANAGE NEURAL WEIGHTS",
                                        style: ZenoTypography.caption(
                                            colors.accentPrimary)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ZenoSpacing.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyKPI(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _KPIItem(
              label: "AI HEALTH",
              value: "${(controller.healthScore * 100).toStringAsFixed(1)}%",
              icon: Icons.health_and_safety_outlined,
              color: const Color(0xFF00FF88),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "CONFIDENCE",
              value:
                  "${(controller.confidenceScore * 100).toStringAsFixed(1)}%",
              icon: Icons.verified_user_outlined,
              color: const Color(0xFF00F0FF),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "AVG RESPONSE",
              value: "${controller.avgResponseTime}S",
              icon: Icons.timer_outlined,
              color: const Color(0xFF00D2FF),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "MONTHLY COST",
              value: "\$${controller.totalMonthlyCost.toStringAsFixed(0)}",
              icon: Icons.attach_money_outlined,
              color: const Color(0xFFFFD700),
              colors: colors),
        ],
      ),
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 32,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl));
}

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
