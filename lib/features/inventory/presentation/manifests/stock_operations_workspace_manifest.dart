import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/inventory_transaction.dart';

/// StockOperationsWorkspaceManifest v1.0
/// Operational dashboard for all ITE-driven inventory movements.
class StockOperationsWorkspaceManifest
    extends ZenoWorkspaceManifest<InventoryTransaction> {
  const StockOperationsWorkspaceManifest()
      : super(
          id: 'stock_operations',
          title: 'Inventory / Stock Operations',
          subtitle:
              'TACTICAL LOG OF ALL GLOBAL INVENTORY MOVEMENTS, ADJUSTMENTS, AND COMPLIANCE AUDITS.',
          icon: Icons.swap_vert_rounded,
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
            label: "⚡ New Operation",
            icon: Icons.playlist_add_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Stock Transfer",
            icon: Icons.move_up_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Adjustment",
            icon: Icons.tune_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Today's Log", isSelected: true),
        const ZenoChip(label: "Pending Approvals"),
        const ZenoChip(label: "GRN Receipts"),
        const ZenoChip(label: "Internal Transfers"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Daily Movements", value: "1,420", icon: Icons.sync_rounded),
        const ZenoKpiData(
            label: "In Transit",
            value: "24",
            icon: Icons.local_shipping_outlined,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Pending Approvals",
            value: "12",
            icon: Icons.verified_outlined,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Loss / Damage",
            value: "₹4,250",
            icon: Icons.trending_down_rounded,
            color: Colors.red),
      ];

  static List<ZenoTableColumn<InventoryTransaction>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Transaction ID",
          width: 140,
          builder: (tx) => Text(tx.id,
              style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Movement Type",
          width: 180,
          builder: (tx) => Row(
            children: [
              Icon(_getTypeIcon(tx.type),
                  size: 14, color: _getTypeColor(tx.type)),
              const SizedBox(width: 8),
              Text(tx.typeLabel,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 10)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Quantity",
          width: 120,
          isNumeric: true,
          builder: (tx) => Text(
              "${tx.quantity > 0 ? '+' : ''}${tx.quantity} PCS",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: tx.quantity >= 0
                      ? Colors.green.shade700
                      : Colors.red.shade700)),
        ),
        ZenoTableColumn(
          label: "Reference Doc",
          width: 150,
          builder: (tx) => Text(tx.referenceDocument ?? "MANUAL",
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B))),
        ),
        ZenoTableColumn(
          label: "Warehouse Node",
          builder: (tx) => Text(tx.warehouseId.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, InventoryTransaction? tx) =>
      [
        const ZenoInspectorTab(
            label: "Transaction Details",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("ITE Core Data"))),
        const ZenoInspectorTab(
            label: "Reference Doc",
            icon: Icons.description_outlined,
            child: Center(child: Text("Attached Document Preview"))),
        const ZenoInspectorTab(
            label: "Audit Trail",
            icon: Icons.history_rounded,
            child: Center(child: Text("Approval & Movement Log"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH TRANSACTION / DOC ID...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "ITE: CONNECTED", isActive: true),
        const ZenoStatusDot(label: "LEDGER: SYNCED", isActive: true),
      ];

  static IconData _getTypeIcon(InventoryTransactionType type) {
    switch (type) {
      case InventoryTransactionType.purchaseReceipt:
        return Icons.input_rounded;
      case InventoryTransactionType.salesIssue:
        return Icons.output_rounded;
      case InventoryTransactionType.stockTransfer:
        return Icons.swap_horiz_rounded;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  static Color _getTypeColor(InventoryTransactionType type) {
    if (type == InventoryTransactionType.purchaseReceipt ||
        type == InventoryTransactionType.customerReturn) {
      return Colors.green;
    }
    if (type == InventoryTransactionType.salesIssue ||
        type == InventoryTransactionType.supplierReturn) {
      return Colors.red;
    }
    return Colors.blue;
  }
}
