import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_redesign_widgets.dart';

class SuppliersSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const SuppliersSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StudioSectionCard(
          title: "Primary Procurement Source",
          subtitle: "Main vendor and landed cost configuration",
          icon: Icons.local_shipping_outlined,
          accentColor: Colors.orange,
          child: Column(
            children: [
              Wrap(
                spacing: 20, runSpacing: 20,
                children: [
                  ZenoDropdown<String>(
                    key: const ValueKey('supplier'),
                    label: "Main Supplier",
                    value: controller.product.supplier.isEmpty ? null : controller.product.supplier,
                    items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => controller.updateField(supplier: v),
                    width: ZenoFieldWidth.standard,
                  ),
                  ZenoTextField(
                    key: const ValueKey('supplierProductCode'),
                    label: "Supplier Product Code",
                    initialValue: controller.product.supplierProductCode,
                    onChanged: (v) => controller.updateField(supplierProductCode: v),
                    width: ZenoFieldWidth.medium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20, runSpacing: 20,
                children: [
                  ZenoTextField(
                    key: const ValueKey('supplierPurchaseCost'),
                    label: "Purchase Cost (Landed)",
                    initialValue: controller.product.supplierPurchaseCost.toString(),
                    onChanged: (v) => controller.updateField(supplierPurchaseCost: double.tryParse(v)),
                    width: ZenoFieldWidth.short,
                  ),
                  ZenoTextField(
                    key: const ValueKey('supplierMOQ'),
                    label: "Min Order Qty (MOQ)",
                    initialValue: controller.product.supplierMOQ.toString(),
                    onChanged: (v) => controller.updateField(supplierMOQ: int.tryParse(v)),
                    width: ZenoFieldWidth.short,
                  ),
                  ZenoTextField(
                    key: const ValueKey('supplierLeadTime'),
                    label: "Lead Time (Days)",
                    initialValue: controller.product.supplierLeadTime.toString(),
                    onChanged: (v) => controller.updateField(supplierLeadTime: int.tryParse(v)),
                    width: ZenoFieldWidth.short,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
