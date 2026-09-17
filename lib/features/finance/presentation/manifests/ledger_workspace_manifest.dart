import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/journal_entry.dart';

/// LedgerWorkspaceManifest v1.0
/// Enterprise-grade command center for General Ledger and Trial Balance.
class LedgerWorkspaceManifest extends ZenoWorkspaceManifest<JournalEntry> {
  const LedgerWorkspaceManifest()
      : super(
          id: 'general_ledger_command',
          title: 'Finance / Ledger',
          subtitle:
              'ACCOUNTING BACKBONE: MANAGE JOURNAL ENTRIES, AUDIT LEDGERS, AND ENSURE FINANCIAL INTEGRITY.',
          icon: Icons.account_balance_rounded,
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
            label: "⚡ New Journal",
            icon: Icons.add_chart_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Trial Balance",
            icon: Icons.summarize_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Chart of Accounts",
            icon: Icons.account_tree_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Entries", isSelected: true),
        const ZenoChip(label: "Current Period"),
        const ZenoChip(label: "Unposted", color: Colors.orange),
        const ZenoChip(label: "Adjusting", color: Colors.blue),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Assets",
            value: "₹0",
            icon: Icons.assured_workload_outlined),
        const ZenoKpiData(
            label: "Net Profit",
            value: "₹0",
            icon: Icons.trending_up_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "TB Difference",
            value: "₹0.00",
            icon: Icons.balance_rounded,
            color: Color(0xFF00F0FF)),
        const ZenoKpiData(
            label: "Today's Postings",
            value: "0",
            icon: Icons.history_edu_rounded,
            color: Colors.indigo),
      ];

  static List<ZenoTableColumn<JournalEntry>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "JOURNAL IDENTITY",
          width: 220,
          builder: (j) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(j.id,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              Text("REF: ${j.referenceNumber}",
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "DATE",
          width: 140,
          builder: (j) => Text(j.date.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "DESCRIPTION",
          width: 300,
          builder: (j) => Text(j.description.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10, overflow: TextOverflow.ellipsis)),
        ),
        ZenoTableColumn(
          label: "TOTAL DEBIT",
          width: 140,
          isNumeric: true,
          builder: (j) => Text("₹${_sumDebits(j).toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (j) => ZenoBadge(
            label: j.status.name.toUpperCase(),
            color: j.status == JournalEntryStatus.posted
                ? Colors.green
                : Colors.grey,
          ),
        ),
        ZenoTableColumn(
          label: "MODULE",
          builder: (j) => Text(j.sourceModule.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, JournalEntry? j) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Entry Summary"))),
        const ZenoInspectorTab(
            label: "Journal Lines",
            icon: Icons.list_alt_rounded,
            child: Center(child: Text("Debit/Credit Breakdown"))),
        const ZenoInspectorTab(
            label: "Posting",
            icon: Icons.account_balance_rounded,
            child: Center(child: Text("Ledger Impact Details"))),
        const ZenoInspectorTab(
            label: "Audit Trail",
            icon: Icons.verified_user_outlined,
            child: Center(child: Text("Compliance Log"))),
        const ZenoInspectorTab(
            label: "AI Audit",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Anomaly Detection Score"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH LEDGER: /post, /reverse, /tb...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "GENERAL LEDGER: SYNCED", isActive: true),
        const ZenoStatusDot(label: "TRIAL BALANCE: EQUAL", isActive: true),
      ];

  static double _sumDebits(JournalEntry j) =>
      j.lines.fold(0, (sum, l) => sum + l.debit);
}
