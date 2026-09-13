import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class MarginData {
  final String category;
  final double revenue;
  final double cost;
  final double margin;

  MarginData(
      {required this.category,
      required this.revenue,
      required this.cost,
      required this.margin});
}

class MarginAnalysisScreen extends StatelessWidget {
  const MarginAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MarginData> items = [
      MarginData(
          category: "Electronics", revenue: 450000, cost: 320000, margin: 28.8),
      MarginData(
          category: "Fashion", revenue: 120000, cost: 45000, margin: 62.5),
      MarginData(
          category: "Accessories", revenue: 85000, cost: 22000, margin: 74.1),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Margin Analysis",
          subtitle:
              "Analyze profitability across categories and product lines.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: ZenoStatCard(
                        label: "Average Margin",
                        value: "34.5%",
                        change: "+2.1%",
                        icon: Icons.trending_up,
                        iconColor: ZenoTheme.success,
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: ZenoStatCard(
                        label: "Gross Profit",
                        value: "\$412.5K",
                        change: "+15.2%",
                        icon: Icons.account_balance_wallet_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ZenoCard(
                  title: "PROFITABILITY BY CATEGORY",
                  child: ZenoTable<MarginData>(
                    items: items,
                    columns: [
                      ZenoTableColumn(
                        label: "Category",
                        builder: (m) => Text(m.category,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ZenoTableColumn(
                        label: "Revenue",
                        isNumeric: true,
                        builder: (m) =>
                            Text("\$${m.revenue.toStringAsFixed(0)}"),
                      ),
                      ZenoTableColumn(
                        label: "Cost",
                        isNumeric: true,
                        builder: (m) => Text("\$${m.cost.toStringAsFixed(0)}"),
                      ),
                      ZenoTableColumn(
                        label: "Margin %",
                        isNumeric: true,
                        builder: (m) => Text("${m.margin}%",
                            style: TextStyle(
                                color: m.margin > 50
                                    ? ZenoTheme.success
                                    : ZenoTheme.warning,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
