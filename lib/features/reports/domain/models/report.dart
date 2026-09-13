import 'report_filter.dart';
import 'report_widget.dart';

enum ReportType { table, chart, pivot, kpi }

class Report {
  final String id;
  final String name;
  final String description;
  final ReportType type;
  final List<ReportWidget> widgets;
  final List<ReportFilter> defaultFilters;
  final bool isCustom;

  const Report({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.widgets = const [],
    this.defaultFilters = const [],
    this.isCustom = false,
  });
}
