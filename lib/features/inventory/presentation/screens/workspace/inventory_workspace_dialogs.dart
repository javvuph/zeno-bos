import 'package:flutter/material.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';

class InventoryWorkspaceDialogs {
  static void openAddProductDialog({
    required BuildContext context,
    required ValueChanged<ProductMaster> onProductAdded,
  }) {
    final nameCtrl = TextEditingController();
    final skuCtrl = TextEditingController();
    final retailCtrl = TextEditingController();
    final costCtrl = TextEditingController();
    final stockCtrl = TextEditingController(text: "10");
    final reorderCtrl = TextEditingController(text: "5");
    final locationCtrl = TextEditingController(text: "MAIN HQ");
    bool isStandalone = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: const Text("Add New Product Style",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: "Product / Style Name *",
                    hintText: "e.g. PREMIUM COTTON T-SHIRT",
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: skuCtrl,
                        decoration: const InputDecoration(
                          labelText: "Style Code / SKU *",
                          hintText: "e.g. TS-2026-001",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<bool>(
                        initialValue: isStandalone,
                        decoration: const InputDecoration(labelText: "Product Type"),
                        items: const [
                          DropdownMenuItem(value: true, child: Text("Standalone Product")),
                          DropdownMenuItem(value: false, child: Text("Has Color/Size Variants")),
                        ],
                        onChanged: (val) {
                          if (val != null) setModalState(() => isStandalone = val);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: retailCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Retail Price (₹) *"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: costCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Cost Price (₹) *"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (isStandalone) ...[
                      Expanded(
                        child: TextField(
                          controller: stockCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: "Initial Stock (Units) *"),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: TextField(
                        controller: reorderCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Reorder Threshold *"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: locationCtrl,
                  decoration: const InputDecoration(labelText: "Warehouse Location"),
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
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final name = nameCtrl.text.trim();
                final sku = skuCtrl.text.trim();
                if (name.isEmpty || sku.isEmpty) return;

                final newId = "PRD-${DateTime.now().millisecondsSinceEpoch}";
                final retail = double.tryParse(retailCtrl.text) ?? 0.0;
                final cost = double.tryParse(costCtrl.text) ?? 0.0;
                final stock = double.tryParse(stockCtrl.text) ?? 0.0;
                final reorder = double.tryParse(reorderCtrl.text) ?? 0.0;

                final newProduct = ProductMaster(
                  id: newId,
                  name: name.toUpperCase(),
                  sku: sku,
                  retail: retail,
                  cost: cost,
                  stock: isStandalone ? stock : 0.0,
                  reorderLevel: reorder,
                  category: "Apparel",
                  brand: "ZENO",
                  location: locationCtrl.text.trim().isEmpty
                      ? "MAIN HQ"
                      : locationCtrl.text.trim(),
                  addedDate: DateTime.now(), // 🟢 Green Latest (< 1 Mo)
                  isStandalone: isStandalone,
                  variants: isStandalone
                      ? const []
                      : [
                          ProductVariant(
                            id: "$newId-VAR1",
                            sku: "$sku-BLK-M",
                            barcode: "890${newId.substring(newId.length - 6)}01",
                            color: "Black",
                            size: "M",
                            qty: 5.0,
                          ),
                          ProductVariant(
                            id: "$newId-VAR2",
                            sku: "$sku-WHT-L",
                            barcode: "890${newId.substring(newId.length - 6)}02",
                            color: "White",
                            size: "L",
                            qty: 5.0,
                          ),
                        ],
                );

                onProductAdded(newProduct);
                Navigator.pop(ctx);
              },
              child: const Text("Save Product"),
            ),
          ],
        ),
      ),
    );
  }

  static void openEditProductDialog({
    required BuildContext context,
    required ProductMaster product,
    required ValueChanged<ProductMaster> onProductUpdated,
  }) {
    final nameCtrl = TextEditingController(text: product.name);
    final skuCtrl = TextEditingController(text: product.sku);
    final retailCtrl = TextEditingController(text: product.retail.toStringAsFixed(0));
    final costCtrl = TextEditingController(text: product.cost.toStringAsFixed(0));
    final stockCtrl = TextEditingController(text: product.stock.toStringAsFixed(0));
    final reorderCtrl = TextEditingController(text: product.reorderLevel.toStringAsFixed(0));
    final locationCtrl = TextEditingController(text: product.location);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text("Edit Product Style",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        content: SizedBox(
          width: 440,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Product / Style Name *"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: skuCtrl,
                decoration: const InputDecoration(labelText: "Style Code / SKU *"),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: retailCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Retail Price (₹) *"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: costCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Cost Price (₹) *"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (product.isStandalone) ...[
                    Expanded(
                      child: TextField(
                        controller: stockCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Stock Level *"),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: TextField(
                      controller: reorderCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Reorder Threshold *"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationCtrl,
                decoration: const InputDecoration(labelText: "Warehouse Location"),
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
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final name = nameCtrl.text.trim();
              final sku = skuCtrl.text.trim();
              if (name.isEmpty || sku.isEmpty) return;

              final retail = double.tryParse(retailCtrl.text) ?? product.retail;
              final cost = double.tryParse(costCtrl.text) ?? product.cost;
              final stock = double.tryParse(stockCtrl.text) ?? product.stock;
              final reorder = double.tryParse(reorderCtrl.text) ?? product.reorderLevel;

              final updated = product.copyWith(
                name: name.toUpperCase(),
                sku: sku,
                retail: retail,
                cost: cost,
                stock: stock,
                reorderLevel: reorder,
                location: locationCtrl.text.trim(),
              );

              onProductUpdated(updated);
              Navigator.pop(ctx);
            },
            child: const Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  static void openAdjustStockDialog({
    required BuildContext context,
    required ProductMaster product,
    required ValueChanged<double> onStockAdjusted,
  }) {
    final currentStock = product.totalStock;
    final stockCtrl = TextEditingController(text: currentStock.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text("Adjust Stock — ${product.name}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Total Stock: ${currentStock.toStringAsFixed(0)} PCS",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
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
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final newStock = double.tryParse(stockCtrl.text) ?? currentStock;
              onStockAdjusted(newStock);
              Navigator.pop(ctx);
            },
            child: const Text("Update Stock"),
          ),
        ],
      ),
    );
  }
}
