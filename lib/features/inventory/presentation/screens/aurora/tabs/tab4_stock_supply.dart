import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab4StockSupply extends StatelessWidget {
  final ProductStudioController controller;
  const Tab4StockSupply({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Stock Control & Location
              Expanded(
                child: Column(
                  children: [
                    ZenoCard(
                      title: "Stock Control",
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: ZenoTextField(label: "Opening", initialValue: p.openingStock == 0 ? "" : p.openingStock.toString(), onChanged: (v) => controller.updateField(openingStock: double.tryParse(v) ?? 0.0), keyboardType: TextInputType.number)),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Reorder", initialValue: p.reorderLevel.toString(), onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v)), keyboardType: TextInputType.number)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(child: ZenoTextField(label: "Min", initialValue: p.minStock.toString(), onChanged: (v) => controller.updateField(minStock: int.tryParse(v)), keyboardType: TextInputType.number)),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Safety", initialValue: p.safetyStock.toString(), onChanged: (v) => controller.updateField(safetyStock: int.tryParse(v)), keyboardType: TextInputType.number)),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Max", initialValue: p.maxStock.toString(), onChanged: (v) => controller.updateField(maxStock: int.tryParse(v)), keyboardType: TextInputType.number)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ZenoCard(
                      title: "Storage Location",
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Column(
                        children: [
                          ZenoDropdown<String>(label: "Primary Location", value: p.warehouseLocation.isEmpty ? null : p.warehouseLocation, items: controller.locationsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(warehouseLocation: v), width: ZenoFieldWidth.full, onQuickAdd: () => _showQuickAddDialog(context, "Location / Warehouse", (val) => controller.addWarehouse(val))),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(child: ZenoTextField(label: "Rack", initialValue: p.planogramRack, onChanged: (v) => controller.updateField(planogramRack: v))),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Shelf", initialValue: p.planogramShelf, onChanged: (v) => controller.updateField(planogramShelf: v))),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Bin", initialValue: p.planogramBin, onChanged: (v) => controller.updateField(planogramBin: v))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right Column: Supplier & Purchasing
              Expanded(
                child: Column(
                  children: [
                    ZenoCard(
                      title: "Supplier Information",
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: ZenoDropdown<String>(label: "Primary Supplier", value: p.supplier.isEmpty ? null : p.supplier, items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(supplier: v), onQuickAdd: () => _showQuickAddDialog(context, "Supplier", (val) => controller.addSupplier(val)))),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Supplier SKU", initialValue: p.supplierSku, onChanged: (v) => controller.updateField(supplierSku: v))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ZenoDropdown<String>(label: "Secondary Supplier", value: p.secondarySupplier.isEmpty ? null : p.secondarySupplier, items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(secondarySupplier: v), width: ZenoFieldWidth.full, onQuickAdd: () => _showQuickAddDialog(context, "Supplier", (val) => controller.addSupplier(val))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ZenoCard(
                      title: "Purchasing Terms",
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: ZenoDropdown<String>(label: "Pack UOM", value: p.purchaseUnit, items: ["Case", "Pallet", "Pouch"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(purchaseUnit: v), onQuickAdd: () => _showQuickAddDialog(context, "Pack UOM", (val) => controller.addUnit(val)))),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "MOQ", initialValue: p.supplierMOQ.toString(), onChanged: (v) => controller.updateField(supplierMOQ: int.tryParse(v)), keyboardType: TextInputType.number)),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Cost", initialValue: p.supplierPurchaseCost.toString(), onChanged: (v) => controller.updateField(supplierPurchaseCost: double.tryParse(v)), keyboardType: TextInputType.number)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(child: ZenoTextField(label: "Lead Time", initialValue: p.supplierLeadTime.toString(), onChanged: (v) => controller.updateField(supplierLeadTime: int.tryParse(v)), keyboardType: TextInputType.number)),
                              const SizedBox(width: 8),
                              Expanded(flex: 2, child: ZenoTextField(label: "Payment Terms", initialValue: p.supplierPaymentTerms, onChanged: (v) => controller.updateField(supplierPaymentTerms: v), hint: "e.g. Net 30")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showQuickAddDialog(BuildContext context, String type, Function(String) onAdd) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Add Custom $type", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: textController,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            labelText: "$type Name",
            hintText: "Enter $type name",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onAdd(textController.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
