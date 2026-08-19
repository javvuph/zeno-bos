import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/accounts_payable.dart';
import '../../domain/models/payment_status.dart';
import '../widgets/payment_schedule_panel.dart';
import '../widgets/payable_accounting_panel.dart';

/// PayablesWorkspaceManifest v1.0
/// Enterprise Command Center for Accounts Payable and Cash Outflow management.
class PayablesWorkspaceManifest extends ZenoWorkspaceManifest<AccountsPayable> {
  const PayablesWorkspaceManifest()
      : super(
          id: 'accounts_payable_360',
          title: 'Finance / Payables',
          subtitle:
              'FINANCIAL LIQUIDITY HUB: MANAGE VENDOR LIABILITIES, SCHEDULE DISBURSEMENTS, AND OPTIMIZE WORKING CAPITAL.',
          icon: Icons.payments_rounded,
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
            label: "⚡ New Payment",
            icon: Icons.add_card_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Approve Bulk",
            icon: Icons.verified_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Schedule",
            icon: Icons.event_note_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Pending", isSelected: true),
        const ZenoChip(label: "Due This Week", color: Colors.blue),
        const ZenoChip(label: "Overdue", color: Colors.red),
        const ZenoChip(label: "On Hold", color: Colors.orange),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Outstanding",
            value: "₹4.8M",
            icon: Icons.account_balance_wallet_outlined),
        const ZenoKpiData(
            label: "Due Today",
            value: "₹120K",
            icon: Icons.today_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Overdue",
            value: "₹45K",
            icon: Icons.warning_amber_rounded,
            color: Colors.red),
        const ZenoKpiData(
            label: "Cash Req (7D)",
            value: "₹950K",
            icon: Icons.trending_down_rounded,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<AccountsPayable>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "SUPPLIER",
          width: 220,
          builder: (p) => Text(p.supplierId.toUpperCase(),
              style:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
        ),
        ZenoTableColumn(
          label: "INVOICE / BILL",
          width: 200,
          builder: (p) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(p.invoiceNumber,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold)),
              Text("REF: ${p.vendorBillId}",
                  style: const TextStyle(fontSize: 8, color: Colors.grey)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "OUTSTANDING",
          width: 140,
          isNumeric: true,
          builder: (p) => Text("₹${p.amount.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (p) => ZenoBadge(
            label: p.status.name.toUpperCase(),
            color: _getStatusColor(p.status),
          ),
        ),
        ZenoTableColumn(
          label: "DUE IN",
          width: 120,
          builder: (p) => Text("${p.daysOutstanding} DAYS",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: p.daysOutstanding < 0 ? Colors.red : Colors.green)),
        ),
        ZenoTableColumn(
          label: "AI RISK",
          builder: (p) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12, color: _getRiskColor(p.aiRiskScore)),
              const SizedBox(width: 8),
              Text("${p.aiRiskScore.toInt()}%",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getRiskColor(p.aiRiskScore))),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, AccountsPayable? p) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Payable Summary"))),
        if (p != null)
          ZenoInspectorTab(
              label: "Schedule",
              icon: Icons.event_note_rounded,
              child: PaymentSchedulePanel(payable: p)),
        if (p != null)
          ZenoInspectorTab(
              label: "Entries",
              icon: Icons.account_balance_rounded,
              child: PayableAccountingPanel(payable: p)),
        const ZenoInspectorTab(
            label: "Approvals",
            icon: Icons.verified_user_outlined,
            child: Center(child: Text("Workflow Status"))),
        const ZenoInspectorTab(
            label: "AI Flow",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Neural Liquidity Insights"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("TYPE COMMAND: /pay, /schedule, /urgent...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "BANK API: CONNECTED", isActive: true),
        const ZenoStatusDot(label: "PAYMENT GATE: ACTIVE", isActive: true),
      ];

  static Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.paid:
        return Colors.green;
      case PaymentStatus.approved:
        return Colors.blue;
      case PaymentStatus.scheduled:
        return Colors.indigo;
      case PaymentStatus.overdue:
        return Colors.red;
      case PaymentStatus.onHold:
        return Colors.orange;
      case PaymentStatus.disputed:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static Color _getRiskColor(double score) {
    if (score > 80) return Colors.red;
    if (score > 50) return Colors.orange;
    return Colors.green;
  }
}
