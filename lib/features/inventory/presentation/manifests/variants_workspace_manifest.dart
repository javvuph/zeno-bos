import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/features/inventory/domain/models/product_variant.dart';

/// VariantsWorkspaceManifest v1.0
/// Manifest for managing product variants and their complex attributes.
class VariantsWorkspaceManifest extends ZenoWorkspaceManifest<ProductVariant> {
  const VariantsWorkspaceManifest()
      : super(
          id: 'variants_manager',
          title: 'Inventory / Variants \u0026 Bundles',
          subtitle:
              'MANAGE DYNAMIC PRODUCT CHARACTERISTICS, BUNDLES, AND SKU DIFFERENTIATION.',
          icon: Icons.account_tree_outlined,
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
            label: "Define Attribute",
            icon: Icons.settings_input_component,
            size: ZenoButtonSize.sm),
        ZenoButton(
            label: "Generate SKUs",
            icon: Icons.auto_fix_high,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Variants", isSelected: true),
        const ZenoChip(label: "Fashion Specs"),
        const ZenoChip(label: "Tech Specs"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Variants",
            value: "1,245",
            icon: Icons.account_tree_outlined),
        const ZenoKpiData(
            label: "Attributes",
            value: "12",
            icon: Icons.tune_rounded,
            color: Colors.indigo),
        const ZenoKpiData(
            label: "Active Skus",
            value: "854",
            icon: Icons.qr_code_2,
            color: Colors.green),
      ];

  static List<ZenoTableColumn<ProductVariant>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "Variant Identity",
          width: 300,
          builder: (v) => Row(
            children: [
              const Icon(Icons.style_outlined,
                  size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(v.displayName.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(v.sku.value,
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
          label: "Attribute Breakdown",
          width: 350,
          builder: (v) => Wrap(
            spacing: 4,
            children: v.attributes.entries
                .map((e) => ZenoBadge(
                    label: "${e.key}: ${e.value}", color: Colors.blueGrey))
                .toList(),
          ),
        ),
        ZenoTableColumn(
          label: "Adjust.",
          width: 100,
          isNumeric: true,
          builder: (v) => Text(
              "${v.priceAdjustment >= 0 ? '+' : ''}₹${v.priceAdjustment}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Live Stock",
          builder: (v) => Text("${v.stockLevel.toInt()} PCS",
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, ProductVariant? variant) =>
      [
        const ZenoInspectorTab(
            label: "Overview",
            icon: Icons.info_outline_rounded,
            child: Center(child: Text("Variant Detail"))),
        const ZenoInspectorTab(
            label: "Stock Nodes",
            icon: Icons.warehouse_outlined,
            child: Center(child: Text("Location Breakdown"))),
        const ZenoInspectorTab(
            label: "Pricing",
            icon: Icons.payments_outlined,
            child: Center(child: Text("Margin Analysis"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH VARIANTS / ATTRIBUTES...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "ENGINE: DYNAMIC", isActive: true),
      ];
}
