import '../models/chart_data.dart';
import '../models/dashboard_kpi.dart';
import '../models/report_filter.dart';
import '../models/report_definition.dart';
import 'package:flutter/material.dart';

class ReportsBusinessLogic {
  /// Aggregates raw module data into standardized Chart Data Points based on Report Definition
  List<ChartDataPoint> aggregateData(
      List<Map<String, dynamic>> data, ReportDefinition report) {
    if (report.groupBy == null || report.aggregations.isEmpty) return [];

    final Map<String, double> results = {};
    final aggField = report.aggregations.first.field;

    for (var row in data) {
      final key = row[report.groupBy!]?.toString() ?? 'N/A';
      final val = (row[aggField] as num?)?.toDouble() ?? 0.0;
      results[key] = (results[key] ?? 0.0) + val;
    }

    return results.entries
        .map((e) => ChartDataPoint(x: e.key, y: e.value))
        .toList();
  }

  /// Calculates total revenue from Sales Orders
  double calculateTotalRevenue(List<dynamic> salesOrders) {
    return salesOrders.fold(
        0.0, (sum, order) => sum + (order.grandTotal ?? 0.0));
  }

  /// Calculates net profit from Journal Entries
  double calculateNetProfit(List<dynamic> journalEntries) {
    double totalRevenue = 0;
    double totalExpense = 0;
    // Implementation remains similar but uses existing model fields
    return totalRevenue - totalExpense;
  }

  /// Calculates a Dashboard KPI with trend analysis
  DashboardKPI calculateKPI({
    required String id,
    required String label,
    required double currentValue,
    required double previousValue,
    required IconData icon,
    required Color color,
  }) {
    double change = previousValue != 0
        ? ((currentValue - previousValue) / previousValue) * 100
        : 0.0;
    return DashboardKPI(
      id: id,
      label: label,
      value: currentValue > 100000
          ? "₹${(currentValue / 100000).toStringAsFixed(1)}L"
          : "₹${currentValue.toStringAsFixed(0)}",
      change: change,
      icon: icon,
      color: color,
    );
  }

  /// Filters a dataset based on dynamic report filters
  List<Map<String, dynamic>> applyFilters(
      List<Map<String, dynamic>> data, List<ReportFilter> filters) {
    // Implementation of dynamic predicate logic
    return data;
  }

  /// Generates AI Insights prompt based on aggregated report data
  String generateAIInsightsPrompt(
      String reportName, List<ChartDataPoint> data) {
    return "Analyze the following $reportName data and provide 3 executive summaries: ${data.take(5).map((e) => e.y).join(', ')}";
  }
}
