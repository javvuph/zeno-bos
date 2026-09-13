import 'report_filter.dart';

enum ReportModule { executive, sales, inventory, procurement, finance, crm, hr, tax, audit, custom }

enum ReportVisualization { table, pivot, bar, line, area, pie, donut, gauge, funnel, heatmap, kpi }

enum AggregationType { sum, average, count, min, max }

class ReportAggregation {
  final String field;
  final AggregationType type;

  const ReportAggregation({required this.field, required this.type});

  Map<String, dynamic> toJson() => {'field': field, 'type': type.name};
  factory ReportAggregation.fromJson(Map<String, dynamic> json) =>
      ReportAggregation(field: json['field'], type: AggregationType.values.byName(json['type']));
}

class ReportDefinition {
  final String id;
  final String name;
  final String description;
  final ReportModule module;
  final String dataSource;
  final ReportVisualization visualization;
  final List<String> selectedFields;
  final String? groupBy;
  final String? sortBy;
  final bool sortDescending;
  final List<ReportAggregation> aggregations;
  final List<ReportFilter> filters;
  final Map<String, dynamic> visualSettings;
  final String ownerId;
  final bool isPredefined;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReportDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.module,
    required this.dataSource,
    required this.visualization,
    this.selectedFields = const [],
    this.groupBy,
    this.sortBy,
    this.sortDescending = true,
    this.aggregations = const [],
    this.filters = const [],
    this.visualSettings = const {},
    required this.ownerId,
    this.isPredefined = false,
    required this.createdAt,
    required this.updatedAt,
  });
}
