import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/purchase/domain/models/purchase_order.dart';

/// PurchaseOrderWorkspaceManifest v1.0
/// Procurement Control Center for high-compliance PO management.
class PurchaseOrderWorkspaceManifest
    extends ZenoWorkspaceManifest<PurchaseOrder> {
  const PurchaseOrderWorkspaceManifest()
      : super(
          id: 'purchase_orders_360',
          title: 'Procurement / Purchase Orders',
          subtitle:
              'MASTER PROCUREMENT HUB: MANAGE LIFECYCLE FROM REQUISITION TO FINAL GOODS RECEIPT.',
          icon: Icons.shopping_cart_checkout_rounded,
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
            label: "⚡ New Purchase Order",
            icon: Icons.add_shopping_cart_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Approve Bulk",
            icon: Icons.verified_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
        ZenoButton(
            label: "Print Bulk",
            icon: Icons.print_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Orders", isSelected: true),
        const ZenoChip(label: "Pending Approval", color: Colors.orange),
        const ZenoChip(label: "Overdue", color: Colors.red),
        const ZenoChip(label: "Partial Receipts"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Open Orders",
            value: "34",
            icon: Icons.shopping_bag_outlined),
        const ZenoKpiData(
            label: "Pending Approval",
            value: "8",
            icon: Icons.verified_outlined,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Total Value",
            value: "₹2.4M",
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Exp. Today",
            value: "5",
            icon: Icons.local_shipping_outlined,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<PurchaseOrder>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "PO Identity",
          width: 250,
          builder: (po) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(po.poNumber,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              Text("REF: ${po.id.substring(0, 8).toUpperCase()}",
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Supplier Node",
          width: 200,
          builder: (po) => Row(
            children: [
              const Icon(Icons.business_outlined,
                  size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 8),
              Text(po.supplierId.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Status / Approval",
          width: 220,
          builder: (po) => Row(
            children: [
              ZenoBadge(
                  label: po.status.name.toUpperCase(),
                  color: _getStatusColor(po.status)),
              const SizedBox(width: 8),
              ZenoBadge(
                  label: po.approvalStatus.name.toUpperCase(),
                  color: _getApprovalColor(po.approvalStatus),
                  isSolid: false),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Ordered / Recv",
          width: 150,
          isNumeric: true,
          builder: (po) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${po.totalOrderedQty.toInt()} PCS",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 10)),
              Text("${po.totalReceivedQty.toInt()} RECV",
                  style: TextStyle(
                      fontSize: 8,
                      color:
                          po.totalReceivedQty > 0 ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Total Value",
          width: 140,
          isNumeric: true,
          builder: (po) => Text("₹${po.totalAmount.toStringAsFixed(0)}",
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
        ),
        ZenoTableColumn(
          label: "AI Risk",
          builder: (po) => Row(
            children: [
              Icon(Icons.auto_awesome,
                  size: 12,
                  color:
                      po.totalPendingQty > 0 ? Colors.orange : Colors.indigo),
              const SizedBox(width: 6),
              Text(po.totalPendingQty > 0 ? "LOW RISK" : "SYNCED",
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: po.totalPendingQty > 0
                          ? Colors.orange
                          : Colors.indigo)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, PurchaseOrder? po) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("360° Order Summary"))),
        const ZenoInspectorTab(
            label: "Items",
            icon: Icons.list_alt_rounded,
            child: Center(child: Text("Line Item Detail"))),
        const ZenoInspectorTab(
            label: "Supplier",
            icon: Icons.business_outlined,
            child: Center(child: Text("Vendor Compliance"))),
        const ZenoInspectorTab(
            label: "Approval",
            icon: Icons.verified_user_outlined,
            child: Center(child: Text("Workflow Gates"))),
        const ZenoInspectorTab(
            label: "Delivery",
            icon: Icons.local_shipping_outlined,
            child: Center(child: Text("Shipment Tracking"))),
        const ZenoInspectorTab(
            label: "Financial",
            icon: Icons.account_balance_wallet_outlined,
            child: Center(child: Text("Tax & AP Ledger"))),
        const ZenoInspectorTab(
            label: "Timeline",
            icon: Icons.history_rounded,
            child: Center(child: Text("Revision History"))),
        const ZenoInspectorTab(
            label: "AI Intel",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Procurement Predictions"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("TYPE COMMAND: /new po, /approve, /urgent...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "PROCURE ENGINE: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "GRN SYNC: LIVE", isActive: true),
      ];

  static Color _getStatusColor(POStatus status) {
    switch (status) {
      case POStatus.draft:
        return Colors.blueGrey;
      case POStatus.pendingApproval:
        return Colors.orange;
      case POStatus.approved:
        return Colors.indigo;
      case POStatus.ordered:
        return Colors.blue;
      case POStatus.partiallyReceived:
        return Colors.amber;
      case POStatus.received:
        return Colors.green;
      case POStatus.closed:
        return Colors.grey;
      case POStatus.cancelled:
        return Colors.red;
    }
  }

  static Color _getApprovalColor(POApprovalStatus status) {
    switch (status) {
      case POApprovalStatus.draft:
        return Colors.grey;
      case POApprovalStatus.pending:
        return Colors.orange;
      case POApprovalStatus.level1:
      case POApprovalStatus.level2:
        return Colors.blue;
      case POApprovalStatus.finalApproved:
        return Colors.green;
      case POApprovalStatus.rejected:
        return Colors.red;
    }
  }
}
