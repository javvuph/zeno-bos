import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/unit.dart';

/// UnitsWorkspaceManifest v1.0
/// Manifest for managing units of measure (UOM).
class UnitsWorkspaceManifest extends ZenoWorkspaceManifest<Unit> {
  const UnitsWorkspaceManifest()
      : super(
          id: 'units_manager',
          title: 'Inventory / Units',
          subtitle:
              'DEFINE GLOBAL MEASUREMENT STANDARDS, CONVERSION FACTORS, AND PACKAGING QUANTITIES.',
          icon: Icons.straighten_rounded,
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
            label: "Add Unit",
            icon: Icons.add_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Define Conversion",
            icon: Icons.swap_vert_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Weight", isSelected: true),
        const ZenoChip(label: "Volume"),
        const ZenoChip(label: "Discrete"),
        const ZenoChip(label: "Dimensions"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Standard Units",
            value: "24",
            icon: Icons.straighten_rounded),
        const ZenoKpiData(
            label: "Conversions",
            value: "112",
            icon: Icons.calculate_outlined,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Global UOMs",
            value: "8",
            icon: Icons.public,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<Unit>> _getTableColumns(BuildContext context) => [
        ZenoTableColumn(
          label: "Unit Definition",
          width: 300,
          builder: (u) => Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.scale_rounded,
                    size: 16, color: Color(0xFF10B981)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(u.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(u.symbol.toUpperCase(),
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
          label: "System ID",
          width: 200,
          builder: (u) => Text(u.id,
              style: const TextStyle(fontSize: 9, fontFamily: 'monospace')),
        ),
        ZenoTableColumn(
          label: "Usage Frequency",
          width: 150,
          isNumeric: true,
          builder: (u) => const Text("High",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        ),
        ZenoTableColumn(
          label: "Base Unit",
          builder: (u) =>
              const ZenoBadge(label: "STANDARD", color: Colors.green),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Unit? unit) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("UOM Specs"))),
        const ZenoInspectorTab(
            label: "Conversions",
            icon: Icons.calculate_outlined,
            child: Center(child: Text("Conversion Matrix"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH UNITS...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "METRICS: ISO 80000", isActive: true),
      ];
}
