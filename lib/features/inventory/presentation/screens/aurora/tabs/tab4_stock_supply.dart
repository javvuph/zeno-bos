import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab4StockSupply extends StatelessWidget {
  final ProductStudioController controller;
  const Tab4StockSupply({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ZenoTextField(
                                  label: "Opening Stock",
                                  initialValue: p.openingStock.toString(),
                                  onChanged: (v) => controller.updateField(openingStock: int.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Reorder Level",
                                  initialValue: p.reorderLevel.toString(),
                                  onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ZenoTextField(
                                  label: "Minimum Stock",
                                  initialValue: p.minStock.toString(),
                                  onChanged: (v) => controller.updateField(minStock: int.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Safety Stock",
                                  initialValue: p.safetyStock.toString(),
                                  onChanged: (v) => controller.updateField(safetyStock: int.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Maximum Stock",
                                  initialValue: p.maxStock.toString(),
                                  onChanged: (v) => controller.updateField(maxStock: int.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ZenoCard(
                      title: "Storage Location",
                      child: Column(
                        children: [
                          ZenoDropdown<String>(
                            label: "Storage Location",
                            value: p.warehouseLocation.isEmpty ? null : p.warehouseLocation,
                            items: controller.locationsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => controller.updateField(warehouseLocation: v),
                            width: ZenoFieldWidth.full,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ZenoTextField(
                                  label: "Rack",
                                  initialValue: p.planogramRack,
                                  onChanged: (v) => controller.updateField(planogramRack: v),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Shelf",
                                  initialValue: p.planogramShelf,
                                  onChanged: (v) => controller.updateField(planogramShelf: v),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Bin",
                                  initialValue: p.planogramBin,
                                  onChanged: (v) => controller.updateField(planogramBin: v),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Right Column: Supplier & Purchasing
              Expanded(
                child: Column(
                  children: [
                    ZenoCard(
                      title: "Supplier Information",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ZenoDropdown<String>(
                                  label: "Primary Supplier",
                                  value: p.supplier.isEmpty ? null : p.supplier,
                                  items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  onChanged: (v) => controller.updateField(supplier: v),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Supplier SKU",
                                  initialValue: p.supplierSku,
                                  onChanged: (v) => controller.updateField(supplierSku: v),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ZenoDropdown<String>(
                            label: "Secondary Supplier",
                            value: p.secondarySupplier.isEmpty ? null : p.secondarySupplier,
                            items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => controller.updateField(secondarySupplier: v),
                            width: ZenoFieldWidth.full,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ZenoCard(
                      title: "Purchasing Terms",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ZenoDropdown<String>(
                                  label: "Purchase Pack UOM",
                                  value: p.purchaseUnit,
                                  items: ["Case", "Pallet", "Pouch", "Box"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  onChanged: (v) => controller.updateField(purchaseUnit: v),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Supplier MOQ",
                                  initialValue: p.supplierMOQ.toString(),
                                  onChanged: (v) => controller.updateField(supplierMOQ: int.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ZenoTextField(
                                  label: "Supplier Cost",
                                  initialValue: p.supplierPurchaseCost.toString(),
                                  onChanged: (v) => controller.updateField(supplierPurchaseCost: double.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ZenoTextField(
                                  label: "Lead Time (Days)",
                                  initialValue: p.supplierLeadTime.toString(),
                                  onChanged: (v) => controller.updateField(supplierLeadTime: int.tryParse(v)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ZenoTextField(
                            label: "Payment Terms",
                            initialValue: p.supplierPaymentTerms,
                            onChanged: (v) => controller.updateField(supplierPaymentTerms: v),
                            width: ZenoFieldWidth.full,
                            hint: "e.g. Net 30",
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
}
