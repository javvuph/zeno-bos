import 'package:flutter/material.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import 'package:zeno/core/database/collections/finance_collections.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:isar/isar.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/bi_charts_factory.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

part 'parts/core_analytical_insights.part.dart';

class CoreAnalyticalRow extends StatelessWidget {
  const CoreAnalyticalRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 340,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 65,
            child: _RevenueIntelligenceChart(),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 35,
            child: _AIStrategicInsights(),
          ),
        ],
      ),
    );
  }
}

class _RevenueIntelligenceChart extends StatefulWidget {
  const _RevenueIntelligenceChart();

  @override
  State<_RevenueIntelligenceChart> createState() => _RevenueIntelligenceChartState();
}

class _RevenueIntelligenceChartState extends State<_RevenueIntelligenceChart> {
  List<SalesPoint> _points = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = sl<DatabaseService>().isar;
    final end = DateTime.now();
    final start = DateTime(end.year, end.month, end.day).subtract(const Duration(days: 29));
    final orders = await db.collection<SalesOrderCollection>()
        .filter().dateBetween(start, end).statusEqualTo('completed').findAll();
    final expenses = await db.collection<ExpenseCollection>()
        .filter().dateBetween(start, end).findAll();

    final points = <SalesPoint>[];
    for (var i = 0; i < 30; i++) {
      final day = DateTime(start.year, start.month, start.day + i);
      final next = day.add(const Duration(days: 1));
      final revenue = orders.where((o) => !o.date.isBefore(day) && o.date.isBefore(next))
          .fold<double>(0, (sum, o) => sum + o.totalAmount);
      final expense = expenses.where((e) => !e.date.isBefore(day) && e.date.isBefore(next))
          .fold<double>(0, (sum, e) => sum + e.amount);
      points.add(SalesPoint(day, revenue, expense, revenue - expense));
    }

    if (mounted) setState(() => _points = points);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ENTERPRISE REVENUE & PROFIT INTELLIGENCE",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Real-time Billing + Finance • Last 30 days",
                    style: TextStyle(fontSize: 10, color: colors.textSecondary),
                  ),
                ],
              ),
              _buildPeriodSelector(colors),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BIChartsFactory.buildSalesTrendChart(_points),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.bgTier1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _legendItem("🔵 Gross Sales",
                        const Color(0xFF3366FF), colors),
                    const SizedBox(width: 16),
                    _legendItem("🔴 Recorded Expenses",
                        const Color(0xFFFF1744), colors),
                    const SizedBox(width: 16),
                    _legendItem(
                        "🟢 Operating Result", const Color(0xFF00C853), colors),
                    const SizedBox(width: 16),
                    _legendItem("📊 Order Volume", colors.textDisabled, colors,
                        isBar: true),
                  ],
                ),
                const Text(
                  "🟢 LIVE BILLING + FINANCE FEED",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00C853),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color, ZenoSemanticColors colors,
      {bool isBar = false}) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: isBar ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isBar ? BorderRadius.circular(1) : null,
            boxShadow: [
              if (!isBar)
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
              fontSize: 10, color: colors.textSecondary, fontFamily: 'Inter'),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          _periodTab("Daily", false, colors),
          _periodTab("Weekly", true, colors),
          _periodTab("Monthly", false, colors),
          _periodTab("YTD", false, colors),
        ],
      ),
    );
  }

  Widget _periodTab(String label, bool active, ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: active
            ? colors.accentPrimary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: active ? colors.accentPrimary : colors.textSecondary,
        ),
      ),
    );
  }
}
