import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_widgets.dart';

class UnitsConversionSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const UnitsConversionSection(
      {super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoCard(
          title: "Units & Mathematical Conversion",
          titleColor: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ZenoQuickAddDropdown<String>(
                      label: "Purchase Unit",
                      value: controller.product.purchaseUnit,
                      items: controller.unitsList
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => controller.updateField(purchaseUnit: v),
                      onQuickAdd: () => showAddDialog(context, colors, "Unit",
                          (n) => controller.addUnit(n)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ZenoQuickAddDropdown<String>(
                      label: "Stock Unit",
                      value: controller.product.stockUnit,
                      items: controller.unitsList
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => controller.updateField(stockUnit: v),
                      onQuickAdd: () => showAddDialog(context, colors, "Unit",
                          (n) => controller.addUnit(n)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ZenoQuickAddDropdown<String>(
                      label: "Sale Unit",
                      value: controller.product.salesUnit,
                      items: controller.unitsList
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => controller.updateField(salesUnit: v),
                      onQuickAdd: () => showAddDialog(context, colors, "Unit",
                          (n) => controller.addUnit(n)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.bgTier3,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.borderSubtle),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calculate_outlined,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(
                      "1 ${controller.product.purchaseUnit} =",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 80,
                      child: ZenoTextField(
                        label: null,
                        hint: "1.0",
                        textAlign: TextAlign.center,
                        initialValue: controller.product.conversionFactor == 1
                            ? ""
                            : controller.product.conversionFactor.toString(),
                        onChanged: (v) => controller.updateField(
                            conversionFactor: double.tryParse(v)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      controller.product.stockUnit,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
