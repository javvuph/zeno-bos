import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/customer_controller.dart';
import '../../domain/models/customer_tier.dart';
import 'customer_form_screen.dart';

part 'parts/customer_dashboard_widgets.part.dart';

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
            const _HeaderButton(
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
                                    ))
                                ,
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
        children: <Widget>[
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
          const _KPIItem(
              label: "AVG. LTV",
              value: "\$1,450",
              icon: Icons.insights_outlined,
              color: Color(0xFF9D50BB)),
          _vDivider(colors),
          const _KPIItem(
              label: "CHURN RISK",
              value: "2.4%",
              icon: Icons.person_off_outlined,
              color: Color(0xFFee0979),
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
