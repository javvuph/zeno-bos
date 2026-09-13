import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/customer_controller.dart';

class CustomerAIHubScreen extends StatefulWidget {
  const CustomerAIHubScreen({super.key});

  @override
  State<CustomerAIHubScreen> createState() => _CustomerAIHubScreenState();
}

class _CustomerAIHubScreenState extends State<CustomerAIHubScreen> {
  final controller = CustomerController(sl<ICustomerRepository>());

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
          title: "AI CRM Center".toUpperCase(),
          subtitle:
              "PREDICTIVE BEHAVIOR ANALYSIS AND PERSONALIZED MARKETING INTELLIGENCE.",
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
                            Text("CHURN PREDICTION ENGINE",
                                style:
                                    ZenoTypography.headlineMD(ZenoTheme.cyan500)
                                        .copyWith(letterSpacing: 2)),
                            const SizedBox(height: 8),
                            Text(
                                "AI IDENTIFIED 12 VIP CUSTOMERS WHO HAVEN'T VISITED IN 30 DAYS. HIGH PROBABILITY OF CHURN DETECTED FOR SEGMENT: CORPORATE.",
                                style:
                                    ZenoTypography.bodyLG(ZenoTheme.textPrimary)
                                        .copyWith(height: 1.6)),
                          ],
                        ),
                      ),
                      const SizedBox(width: ZenoSpacing.xl),
                      const _ActionChip(label: "LAUNCH RETENTION FLOW"),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                Row(
                  children: [
                    const Expanded(
                        child: ZenoStatCard(
                            label: "RETENTION SCORE",
                            value: "94%",
                            change: "+2%",
                            icon: Icons.online_prediction,
                            iconColor: Color(0xFF00FF88))),
                    const SizedBox(width: ZenoSpacing.lg),
                    const Expanded(
                        child: ZenoStatCard(
                            label: "SEGMENT CLARITY",
                            value: "OPTIMAL",
                            icon: Icons.pie_chart_outline,
                            iconColor: Color(0xFFFFD700))),
                    const SizedBox(width: ZenoSpacing.lg),
                    const Expanded(
                        child: ZenoStatCard(
                            label: "ACQUISITION COST",
                            value: "\$14.2",
                            change: "-5%",
                            icon: Icons.savings_outlined,
                            iconColor: Color(0xFF00D2FF))),
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
            title: "Behavioral Scoring",
            icon: Icons.psychology_outlined,
            colors: colors),
        _AIActionCard(
            title: "Next Purchase Prediction",
            icon: Icons.shopping_cart_checkout,
            colors: colors),
        _AIActionCard(
            title: "Auto-Segmentation",
            icon: Icons.group_work_outlined,
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
