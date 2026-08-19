import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/customer_controller.dart';
import '../../domain/models/customer_tier.dart';
import 'customer_form_screen.dart';

class CustomerDashboardScreen extends StatefulWidget {
  const CustomerDashboardScreen({super.key});

  @override
  State<CustomerDashboardScreen> createState() =>
      _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
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

  void _addCustomer() {
    showDialog(
      context: context,
      builder: (context) => const CustomerFormScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "Customer Intelligence".toUpperCase(),
          subtitle:
              "ANALYZE YOUR CUSTOMER BASE, LOYALTY PERFORMANCE, AND ACQUISITION TRENDS.",
          actions: [
            _HeaderButton(
                label: "Export Database", icon: Icons.download_outlined),
            const SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
              label: "Add Customer",
              icon: Icons.person_add_alt_1,
              isPrimary: true,
              onPressed: _addCustomer,
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
                    // AI CRM Insights
                    Expanded(
                      flex: 2,
                      child: ZenoCard(
                        title: "AI CUSTOMER INSIGHTS",
                        trailing: const Icon(Icons.auto_awesome,
                            size: 16, color: Color(0xFF00F0FF)),
                        child: Column(
                          children: [
                            const _CRMInsightMetric(
                              label: "RETENTION SCORE",
                              value: 0.88,
                              color: Color(0xFF38ef7d),
                            ),
                            const SizedBox(height: ZenoSpacing.lg),
                            const _CRMInsightMetric(
                              label: "LOYALTY ENGAGEMENT",
                              value: 0.74,
                              color: Color(0xFFFFD700),
                            ),
                            const SizedBox(height: ZenoSpacing.xl),
                            AnimatedContainer(
                              duration: ZenoDuration.std,
                              padding: const EdgeInsets.all(ZenoSpacing.md),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00F0FF)
                                    .withValues(alpha: 0.05),
                                borderRadius:
                                    BorderRadius.circular(ZenoRadius.lg),
                                border: Border.all(
                                    color: const Color(0xFF00F0FF)
                                        .withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.lightbulb_outline,
                                      color: Color(0xFF00F0FF), size: 24),
                                  const SizedBox(width: ZenoSpacing.md),
                                  Expanded(
                                    child: Text(
                                      "AI SUGGESTS REACHING OUT TO 'GROUP: VIP' WITH A 10% ANNIVERSARY DISCOUNT. 45 HIGH-VALUE CUSTOMERS HAVE BIRTHDAYS NEXT WEEK.",
                                      style: ZenoTypography.caption(
                                              colors.textPrimary)
                                          .copyWith(
                                              height: 1.5, letterSpacing: 0.2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: ZenoSpacing.lg),

                    // Top Customers
                    Expanded(
                      flex: 1,
                      child: ZenoCard(
                        title: "TOP PERFORMING CLIENTS",
                        child: Column(
                          children: [
                            ...controller.customers
                                .take(3)
                                .map((c) => _CustomerListItem(
                                      name: c.name.toUpperCase(),
                                      info:
                                          "${c.tier.name.toUpperCase()} TIER • \$${c.loyalty.totalSpent.toStringAsFixed(0)} TOTAL",
                                      icon: Icons.account_circle_outlined,
                                      color: c.tier == CustomerTier.vip
                                          ? const Color(0xFFFFD700)
                                          : const Color(0xFF00D2FF),
                                    )),
                            const SizedBox(height: ZenoSpacing.md),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                child: Text("VIEW ALL RANKINGS",
                                    style: ZenoTypography.caption(
                                        colors.accentPrimary)),
                              ),
                            ),
                          ],
                        ),
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
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: [
          _KPIItem(
              label: "TOTAL CUSTOMERS",
              value: controller.customers.length.toString(),
              icon: Icons.people_outline,
              color: const Color(0xFF00D2FF)),
          _vDivider(colors),
          _KPIItem(
              label: "VIP MEMBERS",
              value: controller.vipCount.toString(),
              icon: Icons.card_membership_outlined,
              color: const Color(0xFFFFD700)),
          _vDivider(colors),
          _KPIItem(
              label: "AVG. LTV",
              value: "\$1,450",
              icon: Icons.insights_outlined,
              color: const Color(0xFF9D50BB)),
          _vDivider(colors),
          _KPIItem(
              label: "CHURN RISK",
              value: "2.4%",
              icon: Icons.person_off_outlined,
              color: const Color(0xFFee0979),
              isNegative: true),
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

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isNegative;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      this.isNegative = false});

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

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const _HeaderButton(
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

class _CRMInsightMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _CRMInsightMetric(
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
            Text(label,
                style: TextStyle(fontSize: 12, color: colors.textSecondary)),
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

class _CustomerListItem extends StatelessWidget {
  final String name;
  final String info;
  final IconData icon;
  final Color color;

  const _CustomerListItem({
    required this.name,
    required this.info,
    required this.icon,
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary)),
                Text(info,
                    style:
                        TextStyle(fontSize: 11, color: colors.textSecondary)),
              ],
            ),
          ),
          Icon(Icons.trending_up,
              size: 12, color: const Color(0xFF38ef7d).withValues(alpha: 0.6)),
        ],
      ),
    );
  }
}
