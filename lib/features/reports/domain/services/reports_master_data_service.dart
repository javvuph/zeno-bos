import '../models/report.dart';
import '../models/dashboard_kpi.dart';
import 'package:flutter/material.dart';

class ReportsMasterDataService {
  List<Report> getAvailableReports() => [
        const Report(
          id: 'fin_pl',
          name: 'Profit & Loss Statement',
          description: 'Comprehensive financial performance overview.',
          type: ReportType.pivot,
        ),
        const Report(
          id: 'sales_velocity',
          name: 'Sales Velocity Analysis',
          description: 'Track transactional throughput across channels.',
          type: ReportType.chart,
        ),
      ];

  List<DashboardKPI> getMockDashboardKPIs() => [
        const DashboardKPI(
          id: 'revenue',
          label: 'Gross Revenue',
          value: '\$124.5K',
          change: 12.4,
          icon: Icons.payments_outlined,
          color: Color(0xFF00FF88),
        ),
        const DashboardKPI(
          id: 'margin',
          label: 'Net Margin',
          value: '18.2%',
          change: -2.1,
          icon: Icons.pie_chart_outline,
          color: Color(0xFF00D2FF),
        ),
      ];
}
