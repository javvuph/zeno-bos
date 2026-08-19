import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/bi_charts_factory.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class CoreAnalyticalRow extends StatelessWidget {
  const CoreAnalyticalRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 340, // Spec: Fixed 340px
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT: REVENUE & PROFIT INTELLIGENCE (65%)
          Expanded(
            flex: 65,
            child: _RevenueIntelligenceChart(),
          ),
          SizedBox(width: 16),
          // RIGHT: AI STRATEGIC INSIGHTS (35%)
          Expanded(
            flex: 35,
            child: _AIStrategicInsights(),
          ),
        ],
      ),
    );
  }
}

class _RevenueIntelligenceChart extends StatelessWidget {
  const _RevenueIntelligenceChart();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2, // Dark Charcoal (#131722)
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
                    "Real-Time Ledger Sync • Updated 2 mins ago",
                    style: TextStyle(fontSize: 10, color: colors.textSecondary),
                  ),
                ],
              ),
              _buildPeriodSelector(colors),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BIChartsFactory.buildSalesTrendChart(
                BIMockData.getSalesTrend()),
          ),
          const SizedBox(height: 12),
          // FOOTER
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
                    _legendItem("🔵 Gross Sales (\$1.48M)",
                        const Color(0xFF3366FF), colors),
                    const SizedBox(width: 16),
                    _legendItem("🔴 Total Expenses (\$1.14M)",
                        const Color(0xFFFF1744), colors),
                    const SizedBox(width: 16),
                    _legendItem(
                        "🟢 Net Profit (\$342K)", const Color(0xFF00C853), colors),
                    const SizedBox(width: 16),
                    _legendItem("📊 Order Volume", colors.textDisabled, colors,
                        isBar: true),
                  ],
                ),
                Text(
                  "🟢 SQL LIVE FEED CONNECTED",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00C853),
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

class _AIStrategicInsights extends StatelessWidget {
  const _AIStrategicInsights();

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
            children: [
              Text(
                "✨ AI STRATEGIC INSIGHTS",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Real-Time Risk Radar",
            style: TextStyle(fontSize: 10, color: colors.textSecondary),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _AICard(
                  tag: "Warning • OpEx Spike",
                  message:
                      "Freight & shipping logistics increased +14% this week.",
                  actionLabel: "OPTIMIZE LOGISTICS ›",
                  color: colors.statusDanger,
                  colors: colors,
                ),
                const SizedBox(height: 12),
                _AICard(
                  tag: "Warning • Stock Depletion",
                  message:
                      "Flagship 'MacBook M3' stock will last only 5 days at current sales velocity.",
                  actionLabel: "RESTOCK NOW ›",
                  color: colors.statusDanger,
                  colors: colors,
                ),
                const SizedBox(height: 12),
                _AICard(
                  tag: "Opportunity • Revenue Growth",
                  message:
                      "Sales increased 18% compared to last month. North branch leads growth.",
                  actionLabel: "VIEW ANALYSIS ›",
                  color: colors.statusSuccess,
                  colors: colors,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "AI Status: Ready",
            style: TextStyle(fontSize: 10, color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _AICard extends StatelessWidget {
  final String tag;
  final String message;
  final String actionLabel;
  final Color color;
  final ZenoSemanticColors colors;

  const _AICard({
    required this.tag,
    required this.message,
    required this.actionLabel,
    required this.color,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.bgTier1, // Deep Obsidian (#0A0A0F)
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(color: color, width: 3), // Spec: left border accent
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              tag.toUpperCase(),
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.w800, color: color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
                fontSize: 11,
                color: colors.textPrimary.withValues(alpha: 0.9),
                height: 1.4),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Text(
              actionLabel,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: colors.accentPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
