import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/closing_task.dart';
import '../widgets/period_progress_stepper.dart';
import '../widgets/closing_ai_readiness_panel.dart';

/// ClosingWorkspaceManifest v1.0
/// Operational control center for Financial Closing and Period Management.
class ClosingWorkspaceManifest extends ZenoWorkspaceManifest<ClosingTask> {
  const ClosingWorkspaceManifest()
      : super(
          id: 'financial_closing_hub',
          title: 'Finance / Financial Closing',
          subtitle:
              'FISCAL CONTROL: MANAGE PERIOD CLOSING, CHECKLISTS, AND AUDIT READINESS.',
          icon: Icons.lock_clock_rounded,
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
            label: "⚡ Close Period",
            icon: Icons.published_with_changes_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Lock Period",
            icon: Icons.lock_outline_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Fiscal Calendar",
            icon: Icons.calendar_month_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Current Period", isSelected: true),
        const ZenoChip(label: "Pending Tasks", color: Colors.orange),
        const ZenoChip(label: "GL Adjustments", color: Colors.blue),
        const ZenoChip(label: "Revaluation", color: Colors.purple),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Fiscal Year",
            value: "2026-27",
            icon: Icons.account_balance_outlined),
        const ZenoKpiData(
            label: "Readiness",
            value: "68%",
            icon: Icons.speed_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Pending",
            value: "05 Tasks",
            icon: Icons.playlist_add_check_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Risk Score",
            value: "Low",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<ClosingTask>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "TASK IDENTITY",
          width: 250,
          builder: (t) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text(t.category.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "MANDATORY",
          width: 100,
          builder: (t) => Icon(
            t.isMandatory ? Icons.verified_rounded : Icons.info_outline_rounded,
            size: 16,
            color: t.isMandatory ? Colors.red : Colors.grey,
          ),
        ),
        ZenoTableColumn(
          label: "ASSIGNED TO",
          width: 160,
          builder: (t) => Text(t.assignedTo ?? "SYSTEM",
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (t) => ZenoBadge(
            label: t.status.name.toUpperCase(),
            color: _getStatusColor(t.status),
          ),
        ),
        ZenoTableColumn(
          label: "COMPLETION",
          builder: (t) => Text(
              t.completedAt?.toString().substring(0, 10) ?? "-",
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, ClosingTask? t) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Task Details \u0026 SOP"))),
        ZenoInspectorTab(
            label: "Progress",
            icon: Icons.speed_rounded,
            child: PeriodProgressStepper(tasks: [if (t != null) t])),
        ZenoInspectorTab(
            label: "AI Readiness",
            icon: Icons.auto_awesome,
            child: ClosingAiReadinessPanel(score: t?.aiReadinessScore ?? 0.0)),
        const ZenoInspectorTab(
            label: "Adjustments",
            icon: Icons.edit_note_rounded,
            child: Center(child: Text("Proposed Journal Entries"))),
        const ZenoInspectorTab(
            label: "Approvals",
            icon: Icons.verified_user_outlined,
            child: Center(child: Text("Sign-off Chain"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH CLOSING TASKS: /lock, /accrue, /revaluate...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "FISCAL PERIOD: OPEN", isActive: true),
        const ZenoStatusDot(label: "BOOKS: UNLOCKED", isActive: true),
      ];

  static Color _getStatusColor(ClosingTaskStatus status) {
    switch (status) {
      case ClosingTaskStatus.completed:
        return Colors.green;
      case ClosingTaskStatus.inProgress:
        return Colors.blue;
      case ClosingTaskStatus.failed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
