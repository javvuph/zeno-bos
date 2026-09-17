import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/finance_controller.dart';

class FinanceAIHubScreen extends StatefulWidget {
  const FinanceAIHubScreen({super.key});

  @override
  State<FinanceAIHubScreen> createState() => _FinanceAIHubScreenState();
}

class _FinanceAIHubScreenState extends State<FinanceAIHubScreen> {
  final controller = FinanceController(sl<IFinanceRepository>());

  @override
  void initState() {
    super.initState();
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
          title: "AI Financial Hub".toUpperCase(),
          subtitle:
              "SMART CASH FLOW PREDICTION, FRAUD DETECTION, AND GLOBAL BUDGET OPTIMIZATION.",
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
                            Text("LIQUIDITY FORECAST ENGINE",
                                style:
                                    ZenoTypography.headlineMD(ZenoTheme.cyan500)
                                        .copyWith(letterSpacing: 2)),
                            const SizedBox(height: 8),
                            Text(
                                "AI PREDICTS A POTENTIAL CASH CRUNCH IN Q4 DUE TO HIGH PROCUREMENT PROJECTIONS. RECOMMENDATION: RENEGOTIATE PAYMENT TERMS WITH 'GLOBAL ELECTRONICS' TO NET-60.",
                                style:
                                    ZenoTypography.bodyLG(ZenoTheme.textPrimary)
                                        .copyWith(height: 1.6)),
                          ],
                        ),
                      ),
                      const SizedBox(width: ZenoSpacing.xl),
                      const _ActionChip(label: "MITIGATE RISK"),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                const Row(
                  children: [
                    Expanded(
                        child: ZenoStatCard(
                            label: "FORECAST ACCURACY",
                            value: "98.4%",
                            change: "+0.5%",
                            icon: Icons.insights,
                            iconColor: Color(0xFF38ef7d))),
                    SizedBox(width: ZenoSpacing.lg),
                    Expanded(
                        child: ZenoStatCard(
                            label: "FRAUD RISK",
                            value: "NEGLIGIBLE",
                            icon: Icons.security,
                            iconColor: Color(0xFF00FF88))),
                    SizedBox(width: ZenoSpacing.lg),
                    Expanded(
                        child: ZenoStatCard(
                            label: "BUDGET COMPLIANCE",
                            value: "92%",
                            icon: Icons.track_changes,
                            iconColor: Color(0xFFFF9800))),
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
            title: "Anomaly Detection",
            icon: Icons.radar_outlined,
            colors: colors),
        _AIActionCard(
            title: "Tax Optimization",
            icon: Icons.savings_outlined,
            colors: colors),
        _AIActionCard(
            title: "Asset Allocation",
            icon: Icons.account_balance_outlined,
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
