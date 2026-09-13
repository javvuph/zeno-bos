import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/grn.dart';

/// GRNWorkspaceManifest v1.0
/// Operational manifest for Goods Receipt and Inward Logistics in ZENO BOS.
class GRNWorkspaceManifest extends ZenoWorkspaceManifest<GRN> {
  const GRNWorkspaceManifest()
      : super(
          id: 'grn_command_center',
          title: 'Procurement / Receiving',
          subtitle:
              'INWARD LOGISTICS HUB: VALIDATE SHIPMENTS, INSPECT QUALITY, AND UPDATE GLOBAL INVENTORY LEDGERS.',
          icon: Icons.input_rounded,
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
            label: "⚡ New GRN",
            icon: Icons.add_shopping_cart_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Receive Partial",
            icon: Icons.move_to_inbox_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Quality Inspection",
            icon: Icons.fact_check_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Expected Today", isSelected: true),
        const ZenoChip(label: "In Inspection"),
        const ZenoChip(label: "Partial Receipts", color: Colors.orange),
        const ZenoChip(label: "Completed"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Expected Today",
            value: "12",
            icon: Icons.local_shipping_outlined),
        const ZenoKpiData(
            label: "Received Today",
            value: "8",
            icon: Icons.task_alt_rounded,
            color: Colors.green),
        const ZenoKpiData(
            label: "Quality Hold",
            value: "3",
            icon: Icons.rule_folder_outlined,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Rejected",
            value: "₹1.2K",
            icon: Icons.cancel_presentation_outlined,
            color: Colors.red),
      ];

  static List<ZenoTableColumn<GRN>> _getTableColumns(BuildContext context) => [
        ZenoTableColumn(
          label: "GRN NUMBER",
          width: 180,
          builder: (g) => Text(g.id,
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  fontFamily: 'monospace')),
        ),
        ZenoTableColumn(
          label: "PURCHASE ORDER",
          width: 140,
          builder: (g) => Text(g.poId.toUpperCase(),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "SUPPLIER",
          width: 200,
          builder: (g) => Text(g.supplierId.toUpperCase(),
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
        ZenoTableColumn(
          label: "QUANTITY (RECV/EXP)",
          width: 180,
          isNumeric: true,
          builder: (g) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${g.totalReceivedQuantity.toInt()} PCS",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 11)),
              const Text(" / ", style: TextStyle(color: Colors.grey)),
              const Text("500", style: TextStyle(fontSize: 10)), // Mock PO Qty
            ],
          ),
        ),
        ZenoTableColumn(
          label: "QUALITY",
          width: 140,
          builder: (g) => ZenoBadge(
            label: g.qualityStatus.name.toUpperCase(),
            color: _getQualityColor(g.qualityStatus),
          ),
        ),
        ZenoTableColumn(
          label: "LIFECYCLE STATE",
          width: 160,
          builder: (g) => ZenoBadge(
            label: g.status.name.toUpperCase().replaceAll('_', ' '),
            color: _getStatusColor(g.status),
          ),
        ),
        ZenoTableColumn(
          label: "RECEIVER",
          builder: (g) => Text(g.receivedById.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, GRN? grn) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("GRN Summary"))),
        const ZenoInspectorTab(
            label: "Received Items",
            icon: Icons.inventory_2_outlined,
            child: Center(child: Text("Line Item Discrepancy"))),
        const ZenoInspectorTab(
            label: "Quality",
            icon: Icons.fact_check_outlined,
            child: Center(child: Text("Inspection Reports"))),
        const ZenoInspectorTab(
            label: "Warehouse",
            icon: Icons.warehouse_outlined,
            child: Center(child: Text("Bin & Zone Allocation"))),
        const ZenoInspectorTab(
            label: "Finance",
            icon: Icons.receipt_long_outlined,
            child: Center(child: Text("Vendor Bill Preview"))),
        const ZenoInspectorTab(
            label: "AI Strategy",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Anomaly Detection"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH GRN / PO / SUPPLIER...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "INWARD GATE: SYNCED", isActive: true),
        const ZenoStatusDot(label: "ITE LEDGER: LIVE", isActive: true),
      ];

  static Color _getStatusColor(GRNStatus status) {
    switch (status) {
      case GRNStatus.completed:
        return Colors.green;
      case GRNStatus.receiving:
        return Colors.blue;
      case GRNStatus.partial:
        return Colors.orange;
      case GRNStatus.rejected:
        return Colors.red;
      case GRNStatus.qualityHold:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static Color _getQualityColor(QualityStatus status) {
    switch (status) {
      case QualityStatus.passed:
        return Colors.green;
      case QualityStatus.failed:
        return Colors.red;
      case QualityStatus.conditional:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
