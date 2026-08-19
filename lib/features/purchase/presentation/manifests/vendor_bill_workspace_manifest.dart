import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/vendor_bill.dart';
import '../../domain/models/vendor_bill_status.dart';

/// VendorBillWorkspaceManifest v1.0
/// Financial reconciliation hub for Procurement & Accounts Payable.
class VendorBillWorkspaceManifest extends ZenoWorkspaceManifest<VendorBill> {
  const VendorBillWorkspaceManifest()
      : super(
          id: 'vendor_bills_command',
          title: 'Procurement / Vendor Bills',
          subtitle:
              'FINANCIAL CONTROL CENTER: VERIFY INVOICES, PERFORM 3-WAY MATCHING, AND APPROVE PAYABLES.',
          icon: Icons.receipt_long_rounded,
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
            label: "⚡ New Vendor Bill",
            icon: Icons.receipt_long_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "3-Way Match",
            icon: Icons.rule_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Import Invoice",
            icon: Icons.file_upload_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Pending Verification", isSelected: true),
        const ZenoChip(label: "Ready for Approval", color: Colors.blue),
        const ZenoChip(label: "Overdue", color: Colors.red),
        const ZenoChip(label: "Paid"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Draft Bills",
            value: "14",
            icon: Icons.description_outlined),
        const ZenoKpiData(
            label: "Pending Match",
            value: "28",
            icon: Icons.compare_arrows_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Due This Week",
            value: "₹840K",
            icon: Icons.event_note_rounded,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "AI Match Rate",
            value: "92%",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<VendorBill>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "BILL IDENTITY",
          width: 220,
          builder: (b) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(b.id,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              Text("INV: ${b.invoiceNumber}",
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "SUPPLIER",
          width: 180,
          builder: (b) => Text(b.supplierId.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "DOC LINKS",
          width: 160,
          builder: (b) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (b.poId != null)
                Text("PO: ${b.poId}",
                    style: const TextStyle(fontSize: 8, color: Colors.blue)),
              if (b.grnId != null)
                Text("GRN: ${b.grnId}",
                    style: const TextStyle(fontSize: 8, color: Colors.green)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "TOTAL (USD)",
          width: 140,
          isNumeric: true,
          builder: (b) => Text("\$${b.totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "VERIFICATION",
          width: 140,
          builder: (b) => ZenoBadge(
            label: b.status.name.toUpperCase(),
            color: _getStatusColor(b.status),
          ),
        ),
        ZenoTableColumn(
          label: "MATCH SCORE",
          width: 120,
          builder: (b) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12,
                  color: b.aiMatchScore > 90
                      ? const Color(0xFF00F0FF)
                      : Colors.orange),
              const SizedBox(width: 8),
              Text("${b.aiMatchScore.toInt()}%",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: b.aiMatchScore > 90
                          ? const Color(0xFF00F0FF)
                          : Colors.orange)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "DUE DATE",
          builder: (b) => Text(b.dueDate.toString().substring(0, 10),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, VendorBill? bill) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Bill Summary"))),
        const ZenoInspectorTab(
            label: "3-Way Match",
            icon: Icons.rule_rounded,
            child: Center(child: Text("PO vs GRN vs Invoice"))),
        const ZenoInspectorTab(
            label: "Tax Details",
            icon: Icons.gavel_outlined,
            child: Center(child: Text("GST/VAT Breakdown"))),
        const ZenoInspectorTab(
            label: "Postings",
            icon: Icons.account_balance_rounded,
            child: Center(child: Text("Journal Entry Preview"))),
        const ZenoInspectorTab(
            label: "AI Audit",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Anomaly Detection Logic"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH BILL / SUPPLIER / INVOICE...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "FINANCE BRIDGE: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "AP LEDGER: SYNCED", isActive: true),
      ];

  static Color _getStatusColor(VendorBillStatus status) {
    switch (status) {
      case VendorBillStatus.verified:
        return Colors.green;
      case VendorBillStatus.mismatch:
        return Colors.red;
      case VendorBillStatus.approved:
        return Colors.blue;
      case VendorBillStatus.paid:
        return Colors.indigo;
      case VendorBillStatus.overdue:
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }
}
