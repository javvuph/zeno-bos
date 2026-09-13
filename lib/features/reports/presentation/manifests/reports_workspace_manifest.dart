import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/report_definition.dart';

/// ReportsWorkspaceManifest v1.0
/// Operational manifest for the ZENO BI \u0026 Analytical Layer.
class ReportsWorkspaceManifest extends ZenoWorkspaceManifest<ReportDefinition> {
  const ReportsWorkspaceManifest()
      : super(
          id: 'reports_master_hub',
          title: 'Reports / Custom Reports',
          subtitle:
              'ANALYTICAL CONTROL: BUILD CUSTOM REPORTS, MONITOR KPIs, AND GENERATE BI INSIGHTS.',
          icon: Icons.assessment_rounded,
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
            label: "⚡ Build Report",
            icon: Icons.add_chart_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "New Dashboard",
            icon: Icons.dashboard_customize_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Export All",
            icon: Icons.file_download_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Reports", isSelected: true),
        const ZenoChip(label: "Financial", color: Colors.green),
        const ZenoChip(label: "Sales", color: Colors.blue),
        const ZenoChip(label: "HR", color: Colors.orange),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Active Reports",
            value: "24",
            icon: Icons.description_outlined),
        const ZenoKpiData(
            label: "BI Dashboards",
            value: "08",
            icon: Icons.dashboard_outlined,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Total Insight Gen",
            value: "1.2K",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
        const ZenoKpiData(
            label: "System Health",
            value: "High",
            icon: Icons.favorite_outline,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<ReportDefinition>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "REPORT IDENTITY",
          width: 250,
          builder: (r) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(r.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(r.description,
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "MODULE",
          width: 140,
          builder: (r) => ZenoBadge(
            label: r.module.name.toUpperCase(),
            color: _getModuleColor(r.module),
          ),
        ),
        ZenoTableColumn(
          label: "VIEW TYPE",
          width: 140,
          builder: (r) => Row(
            children: [
              Icon(_getVisualizationIcon(r.visualization), size: 14, color: Colors.grey),
              const SizedBox(width: 8),
              Text(r.visualization.name.toUpperCase(),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "LAST UPDATED",
          builder: (r) => const Text("TODAY",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, ReportDefinition? r) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Report Metadata \u0026 Purpose"))),
        const ZenoInspectorTab(
            label: "Data Source",
            icon: Icons.storage_outlined,
            child: Center(child: Text("Module \u0026 Collection Links"))),
        const ZenoInspectorTab(
            label: "Filters",
            icon: Icons.filter_list_rounded,
            child: Center(child: Text("Dynamic Condition Builder"))),
        const ZenoInspectorTab(
            label: "Visualization",
            icon: Icons.insert_chart_outlined_rounded,
            child: Center(child: Text("Chart \u0026 Table Config"))),
        const ZenoInspectorTab(
            label: "Schedule",
            icon: Icons.schedule_rounded,
            child: Center(child: Text("Automated Delivery Rules"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Anomaly Detection \u0026 Trends"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("BI AI: EXPLAIN SALES DROP, PREDICT REVENUE, /build...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "ANALYTICS ENGINE: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "NEURAL HUB: SYNCED", isActive: true),
      ];

  static Color _getModuleColor(ReportModule module) {
    switch (module) {
      case ReportModule.finance: return Colors.green;
      case ReportModule.sales: return Colors.blue;
      case ReportModule.inventory: return Colors.indigo;
      case ReportModule.hr: return Colors.orange;
      default: return Colors.grey;
    }
  }

  static IconData _getVisualizationIcon(ReportVisualization v) {
    switch (v) {
      case ReportVisualization.table: return Icons.table_chart_outlined;
      case ReportVisualization.bar: return Icons.bar_chart_rounded;
      case ReportVisualization.line: return Icons.show_chart_rounded;
      case ReportVisualization.pie: return Icons.pie_chart_rounded;
      default: return Icons.insert_chart_outlined;
    }
  }
}
