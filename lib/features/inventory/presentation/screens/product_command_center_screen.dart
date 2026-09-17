import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../widgets/inventory_kpi_cards.dart';
import '../widgets/inventory_bulk_action_bar.dart';
import '../widgets/inventory_product_row_accordion.dart';
import '../widgets/inventory_stock_modals.dart';

class ProductCommandCenterScreen extends StatefulWidget {
  const ProductCommandCenterScreen({super.key});

  @override
  State<ProductCommandCenterScreen> createState() => _ProductCommandCenterScreenState();
}

class _ProductCommandCenterScreenState extends State<ProductCommandCenterScreen> {
  late final ProductController controller;
  final Set<String> _selectedProductIds = {};
  String _activeFilter = "All Products";
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    controller = ProductController(sl<IProductRepository>());
    controller.addListener(_onUpdate);
    controller.refreshProducts();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  List<Product> get _filteredProducts {
    var list = controller.allProducts;

    // 1. Search Query Filter
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim().toLowerCase();
      list = list.where((p) {
        final matchName = p.name.toLowerCase().contains(q);
        final matchSku = p.sku.value.toLowerCase().contains(q);
        final matchCategory = p.category?.name.toLowerCase().contains(q) == true;
        final matchBrand = p.brand?.name.toLowerCase().contains(q) == true;
        final matchVariant = p.variants.any((v) =>
            v.sku.value.toLowerCase().contains(q) ||
            (v.barcode?.value.toLowerCase().contains(q) == true) ||
            (v.attributes["Color"]?.toLowerCase().contains(q) == true) ||
            (v.attributes["Size"]?.toLowerCase().contains(q) == true));
        return matchName || matchSku || matchCategory || matchBrand || matchVariant;
      }).toList();
    }

    // 2. Filter Pills
    if (_activeFilter == "In Stock") {
      return list.where((p) => p.stockLevel > 0).toList();
    } else if (_activeFilter == "Out of Stock") {
      return list.where((p) => p.stockLevel <= 0).toList();
    } else if (_activeFilter == "Expiring") {
      return list.where((p) => p.industry.seasonalProduct == true || p.industry.expiryWarningThreshold > 0).toList();
    }
    return list;
  }

  List<Product> get _selectedProducts =>
      controller.allProducts.where((p) => _selectedProductIds.contains(p.id)).toList();

  @override
  Widget build(BuildContext context) {
    final allProducts = controller.allProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WORKSPACE HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "INVENTORY / PRODUCTS",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: 0.5),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "PRODUCT MASTER • STOCK CONTROL • INVENTORY INTELLIGENCE",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.8),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                      label: const Text("ADD PRODUCT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white)),
                      onPressed: () {
                        NavigationController().navigateTo('inventory/studio');
                      },
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      icon: const Icon(Icons.download_rounded, size: 15, color: Color(0xFF334155)),
                      label: const Text("EXPORT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF334155))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Exported ${allProducts.length} items to CSV")),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      icon: const Icon(Icons.edit_note_rounded, size: 15, color: Color(0xFF334155)),
                      label: const Text("BULK EDIT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF334155))),
                      onPressed: () => _showBulkEditDialog(context),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 4 FIGMA KPI CARDS
            InventoryKpiCards(products: allProducts),
            const SizedBox(height: 16),

            // FILTER & SEARCH BAR
            Row(
              children: [
                _filterChip("ALL PRODUCTS"),
                const SizedBox(width: 6),
                _filterChip("IN STOCK"),
                const SizedBox(width: 6),
                _filterChip("OUT OF STOCK"),
                const SizedBox(width: 6),
                _filterChip("EXPIRING"),
                const Spacer(),
                SizedBox(
                  width: 320,
                  height: 36,
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: "Search product, style, SKU or barcode...",
                      hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      prefixIcon: const Icon(Icons.search_rounded, size: 16, color: Color(0xFF64748B)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // BULK ACTION BANNER (WHEN ITEMS SELECTED)
            InventoryBulkActionBar(
              selectedCount: _selectedProductIds.length,
              onStockIn: () => _handleBatchStockOp('in'),
              onStockOut: () => _handleBatchStockOp('out'),
              onSetStock: () => _handleBatchStockOp('set'),
              onTransfer: () => _handleBatchStockOp('transfer'),
              onArchive: () => InventoryStockModals.showArchiveDialog(
                context: context,
                products: _selectedProducts,
                controller: controller,
              ),
            ),

            // PRODUCT MASTER TABLE HEADER
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _filteredProducts.isNotEmpty && _selectedProductIds.length == _filteredProducts.length,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _selectedProductIds.addAll(_filteredProducts.map((p) => p.id));
                        } else {
                          _selectedProductIds.clear();
                        }
                      });
                    },
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 26),
                  const Expanded(flex: 3, child: Text("PRODUCT / STYLE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                  const Expanded(flex: 2, child: Text("RETAIL", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                  const Expanded(flex: 2, child: Text("STOCK", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                  const Expanded(flex: 2, child: Text("STATUS", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                  const Expanded(flex: 2, child: Text("LOCATION", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                  const Expanded(flex: 2, child: Text("VARIANTS", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // PRODUCT ACCORDION ROWS
            if (controller.isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_filteredProducts.isEmpty)
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 42, color: Color(0xFF94A3B8)),
                    SizedBox(height: 8),
                    Text("NO PRODUCTS FOUND", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                    SizedBox(height: 4),
                    Text("Create your first product in Product Studio or adjust search filters", style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, i) {
                  final p = _filteredProducts[i];
                  return InventoryProductRowAccordion(
                    product: p,
                    isSelected: _selectedProductIds.contains(p.id),
                    onSelectChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _selectedProductIds.add(p.id);
                        } else {
                          _selectedProductIds.remove(p.id);
                        }
                      });
                    },
                    onStockIn: (prod, varItem) => InventoryStockModals.showStockInDialog(context: context, product: prod, variant: varItem, controller: controller),
                    onStockOut: (prod, varItem) => InventoryStockModals.showStockOutDialog(context: context, product: prod, variant: varItem, controller: controller),
                    onSetStock: (prod, varItem) => InventoryStockModals.showSetStockDialog(context: context, product: prod, variant: varItem, controller: controller),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label) {
    final isSelected = label == _activeFilter;
    return InkWell(
      onTap: () => setState(() => _activeFilter = label),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFCBD5E1)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : const Color(0xFF475569)),
        ),
      ),
    );
  }

  void _handleBatchStockOp(String type) {
    final targets = _selectedProducts;
    if (targets.isEmpty) return;
    if (type == 'in') InventoryStockModals.showStockInDialog(context: context, product: targets.first, controller: controller);
    if (type == 'out') InventoryStockModals.showStockOutDialog(context: context, product: targets.first, controller: controller);
    if (type == 'set') InventoryStockModals.showSetStockDialog(context: context, product: targets.first, controller: controller);
    if (type == 'transfer') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Transfer requested for selected items")));
    }
  }

  Future<void> _showBulkEditDialog(BuildContext context) async {
    final targets = _selectedProducts.isNotEmpty ? _selectedProducts : controller.allProducts;
    double? newPrice;
    double? newCost;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text("Bulk Edit (${targets.length} items)", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Set Retail Selling Price (₹)"),
              keyboardType: TextInputType.number,
              onChanged: (v) => newPrice = double.tryParse(v),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: "Set Cost Price (₹)"),
              keyboardType: TextInputType.number,
              onChanged: (v) => newCost = double.tryParse(v),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(dialogCtx, true), child: const Text("Apply & Save")),
        ],
      ),
    );

    if (confirmed == true && (newPrice != null || newCost != null)) {
      for (final p in targets) {
        final updated = p.copyWith(
          basePrice: newPrice ?? p.basePrice,
          baseCost: newCost ?? p.baseCost,
        );
        await controller.saveProduct(updated);
      }
      _selectedProductIds.clear();
      await controller.refreshProducts();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully updated ${targets.length} products in database")),
        );
      }
    }
  }
}
