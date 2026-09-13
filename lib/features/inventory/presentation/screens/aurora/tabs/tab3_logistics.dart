import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab3Logistics extends StatelessWidget {
  final ProductStudioController controller;
  const Tab3Logistics({super.key, required this.controller});

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
                  title: "Packaging & Bundling",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('masterOuterBarcode'),
                        label: "Outer Barcode (GTIN-14)",
                        initialValue: p.masterOuterBarcode,
                        onChanged: (v) => controller.updateField(masterOuterBarcode: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('caseMultiplier'),
                              label: "Inner Pack Qty",
                              initialValue: p.caseMultiplier.toString(),
                              onChanged: (v) => controller.updateField(caseMultiplier: int.tryParse(v)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('palletStacking'),
                              label: "Pallet Multiplier",
                              initialValue: p.palletStacking.toString(),
                              onChanged: (v) => controller.updateField(palletStacking: int.tryParse(v)),
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Physical Attributes",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('grossWeight'),
                              label: "Gross Weight (kg)",
                              initialValue: p.grossWeight.toString(),
                              onChanged: (v) => controller.updateField(grossWeight: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('netWeight'),
                              label: "Net Weight (kg)",
                              initialValue: p.netWeight.toString(),
                              onChanged: (v) => controller.updateField(netWeight: double.tryParse(v)),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('unitDimensions'),
                        label: "Dimensions (L x W x H cm)",
                        initialValue: p.unitDimensions,
                        onChanged: (v) => controller.updateField(unitDimensions: v),
                        width: ZenoFieldWidth.full,
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
