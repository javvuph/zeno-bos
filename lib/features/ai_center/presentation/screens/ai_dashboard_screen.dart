import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../controllers/ai_controller.dart';

part 'parts/ai_dashboard_widgets.part.dart';
part 'parts/ai_dashboard_metrics.part.dart';

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
                          const ZenoCard(
                            title: "AI STRATEGIC PULSE",
                            child: Column(
                              children: [
                                _AIInsightMetric(
                                  label: "RETENTION SCORE",
                                  value: 0.88,
                                  color: Color(0xFF38ef7d),
                                ),
                                SizedBox(height: ZenoSpacing.lg),
                                _AIInsightMetric(
                                  label: "LOYALTY ENGAGEMENT",
                                  value: 0.74,
                                  color: Color(0xFFFFD700),
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
