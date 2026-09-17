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
import '../controllers/product_controller.dart';

/// ProductsWorkspaceManifest v1.2
/// Real Isar Database-backed Implementation of Product Catalog & Inventory Topology.
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

  static List<ZenoKpiData> getKpiMetricsForProducts(List<Product> products) {
    final totalItems = products.length;
    double totalInventoryValue = 0.0;
    int stockAtRisk = 0;
    int criticalAlerts = 0;

    for (final p in products) {
      final stockVal = p.stockLevel;
      final stock = stockVal.round();

      final cost = p.baseCost > 0 ? p.baseCost : p.basePrice;
      totalInventoryValue += (stock * cost);

      if (stock == 0) {
        criticalAlerts++;
      } else if (stock <= p.reorderLevel || stock <= 2) {
        stockAtRisk++;
      }
    }

    return [
      ZenoKpiData(
        label: "Total Items",
        value: totalItems.toString(),
        icon: Icons.inventory_2_outlined,
      ),
      ZenoKpiData(
        label: "Inventory Value",
        value: "₹${totalInventoryValue.toStringAsFixed(0)}",
        icon: Icons.account_balance_wallet_outlined,
        change: "+2.4%",
        isPositive: true,
      ),
      ZenoKpiData(
        label: "Stock At Risk",
        value: stockAtRisk.toString(),
        icon: Icons.warning_amber_rounded,
        color: Colors.orange,
      ),
      ZenoKpiData(
        label: "Critical Alerts",
        value: criticalAlerts.toString(),
        icon: Icons.error_outline_rounded,
        color: Colors.red,
      ),
    ];
  }

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) {
    final products = GetIt.instance<ProductController>().allProducts;
    return getKpiMetricsForProducts(products);
  }

  static List<ZenoTableColumn<Product>> _getTableColumns(BuildContext context) {
    final storeController = GetIt.instance<StoreSetupController>();
    final industry = storeController.stores.isNotEmpty ? storeController.stores.first.industry : "Fashion";

    return [
      ZenoTableColumn(
        label: "Product Identity",
        width: 280,
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
                          fontWeight: FontWeight.w900, fontSize: 11),
                      overflow: TextOverflow.ellipsis),
                  Text(p.sku.value,
                      style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),

      // ADAPTIVE COLUMNS BASED ON INDUSTRY MATRIX
      if (industry.contains('Fashion')) ...[
        ZenoTableColumn(
            label: "Variants",
            width: 150,
            builder: (p) {
              if (p.variants.isEmpty) {
                return const Text("Standalone Item", style: TextStyle(fontSize: 10, color: Color(0xFF64748B)));
              }
              final summary = p.variants.map((v) => "${v.attributes["Color"] ?? ''}/${v.attributes["Size"] ?? ''}").take(2).join(', ');
              return Text(
                "${p.variants.length} Variants ($summary...)",
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                overflow: TextOverflow.ellipsis,
              );
            }),
        ZenoTableColumn(
            label: "Collection / Season",
            width: 120,
            builder: (p) => Text(
                  p.industry.season != null && p.industry.season!.isNotEmpty ? p.industry.season! : (p.category?.name ?? "General"),
                  style: const TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                )),
      ],

      ZenoTableColumn(
        label: "Retail Price",
        width: 110,
        isNumeric: true,
        builder: (p) => Text("₹${p.basePrice.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.w900)),
      ),

      ZenoTableColumn(
        label: "Stock Level",
        width: 110,
        builder: (p) {
          final totalStock = p.stockLevel.round();
          final isAvailable = totalStock > 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$totalStock PCS",
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ZenoBadge(
                label: isAvailable ? "In Stock" : "Out of Stock",
                color: isAvailable ? Colors.green.shade600 : Colors.red.shade600,
              ),
            ],
          );
        },
      ),

      ZenoTableColumn(
        label: "Warehouse Node",
        builder: (p) => Text(
          p.warehouseLocation.isNotEmpty ? p.warehouseLocation : "MAIN DEPOT",
          style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  static List<ZenoInspectorTab> getInspectorTabsForProduct(
          BuildContext context, Product? product) {
    if (product == null) return [];

    final totalStock = product.stockLevel.round();

    return [
      ZenoInspectorTab(
        label: "Overview",
        icon: Icons.info_outline_rounded,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow("Style Title", product.name),
              _detailRow("Master Style Code (SKU)", product.sku.value),
              _detailRow("Category", product.category?.name ?? "General"),
              _detailRow("Brand / Label", product.brand?.name ?? "Default"),
              _detailRow("Selling Price / MRP", "₹${product.basePrice.toStringAsFixed(2)}"),
              _detailRow("Cost Price", "₹${product.baseCost.toStringAsFixed(2)}"),
              _detailRow("Total Variants", "${product.variants.length}"),
              _detailRow("Total Calculated Stock", "$totalStock PCS"),
            ],
          ),
        ),
      ),
      ZenoInspectorTab(
        label: "Variants (${product.variants.length})",
        icon: Icons.grid_view_outlined,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: product.variants.isEmpty
              ? const Center(child: Text("No variants for this product", style: TextStyle(fontSize: 11, color: Colors.grey)))
              : SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 16,
                    headingRowHeight: 32,
                    dataRowMinHeight: 32,
                    dataRowMaxHeight: 36,
                    columns: const [
                      DataColumn(label: Text("COLOUR", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("SIZE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("VARIANT SKU", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("BARCODE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("QTY", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                    rows: product.variants.map((v) => DataRow(cells: [
                      DataCell(Text(v.attributes["Color"] ?? "-", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      DataCell(Text(v.attributes["Size"] ?? "-", style: const TextStyle(fontSize: 10))),
                      DataCell(Text(v.sku.value, style: const TextStyle(fontSize: 9, fontFamily: 'monospace'))),
                      DataCell(Text(v.barcode?.value ?? "AUTO", style: const TextStyle(fontSize: 9, fontFamily: 'monospace'))),
                      DataCell(Text("${v.stockLevel.round()}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                    ])).toList(),
                  ),
                ),
        ),
      ),
      ZenoInspectorTab(
        label: "Pricing & Tax",
        icon: Icons.payments_outlined,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow("Base Selling Price", "₹${product.basePrice.toStringAsFixed(2)}"),
              _detailRow("Base Cost Price", "₹${product.baseCost.toStringAsFixed(2)}"),
              _detailRow("Tax Rate", "${product.taxProfile?.rate ?? 0}%"),
              _detailRow("GST Tax Mode", product.gstTaxMode),
            ],
          ),
        ),
      ),
    ];
  }

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, Product? product) =>
      getInspectorTabsForProduct(context, product);

  static Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("SEARCH OR TYPE COMMAND (Ctrl + L)...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "MASTER DATA: SYNCED", isActive: true),
        const ZenoStatusDot(label: "LOCAL DATABASE: ACTIVE", isActive: true),
      ];
}
