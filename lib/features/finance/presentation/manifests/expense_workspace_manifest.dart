import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/expense_entry.dart';

/// ExpenseWorkspaceManifest v1.0
/// Operational control center for Enterprise Expenses and Employee Claims.
class ExpenseWorkspaceManifest extends ZenoWorkspaceManifest<ExpenseEntry> {
  const ExpenseWorkspaceManifest()
      : super(
          id: 'expense_control_hub',
          title: 'Finance / Expenses',
          subtitle:
              'EXPENDITURE CONTROL: TRACK CORPORATE SPENDING, VERIFY RECEIPTS, AND APPROVE EMPLOYEE CLAIMS.',
          icon: Icons.account_balance_wallet_rounded,
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
            label: "⚡ New Expense",
            icon: Icons.add_circle_outline_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Expense Claim",
            icon: Icons.assignment_turned_in_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Approval",
            icon: Icons.verified_user_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Expenses", isSelected: true),
        const ZenoChip(label: "Pending Approval", color: Colors.orange),
        const ZenoChip(label: "Reimbursed", color: Colors.green),
        const ZenoChip(label: "Travel", color: Colors.blue),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Expenses",
            value: "₹0",
            icon: Icons.analytics_outlined),
        const ZenoKpiData(
            label: "Pending Claims",
            value: "0",
            icon: Icons.hourglass_empty_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Approved",
            value: "₹0",
            icon: Icons.task_alt_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Budget Alert",
            value: "0%",
            icon: Icons.warning_amber_rounded,
            color: Colors.red),
      ];

  static List<ZenoTableColumn<ExpenseEntry>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "EXPENSE ID",
          width: 180,
          builder: (e) => Text(e.id,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  fontFamily: 'monospace')),
        ),
        ZenoTableColumn(
          label: "DATE",
          width: 140,
          builder: (e) => Text(e.date.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "CATEGORY",
          width: 140,
          builder: (e) => ZenoBadge(
            label: e.category.name.toUpperCase(),
            color: _getCategoryColor(e.category),
          ),
        ),
        ZenoTableColumn(
          label: "EMPLOYEE",
          width: 180,
          builder: (e) => Text(e.employeeId.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "AMOUNT",
          width: 140,
          isNumeric: true,
          builder: (e) => Text("₹${e.amount.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "DOCS",
          width: 80,
          builder: (e) => Icon(
            e.hasReceipt
                ? Icons.receipt_long_rounded
                : Icons.no_photography_outlined,
            size: 16,
            color: e.hasReceipt ? Colors.green : Colors.grey,
          ),
        ),
        ZenoTableColumn(
          label: "AI SCORE",
          builder: (e) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12,
                  color: e.aiAnomalyScore > 50 ? Colors.red : Colors.green),
              const SizedBox(width: 8),
              Text("${e.aiAnomalyScore.toInt()}%",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color:
                          e.aiAnomalyScore > 50 ? Colors.red : Colors.green)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, ExpenseEntry? e) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Expense Summary"))),
        const ZenoInspectorTab(
            label: "Receipt",
            icon: Icons.receipt_outlined,
            child: Center(child: Text("OCR Verification View"))),
        const ZenoInspectorTab(
            label: "Approval",
            icon: Icons.verified_user_outlined,
            child: Center(child: Text("Workflow Chain"))),
        const ZenoInspectorTab(
            label: "Accounting",
            icon: Icons.account_balance_rounded,
            child: Center(child: Text("Debit: Category | Credit: AP"))),
        const ZenoInspectorTab(
            label: "AI Insights",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Policy Violation Checks"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH EXPENSE / EMPLOYEE / CATEGORY...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "POLICY ENGINE: LIVE", isActive: true),
        const ZenoStatusDot(label: "BUDGET: OPTIMAL", isActive: true),
      ];

  static Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.travel:
        return Colors.blue;
      case ExpenseCategory.meal:
        return Colors.orange;
      case ExpenseCategory.software:
        return Colors.purple;
      case ExpenseCategory.mileage:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
