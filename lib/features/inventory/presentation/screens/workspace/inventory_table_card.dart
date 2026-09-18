import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';
import 'inventory_product_row.dart';

class InventoryTableCard extends StatelessWidget {
  final List<ProductMaster> allProducts;
  final List<ProductMaster> filteredProducts;
  final int totalFilteredProducts;
  final int currentPage;
  final int pageSize;
  final ValueChanged<int> onPageChanged;
  final Set<String> selectedProductIds;
  final ValueChanged<bool?> onSelectAllChanged;
  final ValueChanged<String> onSelectRow;
  final ValueChanged<String> onToggleExpand;
  final ValueChanged<ProductMaster> onEditProduct;
  final ValueChanged<ProductMaster> onAdjustStock;
  final ValueChanged<String> onDeleteProduct;
  final VoidCallback onAddProduct;

  const InventoryTableCard({
    super.key,
    required this.allProducts,
    required this.filteredProducts,
    required this.totalFilteredProducts,
    required this.currentPage,
    required this.pageSize,
    required this.onPageChanged,
    required this.selectedProductIds,
    required this.onSelectAllChanged,
    required this.onSelectRow,
    required this.onToggleExpand,
    required this.onEditProduct,
    required this.onAdjustStock,
    required this.onDeleteProduct,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final surface = colors?.bgSurface ?? Colors.white;
    final tier2 = colors?.bgTier2 ?? const Color(0xFFF3F6FF);

    return Container(
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.04),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // TABLE HEADER
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: tier2.withValues(alpha: 0.72),
              border: Border(bottom: BorderSide(color: border)),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                  width: 24,
                  child: Checkbox(
                    value: allProducts.isNotEmpty &&
                        selectedProductIds.length == allProducts.length,
                    onChanged: onSelectAllChanged,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  flex: 4,
                  child: Text(
                    "PRODUCT / STYLE",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 120,
                  child: Text(
                    "RETAIL",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 110,
                  child: Text(
                    "STOCK",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 110, child: Text("STATUS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.5))),
                const SizedBox(
                  width: 130,
                  child: Text(
                    "LOCATION",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 160,
                  child: Text(
                    "VARIANTS",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 60,
                  child: Text(
                    "ACTIONS",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),

          // TABLE BODY OR EMPTY STATE
          filteredProducts.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: filteredProducts.map((product) {
                    return InventoryProductRow(
                      product: product,
                      isSelected: selectedProductIds.contains(product.id),
                      onSelectChanged: (_) => onSelectRow(product.id),
                      onToggleExpand: () => onToggleExpand(product.id),
                      onEdit: () => onEditProduct(product),
                      onAdjustStock: () => onAdjustStock(product),
                      onDelete: () => onDeleteProduct(product.id),
                    );
                  }).toList(),
                ),

          // PAGINATION FOOTER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: colors?.bgSurface ?? Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Showing " + (totalFilteredProducts == 0 ? "0" : (((currentPage - 1) * pageSize) + 1).toString()) + "–" + (((currentPage - 1) * pageSize + filteredProducts.length).toString()) + " of " + totalFilteredProducts.toString(),
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      child: const Text("‹ Prev", style: TextStyle(fontSize: 12, color: Color(0xFF0F172A))),
                    ),
                    const SizedBox(width: 4),
                    OutlinedButton(
                      onPressed: filteredProducts.length == pageSize ? () => onPageChanged(currentPage + 1) : null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      child: const Text("Next ›", style: TextStyle(fontSize: 12, color: Color(0xFF0F172A))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 42,
            color: Color(0xFF94A3B8),
          ),
          const SizedBox(height: 12),
          const Text(
            "No Products in Inventory Yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Start building your stock catalog by adding your first product style or variant.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onAddProduct,
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text("＋ Add Your First Product (F4)"),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors?.accentPrimary ?? const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
