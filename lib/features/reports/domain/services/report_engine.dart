import '../models/report_definition.dart';
import '../models/chart_data.dart';
import '../repositories/i_reports_repository.dart';
import '../models/analytics_query.dart';

class ReportEngine {
  final IReportsRepository _repository;

  ReportEngine(this._repository);

  Future<List<Map<String, dynamic>>> getReportData(ReportDefinition report) async {
    final query = AnalyticsQuery(
      module: report.module.name,
      metrics: report.aggregations.map((a) => a.field).toList(),
      dimensions: report.selectedFields,
      filters: report.filters,
      groupBy: report.groupBy,
      aggregations: report.aggregations.map((a) => a.toJson()).toList(),
    );

    final rawData = await _repository.executeQuery(query);
    
    return rawData.map((e) => _convertToMap(e)).toList();
  }

  Future<List<ChartDataPoint>> getChartData(ReportDefinition report) async {
    final data = await getReportData(report);
    if (report.groupBy == null || report.aggregations.isEmpty) return [];

    final aggField = report.aggregations.first.field;
    
    return data.map((d) {
      return ChartDataPoint(
        x: d[report.groupBy!]?.toString() ?? 'N/A',
        y: (d[aggField] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();
  }

  Map<String, dynamic> _convertToMap(dynamic obj) {
    if (obj is Map<String, dynamic>) return obj;
    try {
      return (obj as dynamic).toJson();
    } catch (_) {
      return {'data': obj.toString()};
    }
  }
}
