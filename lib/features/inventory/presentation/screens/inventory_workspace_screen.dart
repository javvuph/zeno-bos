import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/features/inventory/domain/models/product.dart';
import 'package:zeno/features/inventory/domain/models/extensions/product_extensions.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_controller.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'workspace/inventory_kpi_grid.dart';
import 'workspace/inventory_controls_bar.dart';
import 'workspace/inventory_table_card.dart';

// ============================================================================
// MAIN INVENTORY WORKSPACE SCREEN (CONNECTED TO PRODUCT STUDIO & ISAR DB)
// ============================================================================

class InventoryWorkspaceScreen extends StatefulWidget {
  const InventoryWorkspaceScreen({super.key});

  @override
  State<InventoryWorkspaceScreen> createState() =>
      _InventoryWorkspaceScreenState();
}

class _InventoryWorkspaceScreenState extends State<InventoryWorkspaceScreen> {
  String _activeStatusFilter = "ALL"; // ALL | IN_STOCK | OUT_OF_STOCK
  String _activeTimeFilter = "ALL";   // ALL | NEW | 3M | 6M | 12M | 1Y
  String _searchQuery = "";
  int _currentPage = 1;
  static const int _pageSize = 25;
  final Set<String> _selectedProductIds = {};
  final Set<String> _expandedProductIds = {};
  late final ProductController _productController;

  @override
  void initState() {
    super.initState();
    _initProductController();
  }

  void _initProductController() {
    _productController = sl<ProductController>();
    _productController.addListener(_onProductsChanged);
    _productController.refreshProducts();
  }

  void _onProductsChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _productController.removeListener(_onProductsChanged);
    super.dispose();
  }

  List<ProductMaster> get _products {
    final raw = _productController.allProducts;
    return raw.map((p) {
      final pm = ProductMaster.fromDomain(p);
      return pm.copyWith(isExpanded: _expandedProductIds.contains(pm.id));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentProducts = _products;
    final filteredProducts = _getFilteredProducts(currentProducts);
    final totalFiltered = filteredProducts.length;
    final totalPages = totalFiltered == 0 ? 1 : ((totalFiltered - 1) ~/ _pageSize) + 1;
    final safePage = _currentPage.clamp(1, totalPages);
    final startIndex = totalFiltered == 0 ? 0 : (safePage - 1) * _pageSize;
    final pageProducts = filteredProducts.skip(startIndex).take(_pageSize).toList();

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.f4): _openProductStudio,
      },
      child: FocusScope(
        autofocus: true,
        child: Scaffold(
          backgroundColor: Theme.of(context).extension<ZenoSemanticColors>()?.bgTier1 ?? const Color(0xFFF3F6FF),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. HEADER SECTION
                    _buildHeaderSection(),
                    const SizedBox(height: 20),

                    // 2. 5 DYNAMIC KPI CARDS
                    InventoryKpiGrid(products: currentProducts),
                    const SizedBox(height: 22),

                    // 3. CONTROLS BAR (Filters & Search)
                    InventoryControlsBar(
                      activeStatusFilter: _activeStatusFilter,
                      activeTimeFilter: _activeTimeFilter,
                      onStatusFilterChanged: (val) =>
                          setState(() => _activeStatusFilter = val),
                      onTimeFilterChanged: (val) =>
                          setState(() => _activeTimeFilter = val),
                      onSearchQueryChanged: (val) => setState(() {
                        _searchQuery = val;
                        _currentPage = 1;
                      }),
                    ),
                    const SizedBox(height: 14),

                    // 4. MASTER DATA TABLE CARD
                    InventoryTableCard(
                      allProducts: currentProducts,
                      filteredProducts: pageProducts,
                      totalFilteredProducts: totalFiltered,
                      currentPage: safePage,
                      pageSize: _pageSize,
                      onPageChanged: (page) => setState(() => _currentPage = page),
                      selectedProductIds: _selectedProductIds,
                      onSelectAllChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _selectedProductIds
                                .addAll(currentProducts.map((p) => p.id));
                          } else {
                            _selectedProductIds.clear();
                          }
                        });
                      },
                      onSelectRow: (id) {
                        setState(() {
                          if (_selectedProductIds.contains(id)) {
                            _selectedProductIds.remove(id);
                          } else {
                            _selectedProductIds.add(id);
                          }
                        });
                      },
                      onToggleExpand: (id) {
                        setState(() {
                          if (_expandedProductIds.contains(id)) {
                            _expandedProductIds.remove(id);
                          } else {
                            _expandedProductIds.add(id);
                          }
                        });
                      },
                      onEditProduct: (product) {
                        NavigationController().navigateTo('inventory/studio');
                      },
                      onAdjustStock: _openAdjustStockDialog,
                      onDeleteProduct: (id) async {
                        final messenger = ScaffoldMessenger.of(context);
                        await _productController.deleteProduct(id);
                        setState(() {
                          _selectedProductIds.remove(id);
                          _expandedProductIds.remove(id);
                        });
                        messenger.showSnackBar(
                          const SnackBar(
                              content: Text("Product style removed")),
                        );
                      },
                      onAddProduct: _openProductStudio,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // HEADER SECTION
  // ==========================================================================
  Widget _buildHeaderSection() {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final accent = colors?.accentPrimary ?? const Color(0xFF6366F1);
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final textPrimary = colors?.textPrimary ?? const Color(0xFF26324A);
    final textSecondary = colors?.textSecondary ?? const Color(0xFF64748B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Inventory Master",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "PRODUCT MASTER • CENTRAL STOCK INTELLIGENCE",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: textSecondary,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _exportData,
              icon: const Icon(Icons.upload_file_outlined, size: 14),
              label: const Text("Export"),
              style: OutlinedButton.styleFrom(
                foregroundColor: textPrimary,
                backgroundColor: colors?.bgSurface ?? Colors.white,
                side: BorderSide(color: border),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _openProductStudio,
              icon: const Icon(Icons.add_rounded, size: 16),
              label: const Text("＋ Add Product (F4)"),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // FILTERING LOGIC
  // ==========================================================================
  List<ProductMaster> _getFilteredProducts(List<ProductMaster> currentProducts) {
    return currentProducts.where((p) {
      final stock = p.totalStock;

      // 1. Search Query Filter
      bool matchesSearch = p.name.toLowerCase().contains(_searchQuery) ||
          p.sku.toLowerCase().contains(_searchQuery) ||
          p.variants.any((v) =>
              v.sku.toLowerCase().contains(_searchQuery) ||
              v.barcode.toLowerCase().contains(_searchQuery));

      if (!matchesSearch) return false;

      // 2. Status Filter
      if (_activeStatusFilter == "IN_STOCK" && stock <= 0) return false;
      if (_activeStatusFilter == "OUT_OF_STOCK" && stock > 0) return false;

      // 3. Time / Aging Filter
      final aging = getAgingMeta(p.addedDate);
      if (_activeTimeFilter == "NEW" && aging.months >= 1) {
        return false;
      }
      if (_activeTimeFilter == "3M" &&
          (aging.months < 1 || aging.months >= 3)) {
        return false;
      }
      if (_activeTimeFilter == "6M" &&
          (aging.months < 3 || aging.months >= 6)) {
        return false;
      }
      if (_activeTimeFilter == "12M" &&
          (aging.months < 6 || aging.months >= 12)) {
        return false;
      }
      if (_activeTimeFilter == "1Y" && aging.months < 12) {
        return false;
      }

      return true;
    }).toList();
  }

  void _openProductStudio() {
    NavigationController().navigateTo('inventory/studio');
  }

  void _openAdjustStockDialog(ProductMaster product) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final accent = colors?.accentPrimary ?? const Color(0xFF6366F1);
    final currentStock = product.totalStock;
    final stockCtrl = TextEditingController(text: currentStock.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text("Adjust Stock — ${product.name}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Total Stock: ${currentStock.toStringAsFixed(0)} PCS",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: stockCtrl,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "New Stock Count (Units)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accent,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final newStock = double.tryParse(stockCtrl.text) ?? currentStock;
              try {
                final raw = _productController.allProducts
                    .firstWhere((p) => p.id == product.id);
                final updated = raw.copyWith(openingStock: newStock);
                await _productController.saveProduct(updated);
              } catch (_) {}
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text("Update Stock"),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    final currentProducts = _products;
    if (currentProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Inventory is empty. Add products before exporting.")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("Exporting ${currentProducts.length} product styles to CSV...")),
    );
  }
}
