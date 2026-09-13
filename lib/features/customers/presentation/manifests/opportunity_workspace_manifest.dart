import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/opportunity.dart';
import '../../domain/models/opportunity_stage.dart';

/// OpportunityWorkspaceManifest v1.0
/// Operational control center for Sales Pipeline, Opportunities, and Funnel.
class OpportunityWorkspaceManifest extends ZenoWorkspaceManifest<Opportunity> {
  const OpportunityWorkspaceManifest()
      : super(
          id: 'sales_pipeline_hub',
          title: 'CRM / Deals Pipeline',
          subtitle:
              'REVENUE CONTROL: TRACK DEALS, FORECAST REVENUE, AND MANAGE SALES ACTIVITIES.',
          icon: Icons.account_tree_rounded,
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
            label: "⚡ New Deal",
            icon: Icons.add_task_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Forecast",
            icon: Icons.auto_graph_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Activities",
            icon: Icons.pending_actions_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Active Deals", isSelected: true),
        const ZenoChip(label: "Top 10 High Value", color: Colors.indigo),
        const ZenoChip(label: "Needs Attention", color: Colors.orange),
        const ZenoChip(label: "Won Deals", color: Colors.green),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Pipeline Value",
            value: "₹12.4M",
            icon: Icons.account_tree_outlined),
        const ZenoKpiData(
            label: "Expected Rev",
            value: "₹5.8M",
            icon: Icons.insights_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Win Rate",
            value: "32%",
            icon: Icons.flag_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Pipeline Health",
            value: "High",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<Opportunity>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "DEAL IDENTITY",
          width: 250,
          builder: (o) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(o.title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(o.customerId.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "STAGE",
          width: 160,
          builder: (o) => ZenoBadge(
            label: o.stage.name.toUpperCase(),
            color: _getStageColor(o.stage),
          ),
        ),
        ZenoTableColumn(
          label: "REVENUE",
          width: 140,
          isNumeric: true,
          builder: (o) => Text("₹${o.expectedRevenue.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "WIN %",
          width: 100,
          isNumeric: true,
          builder: (o) => Text("${o.probability.toInt()}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: o.probability > 70
                    ? Colors.green
                    : (o.probability < 30 ? Colors.red : Colors.orange),
              )),
        ),
        ZenoTableColumn(
          label: "CLOSE DATE",
          width: 120,
          builder: (o) => Text(o.expectedCloseDate.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "SOURCE",
          builder: (o) => Text(o.leadSource?.toUpperCase() ?? "DIRECT",
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Opportunity? o) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Deal Details & Strategy"))),
        const ZenoInspectorTab(
            label: "Activities",
            icon: Icons.calendar_month_rounded,
            child: Center(child: Text("Tasks, Meetings & Calls"))),
        const ZenoInspectorTab(
            label: "Quotations",
            icon: Icons.request_quote_rounded,
            child: Center(child: Text("Linked Bids & Versions"))),
        const ZenoInspectorTab(
            label: "Competitors",
            icon: Icons.compare_rounded,
            child: Center(child: Text("Competitor Matrix & SWOT"))),
        const ZenoInspectorTab(
            label: "AI Sales Coach",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Next Best Action & Win Score"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("ZENO AI: ANALYZE PIPELINE, PREDICT REVENUE, /won...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "PIPELINE: SYNCED", isActive: true),
        const ZenoStatusDot(label: "FORECAST: ACCURATE", isActive: true),
      ];

  static Color _getStageColor(OpportunityStage stage) {
    switch (stage) {
      case OpportunityStage.closedWon:
        return Colors.green;
      case OpportunityStage.closedLost:
        return Colors.red;
      case OpportunityStage.negotiation:
        return Colors.indigo;
      case OpportunityStage.proposal:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
