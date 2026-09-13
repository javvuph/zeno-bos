import 'report_filter.dart';

class AnalyticsQuery {
  final String module;
  final List<String> metrics;
  final List<String> dimensions;
  final List<ReportFilter> filters;
  final String? groupBy;
  final List<Map<String, dynamic>> aggregations;

  const AnalyticsQuery({
    required this.module,
    this.metrics = const [],
    this.dimensions = const [],
    required this.filters,
    this.groupBy,
    this.aggregations = const [],
  });
}
