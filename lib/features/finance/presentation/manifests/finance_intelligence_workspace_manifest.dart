import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/finance_insight.dart';

/// FinanceIntelligenceManifest v1.0
/// Final Phase 7.10: Consolidated BI and Intelligence Dashboard for ZENO BOS.
class FinanceIntelligenceManifest
    extends ZenoWorkspaceManifest<FinanceIntelligenceInsight> {
  const FinanceIntelligenceManifest()
      : super(
          id: 'finance_intelligence_hub',
          title: 'Finance / Finance Intelligence',
          subtitle:
              'EXECUTIVE VISIBILITY: CROSS-MODULE ANALYTICS, CASH FLOW FORECASTING, AND AI STRATEGY.',
          icon: Icons.insights_rounded,
          toolbarActions: _getToolbarActions,
          filterActions: _getFilterActions,
          kpiMetrics: _getKpiMetrics,
          tableColumns: _getTableColumns,
          inspectorTabs: _getInspectorTabs,
          commandVessel: _getCommandVessel,
          statusBarIndicators: _getStatusBarIndicators,
        );

  static List<Widget> _getToolbarActions(BuildContext context) => [
        const ZenoButton(
            label: "⚡ Run Analysis",
            icon: Icons.auto_awesome,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Forecasts",
            icon: Icons.timeline_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Board Reports",
            icon: Icons.picture_as_pdf_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Executive Summary", isSelected: true),
        const ZenoChip(label: "Liquidity Pulse", color: Colors.blue),
        const ZenoChip(label: "Opex Efficiency", color: Colors.purple),
        const ZenoChip(label: "Audit \u0026 Risk", color: Colors.orange),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Finance Pulse",
            value: "Optimal",
            icon: Icons.favorite_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Cash Runway",
            value: "14.2 Mo",
            icon: Icons.trending_up_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Ecosystem Sync",
            value: "100%",
            icon: Icons.sync_rounded,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "AI Confidence",
            value: "98.5%",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<FinanceIntelligenceInsight>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "STRATEGIC INSIGHT",
          width: 300,
          builder: (i) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(i.title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(i.category.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "VALUE",
          width: 120,
          isNumeric: true,
          builder: (i) => Text("${i.value}${i.unit}",
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: Color(0xFF00F0FF))),
        ),
        ZenoTableColumn(
          label: "TREND",
          width: 140,
          builder: (i) => Row(
            children: [
              Icon(_getTrendIcon(i.trend),
                  size: 14, color: _getTrendColor(i.trend)),
              const SizedBox(width: 8),
              Text(i.trend.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getTrendColor(i.trend))),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "PRIORITY",
          width: 140,
          builder: (i) => ZenoBadge(
            label: i.priority.name.toUpperCase(),
            color: _getPriorityColor(i.priority),
          ),
        ),
        ZenoTableColumn(
          label: "AI RECOMMENDATION",
          builder: (i) => Text(i.recommendation,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, FinanceIntelligenceInsight? i) =>
      [
        const ZenoInspectorTab(
            label: "Pulse Detail",
            icon: Icons.insights_rounded,
            child: Center(child: Text("Detailed Metric Breakdown"))),
        const ZenoInspectorTab(
            label: "Impact Analysis",
            icon: Icons.radar_rounded,
            child: Center(child: Text("Financial Simulation Result"))),
        const ZenoInspectorTab(
            label: "Action Plan",
            icon: Icons.list_alt_rounded,
            child: Center(child: Text("SOP for Resolution"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("ZENO AI: ASK ANYTHING ABOUT COMPANY FINANCIALS...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "ECOSYSTEM: CERTIFIED", isActive: true),
        const ZenoStatusDot(label: "AI ANALYSIS: REAL-TIME", isActive: true),
      ];

  static IconData _getTrendIcon(InsightTrend trend) {
    switch (trend) {
      case InsightTrend.positive:
        return Icons.trending_up_rounded;
      case InsightTrend.negative:
        return Icons.trending_down_rounded;
      default:
        return Icons.trending_flat_rounded;
    }
  }

  static Color _getTrendColor(InsightTrend trend) {
    switch (trend) {
      case InsightTrend.positive:
        return Colors.green;
      case InsightTrend.negative:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  static Color _getPriorityColor(InsightPriority p) {
    switch (p) {
      case InsightPriority.critical:
        return Colors.red;
      case InsightPriority.high:
        return Colors.orange;
      case InsightPriority.medium:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
