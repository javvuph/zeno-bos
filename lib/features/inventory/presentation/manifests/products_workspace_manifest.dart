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
import 'package:get_it/get_it.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';

/// ProductsWorkspaceManifest v1.1
/// Reference implementation of the ZENO Workspace Manifest with Adaptive Engine.
class ProductsWorkspaceManifest extends ZenoWorkspaceManifest<Product> {
  const ProductsWorkspaceManifest()
      : super(
          id: 'products_command_center',
          title: 'Inventory / Products',
          subtitle:
              'CENTRALIZED INTELLIGENCE HUB FOR GLOBAL PRODUCT CATALOGUE AND INVENTORY TOPOLOGY.',
          icon: Icons.inventory_2_outlined,
          toolbarActions: _getToolbarActions,
          filterActions: _getFilterActions,
          kpiMetrics: _getKpiMetrics,
          tableColumns: _getTableColumns,
          inspectorTabs: _getInspectorTabs,
          commandVessel: _getCommandVessel,
          statusBarIndicators: _getStatusBarIndicators,
        );

  static List<Widget> _getToolbarActions(BuildContext context) => [
        ZenoButton(
            label: "Add Product",
            icon: Icons.add_box_outlined,
            size: ZenoButtonSize.sm,
            onPressed: () => NavigationController().navigateTo('inventory/studio')),
        ZenoButton(
            label: "Export",
            icon: Icons.download_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
        ZenoButton(
            label: "Bulk Edit",
            icon: Icons.edit_note_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {}),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "All Products", isSelected: true),
        const ZenoChip(label: "In Stock"),
        const ZenoChip(label: "Out of Stock"),
        const ZenoChip(label: "Expiring"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Total Items",
            value: "24,850",
            icon: Icons.inventory_2_outlined),
        const ZenoKpiData(
            label: "Inventory Value",
            value: "₹1.4M",
            icon: Icons.account_balance_wallet_outlined,
            change: "12%",
            isPositive: true),
        const ZenoKpiData(
            label: "Stock At Risk",
            value: "142",
            icon: Icons.warning_amber_rounded,
            color: Colors.orange),
        const ZenoKpiData(
            label: "Critical Alerts",
            value: "12",
            icon: Icons.error_outline_rounded,
            color: Colors.red),
      ];

  static List<ZenoTableColumn<Product>> _getTableColumns(BuildContext context) {
    final storeController = GetIt.instance<StoreSetupController>();
    final industry = storeController.stores.first.industry;

    return [
      ZenoTableColumn(
        label: "Product Identity",
        width: 300,
        builder: (p) => Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6)),
              child: const Icon(Icons.image_outlined,
                  size: 14, color: Color(0xFF64748B)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
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
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5)),
                ],
              ),
            ),
          ],
        ),
      ),

      // ADAPTIVE COLUMNS BASED ON INDUSTRY MATRIX
      if (industry.contains('Fashion')) ...[
        ZenoTableColumn(
            label: "Size/Color",
            width: 120,
            builder: (p) =>
                const Text("XL / BLUE", style: TextStyle(fontSize: 10))),
        ZenoTableColumn(
            label: "Collection",
            width: 120,
            builder: (p) =>
                const Text("Summer '24", style: TextStyle(fontSize: 10))),
      ],

      if (industry.contains('Pharmacy')) ...[
        ZenoTableColumn(
            label: "Batch",
            width: 100,
            builder: (p) =>
                const Text("BCH-992", style: TextStyle(fontSize: 10))),
        ZenoTableColumn(
            label: "Expiry",
            width: 100,
            builder: (p) => const Text("Oct 2026",
                style: TextStyle(fontSize: 10, color: Colors.red))),
      ],

      ZenoTableColumn(
        label: "Retail Price",
        width: 120,
        isNumeric: true,
        builder: (p) => Text("₹${p.basePrice.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.w900)),
      ),

      ZenoTableColumn(
        label: "Stock Level",
        width: 110,
        builder: (p) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("1,240 PCS",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ZenoBadge(label: "Active", color: Colors.green.shade600),
          ],
        ),
      ),

      ZenoTableColumn(
        label: "Warehouse Node",
        builder: (p) => const Text("MAIN DEPOT (A-12)",
            style: TextStyle(
                fontSize: 9,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600)),
      ),
    ];
  }

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Product? product) =>
      [
        ZenoInspectorTab(
          label: "Overview",
          icon: Icons.info_outline_rounded,
          child: _InspectorSection(
              title: "IDENTITY",
              child: Text("Basic info for ${product?.name ?? '...'}")),
        ),
        const ZenoInspectorTab(
            label: "Pricing",
            icon: Icons.payments_outlined,
            child: Center(child: Text("Pricing Engine"))),
        const ZenoInspectorTab(
            label: "Inventory",
            icon: Icons.warehouse_outlined,
            child: Center(child: Text("Global Topology"))),
        const ZenoInspectorTab(
            label: "AI Intelligence",
            icon: Icons.auto_awesome,
            child: Center(child: Text("Predictive Insights"))),
        const ZenoInspectorTab(
            label: "Audit Trail",
            icon: Icons.history_rounded,
            child: Center(child: Text("History & Logs"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH OR TYPE COMMAND (Ctrl + L)...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "MASTER DATA: SYNCED", isActive: true),
        const ZenoStatusDot(label: "LOCAL DATABASE: ACTIVE", isActive: true),
      ];
}

class _InspectorSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _InspectorSection({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                  letterSpacing: 1.0)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
