import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab6Vendors extends StatelessWidget {
  final ProductStudioController controller;
  const Tab6Vendors({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Primary Supplier Info",
                  child: Column(
                    children: [
                      ZenoDropdown<String>(
                        label: "Primary Supplier Select",
                        value: p.supplier.isEmpty ? null : p.supplier,
                        items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(supplier: v),
                        width: ZenoFieldWidth.full,
                        onQuickAdd: () => controller.addSupplier("New Supplier"),
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('supplierProductCode'),
                        label: "Vendor Product Code (SKU)",
                        initialValue: p.supplierProductCode,
                        onChanged: (v) => controller.updateField(supplierProductCode: v),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Contractual Terms",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('vendorContractCost'),
                        label: "Vendor Contract Cost",
                        initialValue: p.vendorContractCost.toString(),
                        onChanged: (v) => controller.updateField(vendorContractCost: double.tryParse(v)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('supplierMoq'),
                              label: "Minimum Order Qty (MOQ)",
                              initialValue: p.supplierMoq.toString(),
                              onChanged: (v) => controller.updateField(supplierMoq: double.tryParse(v)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('supplierLeadTime'),
                              label: "Lead Time (Days)",
                              initialValue: p.supplierLeadTime.toString(),
                              onChanged: (v) => controller.updateField(supplierLeadTime: int.tryParse(v)),
                              keyboardType: TextInputType.number,
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
        ],
      ),
    );
  }
}
