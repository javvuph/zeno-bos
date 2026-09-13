import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../../../controllers/product_studio_controller.dart';
import '../fnb_schemas.dart';

class KitchenRecipeSpecsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const KitchenRecipeSpecsTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🍳 KOT & KDS ORCHESTRATION",
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: ZenoDropdown<String>(label: "KOT STATION", value: p.kotStation.isEmpty ? null : p.kotStation, items: fnbKotStations.map((s)=>DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => controller.updateField(kotStation: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "KDS CATEGORY", value: p.kdsCategory.isEmpty ? null : p.kdsCategory, items: kdsCategories.map((c)=>DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => controller.updateField(kdsCategory: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "KDS FIRE DELAY (SEC)", initialValue: p.courseFireDelay.toString(), onChanged: (v) => controller.updateField(courseFireDelay: int.tryParse(v)))),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "📜 RECIPE & COSTING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "RECIPE VERSION", initialValue: p.recipeVersion, onChanged: (v) => controller.updateField(recipeVersion: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "TARGET FOOD COST %", initialValue: p.targetFoodCostPct.toString(), onChanged: (v) => controller.updateField(targetFoodCostPct: double.tryParse(v)))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "PORTION COST", initialValue: "42.50", readOnly: true, prefix: const Text("₹"))),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "PREP NOTES", initialValue: p.recipePrepNotes, onChanged: (v) => controller.updateField(recipePrepNotes: v), maxLines: 3),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "🥗 RAW INGREDIENTS (RECIPE BOM)",
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _bomHeader(),
          ...p.recipeBOM.map((i) => _bomRow(i.ingredientName, i.quantity.toString(), i.unit, "10.00", "10.00")),
          const SizedBox(height: 12),
          ZenoButton(label: "ADD RAW INGREDIENT", icon: Icons.add_circle_outline_rounded, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => controller.addRecipeIngredient()),
        ]),
      ),
    ]);
  }

  Widget _bomHeader() => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(4)), child: const Row(children: [Expanded(flex: 3, child: Text("INGREDIENT", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 1, child: Text("QTY", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 1, child: Text("UNIT", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 1, child: Text("COST", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))), Expanded(flex: 1, child: Text("TOTAL", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900)))]));
  Widget _bomRow(String name, String qty, String unit, String cost, String total) => Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), child: Row(children: [Expanded(flex: 3, child: Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))), Expanded(flex: 1, child: Text(qty, style: const TextStyle(fontSize: 10))), Expanded(flex: 1, child: Text(unit, style: const TextStyle(fontSize: 10))), Expanded(flex: 1, child: Text(cost, style: const TextStyle(fontSize: 10))), Expanded(flex: 1, child: Text(total, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)))]));
}
