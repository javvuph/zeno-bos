class AIPrediction {
  final String id;
  final String targetMetric;
  final double forecastValue;
  final double currentValue;
  final String timeframe; // e.g., "Next 30 Days"
  final double confidence;
  final List<double> historicalTrend;
  final String insight;

  const AIPrediction({
    required this.id,
    required this.targetMetric,
    required this.forecastValue,
    required this.currentValue,
    required this.timeframe,
    required this.confidence,
    required this.historicalTrend,
    required this.insight,
  });

  double get growthRate =>
      ((forecastValue - currentValue) / currentValue) * 100;
}
