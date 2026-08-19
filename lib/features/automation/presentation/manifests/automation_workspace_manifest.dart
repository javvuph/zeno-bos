import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../../domain/models/automation.dart';
import '../../domain/models/automation_enums.dart';

class AutomationWorkspaceManifest extends ZenoWorkspaceManifest<Automation> {
  const AutomationWorkspaceManifest()
      : super(
          id: 'automation_center',
          title: 'Automation Command Center',
          subtitle:
              'ORCHESTRATING AUTONOMOUS BUSINESS WORKFLOWS ACROSS THE ZENO ECOSYSTEM.',
          icon: Icons.smart_toy_outlined,
          toolbarActions: _getToolbarActions,
          filterActions: _getFilterActions,
          kpiMetrics: _getKpiMetrics,
          tableColumns: _getTableColumns,
          inspectorTabs: _getInspectorTabs,
          commandVessel: _getCommandVessel,
          statusBarIndicators: _getStatusBarIndicators,
        );

  static List<Widget> _getToolbarActions(BuildContext context) => [
        ZenoButton(
            label: "⚡ Create Automation",
            icon: Icons.add_rounded,
            onPressed: () =>
                NavigationController().navigateTo('admin/automation/builder'),
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Workflow Templates",
            icon: Icons.copy_all_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Global Logs",
            icon: Icons.history_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Active", isSelected: true),
        const ZenoChip(label: "Draft"),
        const ZenoChip(label: "Paused"),
        const ZenoChip(label: "Failed", color: Colors.red),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Active Automations",
            value: "12",
            icon: Icons.toggle_on_rounded),
        const ZenoKpiData(
            label: "Runs Today",
            value: "1,248",
            icon: Icons.play_circle_outline_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Success Rate",
            value: "99.2%",
            icon: Icons.check_circle_outline_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Time Saved",
            value: "124h",
            icon: Icons.timer_outlined,
            color: Colors.purple),
      ];

  static List<ZenoTableColumn<Automation>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "AUTOMATION NAME",
          width: 250,
          builder: (a) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(a.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(a.description ?? "No description",
                  style: const TextStyle(fontSize: 8, color: Colors.white54)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "TRIGGER",
          width: 150,
          builder: (a) => Row(
            children: [
              Icon(Icons.bolt_rounded, size: 12, color: Colors.amber),
              const SizedBox(width: 8),
              Text(a.trigger.type.name.toUpperCase(),
                  style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 120,
          builder: (a) => ZenoBadge(
            label: a.status.name.toUpperCase(),
            color: _getStatusColor(a.status),
          ),
        ),
        ZenoTableColumn(
          label: "RUNS",
          width: 100,
          isNumeric: true,
          builder: (a) => Text("${a.totalRuns}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "SUCCESS %",
          width: 100,
          isNumeric: true,
          builder: (a) => Text("${a.successRate.toStringAsFixed(1)}%",
              style: TextStyle(
                  color: a.successRate > 95 ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "CREATED BY",
          builder: (a) => Text(a.createdBy.toUpperCase(),
              style: const TextStyle(fontSize: 9, color: Colors.blue)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Automation? a) =>
      [
        const ZenoInspectorTab(
            label: "Definition",
            icon: Icons.schema_outlined,
            child: Center(child: Text("Workflow Visualizer"))),
        const ZenoInspectorTab(
            label: "Run History",
            icon: Icons.history_rounded,
            child: Center(child: Text("Recent Execution Logs"))),
        const ZenoInspectorTab(
            label: "Performance",
            icon: Icons.analytics_outlined,
            child: Center(child: Text("Efficiency Metrics"))),
        const ZenoInspectorTab(
            label: "AI Advisor",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Optimization Suggestions"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH AUTOMATIONS: /run, /pause, /logs...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "ENGINE: OPERATIONAL", isActive: true),
        const ZenoStatusDot(label: "WORKER NODES: 4 ACTIVE", isActive: true),
      ];

  static Color _getStatusColor(AutomationStatus s) {
    switch (s) {
      case AutomationStatus.active:
        return Colors.green;
      case AutomationStatus.paused:
        return Colors.orange;
      case AutomationStatus.failed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
