import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/templates/zeno_data_grid_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../controllers/product_controller.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../../domain/models/product.dart' as domain;

class ProductListScreen extends StatefulWidget {
  final String? filterStatus;
  final String? title;

  const ProductListScreen({super.key, this.filterStatus, this.title});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final controller = ProductController(sl<IProductRepository>());

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final products = controller.allProducts;

    return ZenoDataGridTemplate<domain.Product>(
      title: "Product Catalogue",
      subtitle: "${products.length} total records across all branches",
      items: products,
      totalCount: products.length,
      isLoading: controller.isLoading,
      searchPlaceholder: "Search by SKU, Name or Category...",
      onSearch: (q) => controller.searchProducts(q),
      onRefresh: () => controller.refreshProducts(),
      onRowTap: (p) => NavigationController()
          .navigateTo('inventory/products/edit', params: {'productId': p.id}),
      primaryAction: ElevatedButton.icon(
        onPressed: () =>
            NavigationController().navigateTo('inventory/products/add'),
        icon: const Icon(Icons.add_rounded, size: 18),
        label: const Text("NEW PRODUCT"),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accentPrimary,
          foregroundColor: colors.bgTier1,
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      bulkActions: [
        _BulkActionButton(
          label: "Delete",
          icon: Icons.delete_outline_rounded,
          color: colors.statusDanger,
          onTap: () {
            // In a real app, show confirmation dialog
            // Here we assume bulk delete logic if needed
          },
        ),
        _BulkActionButton(
            label: "Export", icon: Icons.file_download_outlined, onTap: () {}),
        _BulkActionButton(
            label: "Change Status", icon: Icons.sync_rounded, onTap: () {}),
      ],
      columns: [
        ZenoTableColumn(
          label: "SKU",
          width: 140,
          builder: (p) => Text(p.sku.value,
              style: TextStyle(
                  color: colors.textSecondary, fontFamily: 'monospace')),
        ),
        ZenoTableColumn(
          label: "Product Name",
          builder: (p) => Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: colors.bgTier2,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: colors.borderSubtle),
                ),
                child: Icon(Icons.image_outlined,
                    size: 14, color: colors.textSecondary),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  p.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Category",
          width: 180,
          builder: (p) => Text(p.category?.name ?? 'Uncategorized'),
        ),
        ZenoTableColumn(
          label: "Sale Price",
          width: 120,
          isNumeric: true,
          builder: (p) => Text("\$${p.basePrice.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Status",
          width: 120,
          builder: (p) => _StatusBadge(status: "Active", colors: colors),
        ),
        ZenoTableColumn(
          label: "Actions",
          width: 80,
          builder: (p) => Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined,
                    size: 16, color: colors.textSecondary),
                onPressed: () => NavigationController().navigateTo(
                    'inventory/products/edit',
                    params: {'productId': p.id}),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline_rounded,
                    size: 16, color: colors.statusDanger),
                onPressed: () => _confirmDelete(p),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(domain.Product p) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Product"),
        content: Text("Are you sure you want to delete '${p.name}'?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL")),
          TextButton(
            onPressed: () async {
              await controller.deleteProduct(p.id);
              if (mounted) Navigator.pop(context);
            },
            child: const Text("DELETE", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final ZenoSemanticColors colors;
  const _StatusBadge({required this.status, required this.colors});

  @override
  Widget build(BuildContext context) {
    Color color = colors.statusSuccess;
    if (status == "Low Stock") color = colors.statusWarning;
    if (status == "Out of Stock") color = colors.statusDanger;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(status.toUpperCase(),
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}

class _BulkActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const _BulkActionButton(
      {required this.label,
      required this.icon,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: color ?? colors.textPrimary),
      label: Text(label,
          style: TextStyle(
              fontSize: 12,
              color: color ?? colors.textPrimary,
              fontWeight: FontWeight.w600)),
    );
  }
}
