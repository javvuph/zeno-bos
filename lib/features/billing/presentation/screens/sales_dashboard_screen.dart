import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/orders/domain/repositories/i_sales_repository.dart';
import 'package:zeno/features/orders/presentation/controllers/sales_controller.dart';

class SalesDashboardScreen extends StatefulWidget {
  const SalesDashboardScreen({super.key});

  @override
  State<SalesDashboardScreen> createState() => _SalesDashboardScreenState();
}

class _SalesDashboardScreenState extends State<SalesDashboardScreen> {
  final controller = SalesController(sl<ISalesRepository>());

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
          title: "Sales Intelligence".toUpperCase(),
          subtitle:
              "COMPREHENSIVE OVERVIEW OF GLOBAL REVENUE, TRANSACTION VOLUME, AND FISCAL PERFORMANCE.",
          actions: [
            _HeaderButton(
                label: "Export PDF", icon: Icons.picture_as_pdf_outlined),
            const SizedBox(width: ZenoSpacing.md),
            _HeaderButton(label: "New Bill", icon: Icons.add, isPrimary: true),
          ],
        ),
        // STICKY KPI SUMMARY
        _buildStickyKPI(colors),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Insights
                    Expanded(
                      flex: 2,
                      child: ZenoCard(
                        title: "AI BILLING INSIGHTS",
                        trailing: const Icon(Icons.auto_awesome,
                            size: 16, color: Color(0xFF00F0FF)),
                        child: Column(
                          children: [
                            const _InsightMetric(
                              label: "CROSS-SELL EFFECTIVENESS",
                              value: 0.78,
                              color: Color(0xFF00FF88),
                            ),
                            const SizedBox(height: ZenoSpacing.lg),
                            const _InsightMetric(
                              label: "UPSELL SUCCESS RATE",
                              value: 0.62,
                              color: Color(0xFF00F0FF),
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
                                  const Icon(Icons.psychology_outlined,
                                      color: Color(0xFF00F0FF), size: 24),
                                  const SizedBox(width: ZenoSpacing.md),
                                  Expanded(
                                    child: Text(
                                      "AI DETECTED A 15% INCREASE IN EVENING SALES. WE RECOMMEND TRIGGERING 'SMART DISCOUNTS' FOR LUNCH-TIME SNACKS TO BALANCE TRAFFIC.",
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

                    // Sales Feed
                    Expanded(
                      flex: 1,
                      child: ZenoCard(
                        title: "LIVE SALES FEED",
                        child: Column(
                          children: [
                            ...controller.orders.take(3).map((o) => _SaleItem(
                                  customer: o.customerId.toUpperCase(),
                                  amount:
                                      "\$${o.totalAmount.toStringAsFixed(2)}",
                                  time: "JUST NOW",
                                  icon: Icons.shopping_cart_outlined,
                                  color: const Color(0xFF00FF88),
                                )),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {},
                              child: Text("VIEW FULL HISTORY",
                                  style: ZenoTypography.caption(
                                      colors.accentPrimary)),
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
              label: "TOTAL REVENUE",
              value: "\$${controller.totalSalesVolume.toStringAsFixed(0)}",
              icon: Icons.payments_outlined,
              color: const Color(0xFF00FF88)),
          _vDivider(colors),
          _KPIItem(
              label: "TRANSACTIONS",
              value: controller.activeOrderCount.toString(),
              icon: Icons.receipt_long_outlined,
              color: const Color(0xFFFFD700)),
          _vDivider(colors),
          _KPIItem(
              label: "AVG. BILL VALUE",
              value: "\$36.50",
              icon: Icons.shopping_bag_outlined,
              color: const Color(0xFF6a11cb)),
          _vDivider(colors),
          _KPIItem(
              label: "RETURN RATE",
              value: "0.8%",
              icon: Icons.assignment_return_outlined,
              color: const Color(0xFFFF4B2B)),
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
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

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

  const _HeaderButton(
      {required this.label, required this.icon, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: () {},
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
      ),
    );
  }
}

class _InsightMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _InsightMetric(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: ZenoTypography.micro(color)),
            Text("${(value * 100).toInt()}%",
                style: ZenoTypography.caption(color)
                    .copyWith(fontWeight: FontWeight.bold)),
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

class _SaleItem extends StatelessWidget {
  final String customer;
  final String amount;
  final String time;
  final IconData icon;
  final Color color;

  const _SaleItem({
    required this.customer,
    required this.amount,
    required this.time,
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
                Text(customer,
                    style: ZenoTypography.bodyMD(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(amount,
                    style: ZenoTypography.micro(color)
                        .copyWith(fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          Text(time, style: ZenoTypography.micro(colors.textDisabled)),
        ],
      ),
    );
  }
}
