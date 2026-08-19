import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/warehouse.dart';

/// WarehousesWorkspaceManifest v1.0
/// Manifest for managing multi-location inventory nodes.
class WarehousesWorkspaceManifest extends ZenoWorkspaceManifest<Warehouse> {
  const WarehousesWorkspaceManifest()
      : super(
          id: 'warehouses_manager',
          title: 'Inventory / Warehouses \u0026 Locations',
          subtitle:
              'OPTIMIZE MULTI-LOCATION STORAGE, BIN MAPPING, AND DISTRIBUTION LOGISTICS.',
          icon: Icons.warehouse_outlined,
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
            label: "Add Warehouse",
            icon: Icons.add_home_work_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Zone Config",
            icon: Icons.grid_goldenratio_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Nodes", isSelected: true),
        const ZenoChip(label: "Distribution Centers"),
        const ZenoChip(label: "Retail Backrooms"),
        const ZenoChip(label: "Cold Storage"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Locations",
            value: "12",
            icon: Icons.warehouse_outlined),
        const ZenoKpiData(
            label: "Global Capacity",
            value: "84%",
            icon: Icons.pie_chart_outline,
            color: Colors.orange,
            change: "5%",
            isPositive: true),
        const ZenoKpiData(
            label: "Active Zones",
            value: "48",
            icon: Icons.layers_outlined,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<Warehouse>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Warehouse Node",
          width: 320,
          builder: (w) => Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 16, color: Color(0xFF6366F1)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(w.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(w.id,
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
          label: "Zones",
          width: 120,
          builder: (w) => Text("${w.zones.length} ZONES",
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Util. Load",
          width: 150,
          builder: (w) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("78.5%",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              LinearProgressIndicator(
                  value: 0.78,
                  minHeight: 2,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.blue),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Status",
          builder: (w) => ZenoBadge(
              label: w.isActive ? "ACTIVE" : "INACTIVE",
              color: w.isActive ? Colors.green : Colors.red),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Warehouse? warehouse) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Node Details"))),
        const ZenoInspectorTab(
            label: "Bin Mapping",
            icon: Icons.grid_view_rounded,
            child: Center(child: Text("Shelf & Rack Topology"))),
        const ZenoInspectorTab(
            label: "Stock Distribution",
            icon: Icons.inventory_2_outlined,
            child: Center(child: Text("Current Payload"))),
        const ZenoInspectorTab(
            label: "Cold Chain",
            icon: Icons.thermostat_rounded,
            child: Center(child: Text("Temperature Monitoring"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH WAREHOUSES / BINS...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "GRID: OPTIMIZED", isActive: true),
      ];
}
