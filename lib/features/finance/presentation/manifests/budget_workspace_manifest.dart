import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/budget.dart';
import '../widgets/budget_ai_advisor_panel.dart';

/// BudgetWorkspaceManifest v1.0
/// Operational control center for Enterprise Planning, Budgets, and Cost Centers.
class BudgetWorkspaceManifest extends ZenoWorkspaceManifest<Budget> {
  const BudgetWorkspaceManifest()
      : super(
          id: 'budget_control_center',
          title: 'Finance / Budgets',
          subtitle:
              'STRATEGIC PLANNING: ALLOCATE RESOURCES, MONITOR UTILIZATION, AND ANALYZE EXPENDITURE VARIANCE.',
          icon: Icons.pie_chart_rounded,
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
            label: "⚡ New Budget",
            icon: Icons.add_chart_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Revision",
            icon: Icons.history_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Allocation",
            icon: Icons.account_tree_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Budgets", isSelected: true),
        const ZenoChip(label: "Active", color: Colors.green),
        const ZenoChip(label: "Over Budget", color: Colors.red),
        const ZenoChip(label: "Under Review", color: Colors.orange),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Budget",
            value: "₹12.4M",
            icon: Icons.account_balance_outlined),
        const ZenoKpiData(
            label: "Utilized",
            value: "₹4.8M",
            icon: Icons.trending_up_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Remaining",
            value: "₹7.6M",
            icon: Icons.pie_chart_outline_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Health Score",
            value: "88%",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<Budget>> _getTableColumns(BuildContext context) =>
      [
        ZenoTableColumn(
          label: "BUDGET CODE",
          width: 160,
          builder: (b) => Text(b.code,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  fontFamily: 'monospace')),
        ),
        ZenoTableColumn(
          label: "BUDGET NAME",
          width: 250,
          builder: (b) => Text(b.name.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "ALLOCATED",
          width: 140,
          isNumeric: true,
          builder: (b) => Text("₹${b.allocatedAmount.toStringAsFixed(0)}",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
        ),
        ZenoTableColumn(
          label: "UTILIZED",
          width: 140,
          isNumeric: true,
          builder: (b) => Text("₹${b.utilizedAmount.toStringAsFixed(0)}",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  color: b.isOverBudget ? Colors.red : Colors.blue)),
        ),
        ZenoTableColumn(
          label: "UTIL %",
          width: 120,
          builder: (b) => _buildUtilizationBar(b.variancePercentage),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (b) => ZenoBadge(
            label: b.status.name.toUpperCase(),
            color: _getStatusColor(b.status),
          ),
        ),
        ZenoTableColumn(
          label: "OWNER",
          builder: (b) => Text(b.ownerId.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Budget? b) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Budget Summary"))),
        if (b != null)
          ZenoInspectorTab(
              label: "AI Advisor",
              icon: Icons.auto_awesome,
              child: BudgetAiAdvisorPanel(budget: b)),
        const ZenoInspectorTab(
            label: "Allocation",
            icon: Icons.account_tree_rounded,
            child: Center(child: Text("Cost Center Breakdown"))),
        const ZenoInspectorTab(
            label: "Variance",
            icon: Icons.analytics_rounded,
            child: Center(child: Text("Actual vs Plan Analysis"))),
        const ZenoInspectorTab(
            label: "Forecast",
            icon: Icons.timeline_rounded,
            child: Center(child: Text("AI Spending Prediction"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH BUDGET / COST CENTER / OWNER...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "BUDGET ENGINE: LIVE", isActive: true),
        const ZenoStatusDot(label: "CONTROL: STRICT", isActive: true),
      ];

  static Widget _buildUtilizationBar(double percentage) {
    Color color = percentage > 90
        ? Colors.red
        : (percentage > 70 ? Colors.orange : Colors.green);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
            color: color,
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 4),
        Text("${percentage.toInt()}%",
            style: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  static Color _getStatusColor(BudgetStatus status) {
    switch (status) {
      case BudgetStatus.active:
        return Colors.green;
      case BudgetStatus.revised:
        return Colors.blue;
      case BudgetStatus.frozen:
        return Colors.indigo;
      case BudgetStatus.closed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
