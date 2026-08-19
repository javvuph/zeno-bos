import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/bank_transaction.dart';

/// BankingWorkspaceManifest v1.0
class BankingWorkspaceManifest extends ZenoWorkspaceManifest<BankTransaction> {
  const BankingWorkspaceManifest()
      : super(
          id: 'banking_treasury_hub',
          title: 'Finance / Banking',
          subtitle:
              'TREASURY CONTROL CENTER: MONITOR BALANCES, RECONCILE STATEMENTS, AND TRACK GLOBAL CASH FLOW.',
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
            label: "⚡ New Transaction",
            icon: Icons.add_to_photos_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Bank Transfer",
            icon: Icons.swap_horiz_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Reconciliation",
            icon: Icons.checklist_rtl_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Transactions", isSelected: true),
        const ZenoChip(label: "Unreconciled", color: Colors.orange),
        const ZenoChip(label: "Deposits", color: Colors.green),
        const ZenoChip(label: "Withdrawals", color: Colors.red),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Cash On Hand",
            value: "₹850K",
            icon: Icons.savings_outlined),
        const ZenoKpiData(
            label: "Bank Balance",
            value: "₹4.2M",
            icon: Icons.account_balance_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "Pending Deps",
            value: "₹120K",
            icon: Icons.hourglass_top_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Today's Flow",
            value: "+₹34K",
            icon: Icons.trending_up_rounded,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<BankTransaction>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "TX IDENTITY",
          width: 220,
          builder: (t) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.id,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              Text(t.description.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "DATE",
          width: 140,
          builder: (t) => Text(t.date.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "AMOUNT (INR)",
          width: 140,
          isNumeric: true,
          builder: (t) => Text("₹${t.amount.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: t.type == BankTransactionType.deposit
                    ? Colors.green
                    : Colors.red,
              )),
        ),
        ZenoTableColumn(
          label: "ACCOUNT",
          width: 180,
          builder: (t) => Text(t.bankAccountId.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
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
          label: "FRAUD SCORE",
          builder: (t) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12,
                  color: t.aiFraudScore > 50 ? Colors.red : Colors.green),
              const SizedBox(width: 8),
              Text("${t.aiFraudScore.toInt()}%",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: t.aiFraudScore > 50 ? Colors.red : Colors.green)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, BankTransaction? t) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Transaction Summary"))),
        const ZenoInspectorTab(
            label: "Reconciliation",
            icon: Icons.checklist_rtl_rounded,
            child: Center(child: Text("Statement Match Logic"))),
        const ZenoInspectorTab(
            label: "Bank Detail",
            icon: Icons.account_balance_rounded,
            child: Center(child: Text("Beneficiary Info"))),
        const ZenoInspectorTab(
            label: "Documents",
            icon: Icons.attachment_rounded,
            child: Center(child: Text("Cheque / Advice Images"))),
        const ZenoInspectorTab(
            label: "AI Cash Flow",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Predictive Liquidity Curve"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH TX / ACCOUNT / BANK...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "TREASURY LIVE: SYNCED", isActive: true),
        const ZenoStatusDot(label: "CASH RESERVE: OPTIMAL", isActive: true),
      ];

  static Color _getStatusColor(BankTransactionStatus status) {
    switch (status) {
      case BankTransactionStatus.reconciled:
        return Colors.green;
      case BankTransactionStatus.cleared:
        return Colors.blue;
      case BankTransactionStatus.pending:
        return Colors.orange;
      case BankTransactionStatus.failed:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
