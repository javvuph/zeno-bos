import 'package:flutter/material.dart';
import '../../domain/models/product.dart';
import '../../domain/models/product_variant.dart';
import '../controllers/product_controller.dart';

class InventoryStockModals {
  static Future<void> showStockInDialog({
    required BuildContext context,
    required Product product,
    ProductVariant? variant,
    required ProductController controller,
  }) async {
    double qty = 1.0;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Stock In — ${product.name} ${variant != null ? '(${variant.sku.value})' : ''}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter quantity to add to stock:", style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            const SizedBox(height: 8),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: "Add Quantity (PCS)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: "1"),
              onChanged: (v) => qty = double.tryParse(v) ?? 1.0,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF047857)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Stock In", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && qty > 0) {
      if (variant != null) {
        final updatedVariants = product.variants.map((v) {
          if (v.id == variant.id) {
            return v.copyWith(stockLevel: v.stockLevel + qty);
          }
          return v;
        }).toList();
        final updated = product.copyWith(
          variants: updatedVariants,
          openingStock: updatedVariants.fold<double>(0, (double s, ProductVariant v) => s + v.stockLevel),
        );
        await controller.saveProduct(updated);
      } else {
        final updated = product.copyWith(openingStock: product.openingStock + qty);
        await controller.saveProduct(updated);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Added ${qty.round()} PCS to ${product.name}")),
        );
      }
    }
  }

  static Future<void> showStockOutDialog({
    required BuildContext context,
    required Product product,
    ProductVariant? variant,
    required ProductController controller,
  }) async {
    double qty = 1.0;
    final currentStock = variant != null
        ? variant.stockLevel
        : (product.variants.isNotEmpty ? product.variants.fold<double>(0, (double s, ProductVariant v) => s + v.stockLevel) : product.openingStock);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Stock Out — ${product.name} ${variant != null ? '(${variant.sku.value})' : ''}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Stock: ${currentStock.round()} PCS", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
            const SizedBox(height: 8),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: "Reduce Quantity (PCS)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: "1"),
              onChanged: (v) => qty = double.tryParse(v) ?? 1.0,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB91C1C)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Stock Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && qty > 0) {
      if (qty > currentStock) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error: Cannot reduce stock below 0")),
          );
        }
        return;
      }

      if (variant != null) {
        final updatedVariants = product.variants.map((v) {
          if (v.id == variant.id) {
            return v.copyWith(stockLevel: (v.stockLevel - qty).clamp(0, 999999));
          }
          return v;
        }).toList();
        final updated = product.copyWith(
          variants: updatedVariants,
          openingStock: updatedVariants.fold<double>(0, (double s, ProductVariant v) => s + v.stockLevel),
        );
        await controller.saveProduct(updated);
      } else {
        final updated = product.copyWith(openingStock: (product.openingStock - qty).clamp(0, 999999));
        await controller.saveProduct(updated);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Reduced ${qty.round()} PCS from ${product.name}")),
        );
      }
    }
  }

  static Future<void> showSetStockDialog({
    required BuildContext context,
    required Product product,
    ProductVariant? variant,
    required ProductController controller,
  }) async {
    final currentStock = variant != null
        ? variant.stockLevel
        : (product.variants.isNotEmpty ? product.variants.fold<double>(0, (double s, ProductVariant v) => s + v.stockLevel) : product.openingStock);

    double newQty = currentStock;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Set Exact Stock — ${product.name}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current System Stock: ${currentStock.round()} PCS", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            const SizedBox(height: 10),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: "New Physical Count (PCS)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: "${currentStock.round()}"),
              onChanged: (v) => newQty = double.tryParse(v) ?? currentStock,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3730A3)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Save Stock Count", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && newQty >= 0) {
      if (variant != null) {
        final updatedVariants = product.variants.map((v) {
          if (v.id == variant.id) {
            return v.copyWith(stockLevel: newQty);
          }
          return v;
        }).toList();
        final updated = product.copyWith(
          variants: updatedVariants,
          openingStock: updatedVariants.fold<double>(0, (double s, ProductVariant v) => s + v.stockLevel),
        );
        await controller.saveProduct(updated);
      } else {
        final updated = product.copyWith(openingStock: newQty);
        await controller.saveProduct(updated);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Updated ${product.name} stock count to ${newQty.round()} PCS")),
        );
      }
    }
  }

  static Future<void> showArchiveDialog({
    required BuildContext context,
    required List<Product> products,
    required ProductController controller,
  }) async {
    if (products.isEmpty) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Archive ${products.length} Products", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to archive ${products.length} items? Archived products are preserved for historical audit trails."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB91C1C)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Archive Items", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      for (final p in products) {
        await controller.deleteProduct(p.id);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Archived ${products.length} products successfully")),
        );
      }
    }
  }
}
