import '../models/report_definition.dart';
import '../models/analytics_query.dart';
import '../models/export_job.dart';
import '../models/scheduled_report.dart';
import '../models/report.dart';

abstract class IReportsRepository {
  Future<List<Report>> getAvailableReports();
  Future<List<dynamic>> executeQuery(AnalyticsQuery query);
  Future<ExportJob> requestExport(String reportId, ExportFormat format);
  Future<List<ExportJob>> getExportHistory();
  Future<void> saveScheduledReport(ScheduledReport schedule);
  Future<List<ScheduledReport>> getScheduledReports();

  // Phase 11 Custom Reports
  Future<List<ReportDefinition>> getCustomReports();
  Future<void> saveReportDefinition(ReportDefinition report);
  Future<void> deleteReportDefinition(String id);
  
  // Phase 11 Dashboards
  Future<List<dynamic>> getDashboards();
  Future<void> saveDashboard(dynamic dashboard);
}
