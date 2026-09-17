import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_redesign_widgets.dart';

class InventoryPricePillar extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const InventoryPricePillar({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(
      children: [
        StudioSectionCard(
          title: "Financial Metrics",
          subtitle: "Commercial pricing and profitability mapping",
          icon: Icons.payments_outlined,
          accentColor: Colors.green,
          child: Wrap(
            spacing: 20, runSpacing: 20,
            children: [
              ZenoTextField(
                key: const ValueKey('costPrice'),
                label: "Purchase Cost",
                initialValue: p.costPrice == 0 ? "" : p.costPrice.toString(),
                onChanged: (v) => controller.updateCost(double.tryParse(v) ?? 0),
                width: ZenoFieldWidth.short,
              ),
              ZenoTextField(
                key: const ValueKey('sellingPrice'),
                label: "Selling Price",
                initialValue: p.sellingPrice == 0 ? "" : p.sellingPrice.toString(),
                onChanged: (v) => controller.updatePrice(double.tryParse(v) ?? 0),
                width: ZenoFieldWidth.short,
                isRequired: true,
              ),
              ZenoTextField(
                key: const ValueKey('mrp'),
                label: "MRP",
                initialValue: p.mrp == 0 ? "" : p.mrp.toString(),
                onChanged: (v) => controller.updateField(mrp: double.tryParse(v)),
                width: ZenoFieldWidth.short,
              ),
              ZenoTextField(
                key: const ValueKey('wholesalePrice'),
                label: "Wholesale Price",
                initialValue: p.wholesalePrice == 0 ? "" : p.wholesalePrice.toString(),
                onChanged: (v) => controller.updateField(wholesalePrice: double.tryParse(v)),
                width: ZenoFieldWidth.short,
              ),
            ],
          ),
        ),
        StudioSectionCard(
          title: "Inventory Control",
          subtitle: "Stock tracking and reorder thresholds",
          icon: Icons.warehouse_outlined,
          accentColor: colors.statusInfo,
          child: Column(
            children: [
              Row(children: [
                const Text("Track Physical Inventory", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                const Spacer(),
                Switch(value: p.trackInventory, onChanged: (v) => controller.updateField(trackInventory: v), activeThumbColor: colors.accentPrimary),
              ]),
              if (p.trackInventory) ...[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 20, runSpacing: 20,
                  children: [
                    ZenoTextField(
                      key: const ValueKey('openingStock'),
                      label: "Opening Stock",
                      initialValue: p.openingStock == 0 ? "" : p.openingStock.toString(),
                      onChanged: (v) => controller.updateField(openingStock: double.tryParse(v) ?? 0.0),
                      width: ZenoFieldWidth.micro,
                    ),
                    ZenoTextField(
                      key: const ValueKey('safetyStock'),
                      label: "Safety Stock",
                      initialValue: p.safetyStock == 0 ? "" : p.safetyStock.toString(),
                      onChanged: (v) => controller.updateField(safetyStock: int.tryParse(v)),
                      width: ZenoFieldWidth.micro,
                    ),
                    ZenoTextField(
                      key: const ValueKey('reorderLevel'),
                      label: "Reorder Level",
                      initialValue: p.reorderLevel == 0 ? "" : p.reorderLevel.toString(),
                      onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v)),
                      width: ZenoFieldWidth.micro,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
