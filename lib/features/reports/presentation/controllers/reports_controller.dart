import 'package:flutter/material.dart';
import '../../domain/models/report_definition.dart';
import '../../domain/repositories/i_reports_repository.dart';
import '../../domain/services/report_engine.dart';
import '../../domain/models/chart_data.dart';
import '../../domain/models/dashboard_kpi.dart';

class ReportsController extends ChangeNotifier {
  final IReportsRepository _repository;
  late final ReportEngine _engine;

  ReportsController(this._repository) {
    _engine = ReportEngine(_repository);
    loadReports();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ReportDefinition> _customReports = [];
  List<ReportDefinition> get customReports => _customReports;

  ReportDefinition? _activeReport;
  ReportDefinition? get activeReport => _activeReport;

  List<Map<String, dynamic>> _activeReportData = [];
  List<Map<String, dynamic>> get activeReportData => _activeReportData;

  List<ChartDataPoint> _activeChartData = [];
  List<ChartDataPoint> get activeChartData => _activeChartData;

  Future<void> loadReports() async {
    _isLoading = true;
    notifyListeners();
    try {
      _customReports = await _repository.getCustomReports();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setActiveReport(ReportDefinition report) async {
    _activeReport = report;
    _isLoading = true;
    notifyListeners();
    try {
      _activeReportData = await _engine.getReportData(report);
      if (report.visualization != ReportVisualization.table) {
        _activeChartData = await _engine.getChartData(report);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveReport(ReportDefinition report) async {
    await _repository.saveReportDefinition(report);
    await loadReports();
  }

  Future<void> deleteReport(String id) async {
    await _repository.deleteReportDefinition(id);
    await loadReports();
  }

  Future<void> refreshDashboard() async {
    // Logic to refresh all dashboard data
    notifyListeners();
  }

  // BI Dashboard KPIs
  List<DashboardKPI> get dashboardKPIs => [
    const DashboardKPI(id: 'rev', label: 'Revenue', value: '₹0', change: 0.0, icon: Icons.trending_up, color: Colors.green),
    const DashboardKPI(id: 'pro', label: 'Profit', value: '₹0', change: 0.0, icon: Icons.account_balance_wallet, color: Colors.blue),
    const DashboardKPI(id: 'exp', label: 'Expenses', value: '₹0', change: 0.0, icon: Icons.shopping_cart, color: Colors.red),
    const DashboardKPI(id: 'tax', label: 'Tax Liability', value: '₹0', change: 0.0, icon: Icons.gavel, color: Colors.orange),
  ];

  // Dashboard Stats
  double get totalRevenue => 0.0; 
  double get netProfit => 0.0;
  double get cashPosition => 0.0;
  int get salesGrowth => 0; 

  Map<String, dynamic> get aiRestockAdvice => {
    "category": "Fresh Produce",
    "advice": "AI predicts a 15% surge in weekend demand. Increase Tomato stock by 50kg.",
    "confidence": 94.2
  };

  Map<String, dynamic> get aiFashionMarkdownAdvice => {
    "style": "Winter Puffer Jacket",
    "advice": "Sell-through rate for 'Winter Puffer' is 20% below target. Recommend 25% markdown for Clearance.",
    "confidence": 88.5
  };

  Map<String, dynamic> get fashionSizePerformance => {
    "S": 0.15,
    "M": 0.25,
    "L": 0.35,
    "XL": 0.20,
    "XXL": 0.05
  };
}
