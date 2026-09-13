import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class AIBusinessInsightsSection extends StatelessWidget {
  const AIBusinessInsightsSection({super.key});

  static const _insights = [
    {
      "type": "Warning",
      "title": "Stock Depletion",
      "message":
          "Flagship 'MacBook M3' stock will last only 5 days at current velocity.",
      "color": Colors.red,
      "action": "Restock Now"
    },
    {
      "type": "Opportunity",
      "title": "Revenue Growth",
      "message":
          "Sales increased 18% compared to last month. North branch leads growth.",
      "color": ZenoTheme.neonGreen,
      "action": "View Analysis"
    },
    {
      "type": "Optimization",
      "title": "Expense Alert",
      "message":
          "Logistics costs are 12% above budget due to fuel surcharge spikes.",
      "color": Colors.orange,
      "action": "Optimize Routes"
    },
    {
      "type": "Prediction",
      "title": "Weekend Surge",
      "message":
          "Expected 25% increase in online orders this weekend based on historical trends.",
      "color": ZenoTheme.neonCyan,
      "action": "Prepare Logistics"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "AI Strategic Insights",
      accentColor: ZenoTheme.neonGreen,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _insights.length,
        itemBuilder: (context, index) {
          final item = _insights[index];
          return _buildInsightCard(item);
        },
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> item) {
    final Color color = item['color'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(4)),
                child: Text(item['type'].toUpperCase(),
                    style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              const SizedBox(width: 8),
              Text(item['title'],
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: color)),
              const Spacer(),
              const Icon(Icons.auto_awesome,
                  size: 12, color: ZenoTheme.textSecondary),
            ],
          ),
          const SizedBox(height: 8),
          Text(item['message'],
              style: const TextStyle(
                  fontSize: 11, color: ZenoTheme.textPrimary, height: 1.4)),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(item['action'].toUpperCase(),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color)),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 8, color: color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
