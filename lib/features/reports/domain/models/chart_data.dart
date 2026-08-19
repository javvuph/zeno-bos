class ChartDataPoint {
  final String x;
  final double y;
  final Map<String, dynamic> metadata;

  const ChartDataPoint({
    required this.x,
    required this.y,
    this.metadata = const {},
  });
}
