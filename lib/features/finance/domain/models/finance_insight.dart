enum InsightTrend { positive, negative, stable }

enum InsightPriority { low, medium, high, critical }

class FinanceIntelligenceInsight {
  final String id;
  final String title;
  final String description;
  final String category; // Liquidity, Profitability, Compliance, Efficiency
  final double value;
  final String unit;
  final InsightTrend trend;
  final InsightPriority priority;
  final String recommendation;

  const FinanceIntelligenceInsight({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.value,
    required this.unit,
    required this.trend,
    required this.priority,
    required this.recommendation,
  });
}
