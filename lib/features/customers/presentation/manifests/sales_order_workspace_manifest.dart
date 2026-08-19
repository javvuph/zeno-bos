import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/sales_order.dart';
import '../../domain/models/sales_order_status.dart';

/// SalesOrderWorkspaceManifest v1.0
/// Final Phase 8.3: Tactical Control Center for Sales Orders and Fulfillment.
class SalesOrderWorkspaceManifest extends ZenoWorkspaceManifest<SalesOrder> {
  const SalesOrderWorkspaceManifest()
      : super(
          id: 'sales_order_hub',
          title: 'Sales / Orders',
          subtitle:
              'FULFILLMENT CONTROL: MANAGE CUSTOMER ORDERS, TRACK DISPATCH, AND OPTIMIZE SHIPMENTS.',
          icon: Icons.local_shipping_rounded,
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
            label: "⚡ New Order",
            icon: Icons.add_shopping_cart_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Fulfill",
            icon: Icons.inventory_2_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Backorders",
            icon: Icons.assignment_late_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Open Orders", isSelected: true),
        const ZenoChip(label: "Processing", color: Colors.blue),
        const ZenoChip(label: "Partial", color: Colors.orange),
        const ZenoChip(label: "On Hold", color: Colors.red),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Pending Fulfill",
            value: "28",
            icon: Icons.pending_actions_rounded),
        const ZenoKpiData(
            label: "Backorders",
            value: "05",
            icon: Icons.warning_amber_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "On-time Rate",
            value: "92%",
            icon: Icons.timer_outlined,
            color: Colors.green),
        const ZenoKpiData(
            label: "Order Health",
            value: "Stable",
            icon: Icons.auto_awesome,
            color: Color(0xFF00F0FF)),
      ];

  static List<ZenoTableColumn<SalesOrder>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "ORDER IDENTITY",
          width: 220,
          builder: (o) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(o.orderNumber,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'monospace')),
              Text(o.customerId.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 8,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "ORDER DATE",
          width: 120,
          builder: (o) => Text(o.orderDate.toString().substring(0, 10),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "VALUE",
          width: 140,
          isNumeric: true,
          builder: (o) => Text("₹${o.grandTotal.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 140,
          builder: (o) => ZenoBadge(
            label: o.status.name.toUpperCase(),
            color: _getStatusColor(o.status),
          ),
        ),
        ZenoTableColumn(
          label: "FULFILLMENT",
          builder: (o) => Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: _getFulfillmentProgress(o),
                  minHeight: 4,
                  backgroundColor: Colors.white10,
                  color: _getFulfillmentColor(o),
                ),
              ),
              const SizedBox(width: 8),
              Text("${(_getFulfillmentProgress(o) * 100).toInt()}%",
                  style: const TextStyle(
                      fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, SalesOrder? o) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Order Header \u0026 SLA"))),
        const ZenoInspectorTab(
            label: "Order Items",
            icon: Icons.list_alt_rounded,
            child: Center(child: Text("Line Items \u0026 Pending Qty"))),
        const ZenoInspectorTab(
            label: "Fulfillment",
            icon: Icons.local_shipping_outlined,
            child: Center(child: Text("Picking, Packing \u0026 Shipments"))),
        const ZenoInspectorTab(
            label: "Payments",
            icon: Icons.payments_outlined,
            child: Center(child: Text("Advances \u0026 Invoices"))),
        const ZenoInspectorTab(
            label: "AI Diagnostics",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Delivery Delay Prediction"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH ORDERS: /fulfill, /hold, /cancel...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "WMS SYNC: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "CARRIER API: CONNECTED", isActive: true),
      ];

  static Color _getStatusColor(SalesOrderStatus status) {
    switch (status) {
      case SalesOrderStatus.fulfilled:
        return Colors.green;
      case SalesOrderStatus.partiallyFulfilled:
        return Colors.blue;
      case SalesOrderStatus.processing:
        return Colors.indigo;
      case SalesOrderStatus.onHold:
        return Colors.orange;
      case SalesOrderStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static double _getFulfillmentProgress(SalesOrder o) {
    if (o.items.isEmpty) return 0;
    double totalQty = o.items.fold(0, (sum, i) => sum + i.quantity);
    double fulfilledQty =
        o.items.fold(0, (sum, i) => sum + i.fulfilledQuantity);
    return fulfilledQty / totalQty;
  }

  static Color _getFulfillmentColor(SalesOrder o) {
    double p = _getFulfillmentProgress(o);
    if (p == 1.0) return Colors.green;
    if (p > 0) return Colors.blue;
    return Colors.grey;
  }
}
