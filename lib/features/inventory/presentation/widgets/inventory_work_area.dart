import 'package:flutter/material.dart';
import 'package:zeno/features/inventory/presentation/widgets/product_form.dart';
import 'package:zeno/features/inventory/presentation/widgets/product_studio_variants_table.dart';
import 'package:zeno/app/theme.dart';

class InventoryWorkArea extends StatelessWidget {
  const InventoryWorkArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Dynamic Form
        ProductForm(),

        // Product List / Variants Table
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product Catalog",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("All products are stored in a single unified database.",
                    style: TextStyle(color: ZenoTheme.textSecondary)),
                Divider(height: 48),
                
                // Show the new Product Studio Variants Table
                Text("Variant Configuration",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 16),
                ProductStudioVariantsTable(),
                
                SizedBox(height: 48),
                Center(
                  child: Opacity(
                    opacity: 0.3,
                    child: Column(
                      children: [
                        Icon(Icons.inventory_2, size: 80),
                        SizedBox(height: 16),
                        Text("No other products added yet."),
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
