import 'package:flutter/material.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import 'package:zeno/core/database/collections/finance_collections.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:isar/isar.dart';
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
  double _totalRevenue = 0.0;
  double _netProfit = 0.0;
  double _cashPosition = 0.0;
  int _salesGrowth = 0;
  double _totalExpenses = 0.0;
  double _taxLiability = 0.0;
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
    final db = sl<DatabaseService>().isar;
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final previousStart = DateTime(now.year, now.month - 1, 1);
    final previousEnd = start.subtract(const Duration(microseconds: 1));
    final sales = await db.collection<SalesOrderCollection>().filter().dateBetween(start, now).statusEqualTo('completed').findAll();
    final previousSales = await db.collection<SalesOrderCollection>().filter().dateBetween(previousStart, previousEnd).statusEqualTo('completed').findAll();
    final expenses = await db.collection<ExpenseCollection>().filter().dateBetween(start, now).findAll();
    final revenue = sales.fold<double>(0, (sum, s) => sum + s.totalAmount);
    final previousRevenue = previousSales.fold<double>(0, (sum, s) => sum + s.totalAmount);
    final expenseTotal = expenses.fold<double>(0, (sum, e) => sum + e.amount);
    final tax = sales.fold<double>(0, (sum, s) => sum + s.totalTax);
    final salesChange = previousRevenue == 0 ? (revenue == 0 ? 0.0 : 100.0) : ((revenue - previousRevenue) / previousRevenue) * 100;
    final cash = await db.collection<AccountCollection>().filter().codeEqualTo('1000').findFirst();
    _totalRevenue = revenue;
    _totalExpenses = expenseTotal;
    _netProfit = revenue - expenseTotal;
    _taxLiability = tax;
    _cashPosition = cash?.currentBalance ?? 0.0;
    _salesGrowth = salesChange.round();
    notifyListeners();
  }

  // BI Dashboard KPIs — sourced from saved Billing / Finance records.
  List<DashboardKPI> get dashboardKPIs => [
    DashboardKPI(id: 'rev', label: 'Revenue', value: _money(_totalRevenue), change: _salesGrowth.toDouble(), icon: Icons.trending_up, color: Colors.green),
    DashboardKPI(id: 'pro', label: 'Profit', value: _money(_netProfit), change: _totalRevenue == 0 ? 0 : (_netProfit / _totalRevenue) * 100, icon: Icons.account_balance_wallet, color: Colors.blue),
    DashboardKPI(id: 'exp', label: 'Expenses', value: _money(_totalExpenses), change: 0.0, icon: Icons.shopping_cart, color: Colors.red),
    DashboardKPI(id: 'tax', label: 'Tax Liability', value: _money(_taxLiability), change: 0.0, icon: Icons.gavel, color: Colors.orange),
  ];

  static String _money(double value) => '₹' + value.toStringAsFixed(2);

  // Dashboard Stats
  double get totalRevenue => _totalRevenue;
  double get netProfit => _netProfit;
  double get cashPosition => _cashPosition;
  int get salesGrowth => _salesGrowth;

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
