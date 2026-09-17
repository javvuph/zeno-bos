import 'package:flutter/material.dart';

class SalesPoint {
  final DateTime date;
  final double revenue;
  final double expenses;
  final double profit;
  SalesPoint(this.date, this.revenue, this.expenses, this.profit);
}

class ProductMetric {
  final String name;
  final double revenue;
  final Color color;
  ProductMetric(this.name, this.revenue, this.color);
}

class ForecastPoint {
  final DateTime date;
  final double? actual;
  final double predicted;
  final double? lower;
  final double? upper;
  ForecastPoint(this.date, this.actual, this.predicted,
      {this.lower, this.upper});
}

class BIMockData {
  static List<SalesPoint> getSalesTrend() => [];

  static List<ProductMetric> getTopProducts() => [];

  static List<Map<String, dynamic>> getAIInsights() => [];

  static List<Map<String, dynamic>> getLowStockItems() => [];

  static Map<String, double> getBusinessHealthScores() => {
        'Revenue Growth': 0.0,
        'Operating Margin': 0.0,
        'Customer Retention': 0.0,
        'Cash Runway': 0.0,
        'Inventory Turnover': 0.0,
        'Net Profit Margin': 0.0,
        'Asset Efficiency': 0.0,
        'Debt-to-Equity': 0.0,
      };

  static List<Map<String, dynamic>> getCustomerFollowups() => [];

  static List<Map<String, dynamic>> getApprovals() => [];

  static List<String> getAIExecutiveSummary() => [];

  static List<Map<String, dynamic>> getAIPredictions() => [];

  static List<Map<String, dynamic>> getAIRecommendations() => [];

  static List<ForecastPoint> getForecastData() => [];
}
