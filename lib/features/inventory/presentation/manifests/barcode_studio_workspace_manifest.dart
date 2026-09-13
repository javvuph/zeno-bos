import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/product.dart';

/// BarcodeStudioWorkspaceManifest v1.0
/// Manifest for the Product Identification Center.
class BarcodeStudioWorkspaceManifest extends ZenoWorkspaceManifest<Product> {
  const BarcodeStudioWorkspaceManifest()
      : super(
          id: 'barcode_studio',
          title: 'Inventory / Barcode Printing',
          subtitle:
              'ENGINEER INDUSTRIAL IDENTIFICATION, QR STANDARDS, AND TACTICAL PRINT QUEUES.',
          icon: Icons.qr_code_scanner_rounded,
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
            label: "⚡ New Barcode",
            icon: Icons.auto_mode_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Label Designer",
            icon: Icons.design_services_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
        ZenoButton(
            label: "Print History",
            icon: Icons.history_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Items", isSelected: true),
        const ZenoChip(label: "Missing Barcode"),
        const ZenoChip(label: "Needs Label"),
        const ZenoChip(label: "Print Queue"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Identified", value: "18,420", icon: Icons.qr_code_2),
        const ZenoKpiData(
            label: "Pending Barcodes",
            value: "124",
            icon: Icons.warning_amber_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Labels Printed (Today)",
            value: "842",
            icon: Icons.print_outlined,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<Product>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Identifiable Item",
          width: 320,
          builder: (p) => Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.inventory_2_outlined,
                    size: 16, color: Color(0xFF64748B)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(p.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(p.sku.value,
                      style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Barcode ID",
          width: 180,
          builder: (p) => Row(
            children: [
              const Icon(Icons.reorder_rounded, size: 14, color: Colors.black),
              const SizedBox(width: 8),
              Text(p.barcode?.value ?? "UNASSIGNED",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: p.barcode != null ? Colors.black : Colors.red)),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Format",
          width: 100,
          builder: (p) => ZenoBadge(
              label: p.barcode?.type ?? "N/A", color: Colors.blueGrey),
        ),
        ZenoTableColumn(
          label: "Print Status",
          builder: (p) => const ZenoBadge(label: "SYNCED", color: Colors.green),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Product? product) =>
      [
        const ZenoInspectorTab(
            label: "Preview",
            icon: Icons.preview_rounded,
            child: Center(child: Text("Label Visual Preview"))),
        const ZenoInspectorTab(
            label: "Generator",
            icon: Icons.auto_fix_high,
            child: Center(child: Text("Code Generation Logic"))),
        const ZenoInspectorTab(
            label: "History",
            icon: Icons.history_rounded,
            child: Center(child: Text("Print Logs"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH SKU / BARCODE...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "PRINTER: ONLINE", isActive: true),
        const ZenoStatusDot(label: "SCANNER: CONNECTED", isActive: true),
      ];
}
