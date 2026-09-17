import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/services/food_cost_calculator.dart';

class FnbPriceTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FnbPriceTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final recipeCost = p.recipeBOM.fold(0.0, (sum, i) => sum + (i.quantity * i.cost));
    final foodCostPct = FoodCostCalculator.calculateFoodCostPercentage(recipeCost, p.sellingPrice);

    return Column(children: [
      ZenoCard(
        title: "💰 MULTI-CHANNEL RESTAURANT PRICING",
        titleColor: Colors.green,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "DINE-IN PRICE (BASE) *", textAlign: TextAlign.center, initialValue: p.sellingPrice.toString(), onChanged: (v) => controller.updatePrice(double.tryParse(v) ?? 0), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "TAKEAWAY PRICE", textAlign: TextAlign.center, initialValue: p.takeawayPrice.toString(), onChanged: (v) => controller.updateField(takeawayPrice: double.tryParse(v)), prefix: const Text("₹"))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "AGGREGATOR PRICE", textAlign: TextAlign.center, initialValue: p.aggregatorPrice.toString(), onChanged: (v) => controller.updateField(aggregatorPrice: double.tryParse(v)), prefix: const Text("₹"))),
          ]),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: ZenoTextField(label: "RECIPE COST (BOM)", initialValue: "₹${recipeCost.toStringAsFixed(2)}", readOnly: true)),
            const SizedBox(width: 12),
            Expanded(child: _costStatusBox(foodCostPct)),
            const SizedBox(width: 12),
            Expanded(child: _toggle("APPLY SERVICE CHARGE", p.isRoomServiceAvailable, (v) => controller.updateField(isRoomServiceAvailable: v))),
          ]),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📦 INVENTORY & KITCHEN STOCK",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "CURRENT STOCK QTY", initialValue: p.openingStock == 0 ? "" : p.openingStock.toString(), onChanged: (v) => controller.updateField(openingStock: double.tryParse(v) ?? 0.0))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "KITCHEN WAREHOUSE", value: p.warehouseLocation, items: ["Main Kitchen", "Bar Store", "Cold Storage"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(warehouseLocation: v))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ZenoTextField(label: "DAILY BATCH QUANTITY", initialValue: p.packageQuantity.toString(), onChanged: (v) => controller.updateField(packageQuantity: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SAFETY THRESHOLD", initialValue: p.safetyStock.toString(), onChanged: (v) => controller.updateField(safetyStock: int.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "MAX DAILY ORDERS", initialValue: p.multiBuyMaxQtyPerBill.toString(), onChanged: (v) => controller.updateField(multiBuyMaxQtyPerBill: int.tryParse(v)))),
          ]),
        ]),
      ),
    ]);
  }

  Widget _costStatusBox(double pct) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text("FOOD COST %", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
    const SizedBox(height: 4),
    Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Row(children: [Text("${pct.toStringAsFixed(1)}%", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: pct > 35 ? Colors.red : Colors.green)), const Spacer(), Icon(pct > 35 ? Icons.warning_amber_rounded : Icons.check_circle_outline_rounded, size: 14, color: pct > 35 ? Colors.red : Colors.green)]))
  ]);

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
