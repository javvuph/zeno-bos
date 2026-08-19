import 'package:flutter/material.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/sales_analytics.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/ai_business_insights.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/analytics_widgets.dart';
import 'package:zeno/features/home/presentation/widgets/operations/operations_widgets.dart';
import 'package:zeno/features/home/presentation/widgets/ai/ai_widgets.dart';

import 'package:zeno/features/home/presentation/widgets/dashboard/executive_command_center/executive_kpi_row.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/executive_command_center/core_analytical_row.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/executive_command_center/performance_matrix_row.dart';

class WidgetMetadata {
  final String key;
  final String label;
  final String category;
  final IconData icon;
  final String description;
  final Widget Function() builder;

  WidgetMetadata({
    required this.key,
    required this.label,
    required this.category,
    required this.icon,
    required this.description,
    required this.builder,
  });
}

class WidgetRegistry {
  static final List<WidgetMetadata> allWidgets = [
    // --- ANALYTICS ---
    WidgetMetadata(
      key: 'sales_analytics',
      label: 'Sales Analytics',
      category: 'Sales',
      icon: Icons.bar_chart,
      description: 'Comprehensive sales performance and trends.',
      builder: () => const SalesAnalyticsSection(),
    ),
    WidgetMetadata(
      key: 'ai_insights',
      label: 'AI Insights',
      category: 'AI',
      icon: Icons.auto_awesome,
      description: 'AI-driven business insights and recommendations.',
      builder: () => const AIBusinessInsightsSection(),
    ),
    WidgetMetadata(
      key: 'product_intelligence',
      label: 'Product Intelligence',
      category: 'Inventory',
      icon: Icons.inventory_2_outlined,
      description: 'Top performing products and stock analysis.',
      builder: () => const ProductIntelligence(),
    ),
    WidgetMetadata(
      key: 'customer_analytics',
      label: 'Customer Analytics',
      category: 'Customers',
      icon: Icons.people_alt_outlined,
      description: 'Customer growth and segment analysis.',
      builder: () => const CustomerAnalytics(),
    ),

    // --- OPERATIONS ---
    WidgetMetadata(
      key: 'low_stock',
      label: 'Low Stock Monitor',
      category: 'Inventory',
      icon: Icons.warning_amber_rounded,
      description: 'Real-time monitoring of items below safety levels.',
      builder: () => const LowStockCentre(),
    ),
    WidgetMetadata(
      key: 'pending_orders',
      label: 'Pending Orders',
      category: 'Sales',
      icon: Icons.shopping_basket_outlined,
      description: 'Overview of orders waiting for processing.',
      builder: () => const SalesOpsMonitor(),
    ),

    // --- AI ---
    WidgetMetadata(
      key: 'business_health',
      label: 'Business Health Score',
      category: 'Dashboard',
      icon: Icons.health_and_safety_outlined,
      description: 'Real-time scorecard of your business performance.',
      builder: () => const BusinessHealthScoreGrid(),
    ),
    WidgetMetadata(
      key: 'ai_predictions',
      label: 'AI Predictions',
      category: 'AI',
      icon: Icons.psychology_outlined,
      description: 'Machine learning forecasts for sales and risk.',
      builder: () => const AIPredictionGrid(),
    ),
    // --- EXECUTIVE COMMAND CENTER ROWS ---
    WidgetMetadata(
      key: 'exec_kpi_pulse',
      label: 'Executive KPI Pulse',
      category: 'Command Center',
      icon: Icons.speed_outlined,
      description: 'Top-level financial and operational pulse cards.',
      builder: () => const ExecutiveKPIRow(),
    ),
    WidgetMetadata(
      key: 'exec_analytical_core',
      label: 'Analytical Intelligence',
      category: 'Command Center',
      icon: Icons.analytics_outlined,
      description: 'Core revenue charts vs AI action radar.',
      builder: () => const CoreAnalyticalRow(),
    ),
    WidgetMetadata(
      key: 'exec_performance_matrix',
      label: 'Performance Leaderboard',
      category: 'Command Center',
      icon: Icons.leaderboard_outlined,
      description: 'Department health matrix and product leaderboard.',
      builder: () => const PerformanceMatrixRow(),
    ),
  ];

  static Widget build(String key) {
    try {
      return allWidgets.firstWhere((w) => w.key == key).builder();
    } catch (e) {
      return Container(
        color: Colors.red.withValues(alpha: 0.1),
        child: Center(child: Text("Widget not found: $key")),
      );
    }
  }

  static List<String> getCategories() {
    return allWidgets.map((e) => e.category).toSet().toList();
  }
}
