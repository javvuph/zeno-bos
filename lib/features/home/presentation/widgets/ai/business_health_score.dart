import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class BusinessHealthScoreGrid extends StatelessWidget {
  const BusinessHealthScoreGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final scores = BIMockData.getBusinessHealthScores();
    if (scores.isEmpty) return const SizedBox.shrink();
    final entries = scores.entries.toList();

    return BISectionContainer(
      title: "Business Health Score Matrix",
      accentColor: ZenoTheme.neonCyan,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
        ),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          if (index >= entries.length) return const SizedBox.shrink();
          final key = entries[index].key;
          final value = entries[index].value;
          return _buildScoreCard(key, value);
        },
      ),
    );
  }

  Widget _buildScoreCard(String label, double score) {
    Color color = _getScoreColor(label, score);
    String status = _getScoreStatus(label, score);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ZenoTheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha: 0.05),
              blurRadius: 4,
              spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: ZenoTheme.textSecondary,
                      letterSpacing: 0.5)),
              Icon(_getIconForLabel(label), size: 12, color: color),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${score.toInt()}%",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900, color: color)),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(status,
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: color.withValues(alpha: 0.7))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(String label, double score) {
    if (label == 'Risk') {
      if (score < 15) return ZenoTheme.neonGreen;
      if (score < 30) return Colors.orange;
      return Colors.red;
    }
    if (score >= 90) return ZenoTheme.neonCyan;
    if (score >= 80) return ZenoTheme.neonGreen;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  String _getScoreStatus(String label, double score) {
    if (label == 'Risk') {
      if (score < 15) return "Minimal";
      if (score < 30) return "Moderate";
      return "High";
    }
    if (score >= 90) return "Excellent";
    if (score >= 80) return "Good";
    if (score >= 60) return "Average";
    return "Critical";
  }

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Overall':
        return Icons.analytics;
      case 'Sales':
        return Icons.trending_up;
      case 'Finance':
        return Icons.account_balance;
      case 'Inventory':
        return Icons.inventory_2;
      case 'Customer':
        return Icons.people;
      case 'Operations':
        return Icons.settings_applications;
      case 'Delivery':
        return Icons.local_shipping;
      case 'HR':
        return Icons.badge;
      case 'Supplier':
        return Icons.business;
      case 'Risk':
        return Icons.warning_amber;
      case 'Growth':
        return Icons.show_chart;
      default:
        return Icons.info_outline;
    }
  }
}
