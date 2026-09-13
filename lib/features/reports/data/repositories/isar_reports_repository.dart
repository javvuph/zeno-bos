import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import 'package:zeno/core/database/collections/finance_collections.dart';
import 'package:zeno/core/database/collections/inventory_collections.dart';
import 'package:zeno/core/database/collections/staff_collections.dart';
import 'package:zeno/core/database/collections/reports_collections.dart';
import '../../domain/models/report_filter.dart';
import '../../domain/repositories/i_reports_repository.dart';
import '../../domain/models/report.dart';
import '../../domain/models/report_definition.dart';
import '../../domain/models/analytics_query.dart';
import '../../domain/models/export_job.dart';
import '../../domain/models/scheduled_report.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class IsarReportsRepository implements IReportsRepository {
  final DatabaseService db;
  IsarReportsRepository(this.db);

  IsarCollection<ReportDefinitionCollection> get reportDefCol =>
      db.isar.collection<ReportDefinitionCollection>();

  @override
  Future<List<Report>> getAvailableReports() async {
    return [];
  }

  @override
  Future<List<dynamic>> executeQuery(AnalyticsQuery query) async {
    DateTime? start;
    DateTime? end;
    for (var f in query.filters) {
      if (f.type == FilterType.dateRange && f.value is List<DateTime>) {
        start = f.value[0];
        end = f.value[1];
      }
    }

    if (query.module == 'finance') {
      final col = db.isar.collection<JournalEntryCollection>();
      if (start != null && end != null) {
        return await col.filter().dateBetween(start, end).findAll();
      }
      return await col.where().findAll();
    } else if (query.module == 'sales') {
      final col = db.isar.collection<SalesOrderCollection>();
      if (start != null && end != null) {
        return await col.filter().dateBetween(start, end).findAll();
      }
      return await col.where().findAll();
    } else if (query.module == 'inventory') {
      final col = db.isar.collection<ProductCollection>();
      return await col.filter().isDeletedEqualTo(false).findAll();
    } else if (query.module == 'staff') {
      final col = db.isar.collection<EmployeeCollection>();
      return await col.filter().isDeletedEqualTo(false).findAll();
    }
    return [];
  }

  @override
  Future<List<ReportDefinition>> getCustomReports() async {
    final results = await reportDefCol.where().findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  @override
  Future<void> saveReportDefinition(ReportDefinition report) async {
    final existing = await reportDefCol.filter().uuidEqualTo(report.id).findFirst();
    final e = (existing ?? ReportDefinitionCollection())
      ..uuid = report.id
      ..name = report.name
      ..description = report.description
      ..module = report.module.name
      ..dataSource = report.dataSource
      ..reportType = report.visualization.name
      ..selectedFields = report.selectedFields
      ..groupByField = report.groupBy
      ..sortByField = report.sortBy
      ..sortDescending = report.sortDescending
      ..aggregationJson = jsonEncode(report.aggregations.map((a) => a.toJson()).toList())
      ..filtersJson = jsonEncode(report.filters.map((f) => f.toJson()).toList())
      ..visualSettingsJson = jsonEncode(report.visualSettings)
      ..ownerId = report.ownerId
      ..isPredefined = report.isPredefined
      ..createdAt = report.createdAt
      ..updatedAt = DateTime.now();

    await db.isar.writeTxn(() async => await reportDefCol.put(e));
  }

  @override
  Future<void> deleteReportDefinition(String id) async {
    await db.isar.writeTxn(() async {
      await reportDefCol.filter().uuidEqualTo(id).deleteAll();
    });
  }

  @override
  Future<List<dynamic>> getDashboards() async => [];

  @override
  Future<void> saveDashboard(dynamic dashboard) async {}

  @override
  Future<ExportJob> requestExport(String reportId, ExportFormat format) async {
    return ExportJob(
      id: const Uuid().v4(),
      reportId: reportId,
      format: format,
      status: ExportStatus.pending,
      createdAt: DateTime.now(),
      downloadUrl: 'exports/report_${reportId}_${DateTime.now().millisecondsSinceEpoch}.${format.name}',
    );
  }

  @override
  Future<List<ExportJob>> getExportHistory() async => [];

  @override
  Future<void> saveScheduledReport(ScheduledReport schedule) async {}

  @override
  Future<List<ScheduledReport>> getScheduledReports() async => [];

  ReportDefinition _mapToDomain(ReportDefinitionCollection e) {
    return ReportDefinition(
      id: e.uuid,
      name: e.name,
      description: e.description,
      module: ReportModule.values.byName(e.module),
      dataSource: e.dataSource,
      visualization: ReportVisualization.values.byName(e.reportType),
      selectedFields: e.selectedFields,
      groupBy: e.groupByField,
      sortBy: e.sortByField,
      sortDescending: e.sortDescending,
      aggregations: e.aggregationJson != null 
        ? (jsonDecode(e.aggregationJson!) as List).map((a) => ReportAggregation.fromJson(a)).toList()
        : [],
      filters: e.filtersJson != null
        ? (jsonDecode(e.filtersJson!) as List).map((f) => ReportFilter.fromJson(f)).toList()
        : [],
      visualSettings: e.visualSettingsJson != null ? jsonDecode(e.visualSettingsJson!) : {},
      ownerId: e.ownerId,
      isPredefined: e.isPredefined,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
}
