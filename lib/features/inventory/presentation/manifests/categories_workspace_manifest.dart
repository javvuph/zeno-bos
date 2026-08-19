import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/category.dart';

/// CategoriesWorkspaceManifest v1.0
/// Manifest for managing product categories.
class CategoriesWorkspaceManifest extends ZenoWorkspaceManifest<Category> {
  const CategoriesWorkspaceManifest()
      : super(
          id: 'categories_manager',
          title: 'Inventory / Categories',
          subtitle:
              'ORGANIZE PRODUCTS INTO STRATEGIC TAXONOMIES AND HIERARCHICAL NODES.',
          icon: Icons.category_outlined,
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
            label: "Add Category",
            icon: Icons.add_rounded,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Reorder",
            icon: Icons.reorder_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Root Level", isSelected: true),
        const ZenoChip(label: "Sub-Categories"),
        const ZenoChip(label: "Hidden"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Nodes",
            value: "42",
            icon: Icons.account_tree_outlined),
        const ZenoKpiData(
            label: "Active Categories",
            value: "38",
            icon: Icons.check_circle_outline,
            color: Colors.green),
        const ZenoKpiData(
            label: "Empty Categories",
            value: "4",
            icon: Icons.folder_open_outlined,
            color: Colors.orange),
      ];

  static List<ZenoTableColumn<Category>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Category Name",
          width: 350,
          builder: (c) => Row(
            children: [
              const Icon(Icons.folder_rounded,
                  size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(c.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(c.id,
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
          label: "Parent Node",
          width: 200,
          builder: (c) => Text(c.parentId ?? "ROOT",
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Product Count",
          width: 120,
          isNumeric: true,
          builder: (c) =>
              const Text("142", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Status",
          builder: (c) => const ZenoBadge(label: "ACTIVE", color: Colors.green),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Category? category) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Node Details"))),
        const ZenoInspectorTab(
            label: "Hierarchy",
            icon: Icons.account_tree_outlined,
            child: Center(child: Text("Parent/Child Relations"))),
        const ZenoInspectorTab(
            label: "Products",
            icon: Icons.inventory_2_outlined,
            child: Center(child: Text("Linked Items"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH CATEGORIES...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "HIERARCHY: SYNCED", isActive: true),
      ];
}
