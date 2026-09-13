import 'package:flutter/material.dart';
import 'package:zeno/features/inventory/presentation/widgets/product_form.dart';
import 'package:zeno/app/theme.dart';

class InventoryWorkArea extends StatelessWidget {
  const InventoryWorkArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // The Dynamic Form
        const ProductForm(),

        // Product List (Placeholder)
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product Catalog",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("All products are stored in a single unified database.",
                    style: TextStyle(color: ZenoTheme.textSecondary)),
                Divider(height: 48),
                Center(
                  child: Opacity(
                    opacity: 0.3,
                    child: Column(
                      children: [
                        Icon(Icons.inventory_2, size: 80),
                        SizedBox(height: 16),
                        Text("No products added yet."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
