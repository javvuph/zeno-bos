import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/templates/zeno_data_grid_template.dart';

class InventoryCategory {
  final String name;
  final String description;
  final int productCount;
  final bool isActive;

  InventoryCategory({
    required this.name,
    required this.description,
    required this.productCount,
    this.isActive = true,
  });
}

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    final List<InventoryCategory> categories = [
      InventoryCategory(
          name: "Electronics",
          description: "Gadgets, devices and hardware",
          productCount: 1250),
      InventoryCategory(
          name: "Fashion",
          description: "Clothing, shoes and accessories",
          productCount: 3400),
      InventoryCategory(
          name: "Home & Garden",
          description: "Furniture, decor and tools",
          productCount: 890),
      InventoryCategory(
          name: "Beauty",
          description: "Skincare, makeup and hair care",
          productCount: 450),
      InventoryCategory(
          name: "Sports",
          description: "Equipment, apparel and accessories",
          productCount: 670),
    ];

    return ZenoDataGridTemplate<InventoryCategory>(
      title: "Product Categories",
      subtitle: "Organize products into logical groups for better management.",
      items: categories,
      totalCount: 5,
      searchPlaceholder: "Search categories...",
      primaryAction: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded, size: 18),
        label: const Text("NEW CATEGORY"),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accentPrimary,
          foregroundColor: colors.bgTier1,
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      bulkActions: [
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline_rounded, size: 16),
            label: const Text("Delete")),
      ],
      columns: [
        ZenoTableColumn(
          label: "Category Name",
          builder: (c) =>
              Text(c.name, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        ZenoTableColumn(
          label: "Description",
          builder: (c) => Text(c.description,
              style: TextStyle(color: colors.textSecondary)),
        ),
        ZenoTableColumn(
          label: "Products",
          width: 120,
          isNumeric: true,
          builder: (c) => Text(c.productCount.toString()),
        ),
        ZenoTableColumn(
          label: "Status",
          width: 120,
          builder: (c) =>
              _CategoryStatusBadge(isActive: c.isActive, colors: colors),
        ),
        ZenoTableColumn(
          label: "",
          width: 48,
          builder: (c) =>
              Icon(Icons.more_horiz_rounded, color: colors.textSecondary),
        ),
      ],
    );
  }
}

class _CategoryStatusBadge extends StatelessWidget {
  final bool isActive;
  final ZenoSemanticColors colors;
  const _CategoryStatusBadge({required this.isActive, required this.colors});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? colors.statusSuccess : colors.textDisabled;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        isActive ? "ACTIVE" : "INACTIVE",
        style:
            TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: color),
      ),
    );
  }
}
