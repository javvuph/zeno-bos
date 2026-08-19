import 'chart_data.dart';

enum WidgetType { lineChart, barChart, pieChart, dataTable, gauge }

class ReportWidget {
  final String id;
  final String title;
  final WidgetType type;
  final List<ChartDataPoint> data;

  const ReportWidget({
    required this.id,
    required this.title,
    required this.type,
    this.data = const [],
  });
}
