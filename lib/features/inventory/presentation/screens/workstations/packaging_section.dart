import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';

class PackagingSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const PackagingSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoCard(
          title: "Packaging Configuration",
          titleColor: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ZenoTextField(
                      label: "Package Type",
                      hint: "e.g. Carton, Case, Box, Bag",
                      initialValue: controller.product.packageType,
                      onChanged: (v) => controller.updateField(packageType: v),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ZenoTextField(
                      label: "Units per Package",
                      hint: "e.g. 24, 12, 10",
                      textAlign: TextAlign.center,
                      initialValue: controller.product.unitsPerPackage == 1
                          ? ""
                          : controller.product.unitsPerPackage.toString(),
                      onChanged: (v) => controller.updateField(
                          unitsPerPackage: int.tryParse(v)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ZenoTextField(
                      label: "Package Quantity",
                      hint: "Stock in packages",
                      textAlign: TextAlign.center,
                      initialValue: controller.product.packageQuantity == 0
                          ? ""
                          : controller.product.packageQuantity.toString(),
                      onChanged: (v) => controller.updateField(
                          packageQuantity: double.tryParse(v)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Tip: Packaging information helps in bulk inventory management and automated stock calculations.",
                style: TextStyle(fontSize: 9, color: colors.textDisabled),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
