import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/brand.dart';

/// BrandsWorkspaceManifest v1.0
/// Manifest for managing product brands.
class BrandsWorkspaceManifest extends ZenoWorkspaceManifest<Brand> {
  const BrandsWorkspaceManifest()
      : super(
          id: 'brands_manager',
          title: 'Inventory / Brands',
          subtitle:
              'MANAGE GLOBAL BRAND IDENTITY, MANUFACTURER PROFILES, AND BRAND EQUITY.',
          icon: Icons.stars_rounded,
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
            label: "Add Brand",
            icon: Icons.add_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Merge Brands",
            icon: Icons.merge_type_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Own Brands", isSelected: true),
        const ZenoChip(label: "External"),
        const ZenoChip(label: "Luxury"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Brands", value: "124", icon: Icons.stars_rounded),
        const ZenoKpiData(
            label: "Top Brand",
            value: "APPLE",
            icon: Icons.trending_up,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Brand Margin",
            value: "32%",
            icon: Icons.pie_chart_outline,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<Brand>> _getTableColumns(BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Brand Identity",
          width: 300,
          builder: (b) => Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(Icons.stars_rounded,
                    size: 16, color: Color(0xFF6366F1)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(b.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(b.id,
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
          label: "Manufacturer",
          width: 250,
          builder: (b) => const Text("GLOBAL INDUSTRIES LTD",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "SKU Count",
          width: 120,
          isNumeric: true,
          builder: (b) => const Text("1,042",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Market Tier",
          builder: (b) =>
              const ZenoBadge(label: "PREMIUM", color: Colors.amber),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Brand? brand) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Brand Profile"))),
        const ZenoInspectorTab(
            label: "Portfolio",
            icon: Icons.inventory_2_outlined,
            child: Center(child: Text("Product Portfolio"))),
        const ZenoInspectorTab(
            label: "Analytics",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Market Insights"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH BRANDS...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "REGISTRY: SECURE", isActive: true),
      ];
}
