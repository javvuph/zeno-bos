import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/administration_controller.dart';

class AIAdministrationHubScreen extends StatefulWidget {
  const AIAdministrationHubScreen({super.key});

  @override
  State<AIAdministrationHubScreen> createState() =>
      _AIAdministrationHubScreenState();
}

class _AIAdministrationHubScreenState extends State<AIAdministrationHubScreen> {
  late final AdministrationController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<AdministrationController>();
    controller.addListener(_onUpdate);
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
          title: "AI Administration".toUpperCase(),
          subtitle:
              "GLOBAL CONTROL OF AI PERMISSIONS, USAGE AUDITS, AND NEURAL ENGINE COST MONITORING.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: ZenoDuration.std,
                  padding: const EdgeInsets.all(ZenoSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: ZenoTheme.aiGlowGradient.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ZenoRadius.xl),
                    border: Border.all(
                        color: ZenoTheme.cyan500.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                          color: ZenoTheme.cyan500.withValues(alpha: 0.05),
                          blurRadius: 40,
                          offset: const Offset(0, 20)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: ZenoTheme.cyan500, size: 48),
                      const SizedBox(width: ZenoSpacing.xl),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ENTERPRISE NEURAL ENGINE",
                                style:
                                    ZenoTypography.headlineMD(ZenoTheme.cyan500)
                                        .copyWith(letterSpacing: 2)),
                            const SizedBox(height: 8),
                            Text(
                                "AI IS ACTIVELY MONITORING 142 SESSIONS FOR ANOMALIES. ALL MODULES ARE INHERITING GLOBAL PERMISSION SETS. NO SECURITY RISKS DETECTED.",
                                style:
                                    ZenoTypography.bodyLG(ZenoTheme.textPrimary)
                                        .copyWith(height: 1.6)),
                          ],
                        ),
                      ),
                      const SizedBox(width: ZenoSpacing.xl),
                      const _ActionChip(label: "SYSTEM AUDIT"),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                const Row(
                  children: [
                    Expanded(
                        child: ZenoStatCard(
                            label: "AI UPTIME",
                            value: "99.98%",
                            icon: Icons.cloud_done_outlined,
                            iconColor: Color(0xFF00FF88))),
                    SizedBox(width: ZenoSpacing.lg),
                    Expanded(
                        child: ZenoStatCard(
                            label: "AVG. ACCURACY",
                            value: "96.4%",
                            icon: Icons.check_circle_outline,
                            iconColor: Color(0xFF00F0FF))),
                    SizedBox(width: ZenoSpacing.lg),
                    Expanded(
                        child: ZenoStatCard(
                            label: "TOKEN SPEND",
                            value: "\$1,240",
                            change: "-5%",
                            isPositive: true,
                            icon: Icons.payments_outlined,
                            iconColor: Color(0xFFFFD700))),
                  ],
                ),
                const SizedBox(height: ZenoSpacing.xl),
                _buildIntelligenceGrid(colors),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIntelligenceGrid(ZenoSemanticColors colors) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: ZenoSpacing.lg,
      mainAxisSpacing: ZenoSpacing.lg,
      childAspectRatio: 2.5,
      children: [
        _AIActionCard(
            title: "Model Config",
            icon: Icons.settings_input_component_outlined,
            colors: colors),
        _AIActionCard(
            title: "Usage Reports",
            icon: Icons.bar_chart_outlined,
            colors: colors),
        _AIActionCard(
            title: "Cost Control",
            icon: Icons.request_quote_outlined,
            colors: colors),
      ],
    );
  }
}

class _AIActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ZenoSemanticColors colors;
  const _AIActionCard(
      {required this.title, required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 20, color: colors.accentPrimary),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
              child: Text(title.toUpperCase(),
                  style: ZenoTypography.caption(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.w900))),
          Icon(Icons.chevron_right, size: 14, color: colors.textDisabled),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  const _ActionChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg, vertical: 10),
      decoration: BoxDecoration(
        color: colors.accentPrimary,
        borderRadius: BorderRadius.circular(ZenoRadius.full),
        boxShadow: [
          BoxShadow(
              color: colors.accentPrimary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Text(label,
          style: ZenoTypography.caption(Colors.black)
              .copyWith(fontWeight: FontWeight.w900)),
    );
  }
}
