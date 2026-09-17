import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../workstations/fnb/specs/kitchen_recipe_specs_tab.dart';

class TabFnbEngine extends StatelessWidget {
  final ProductStudioController controller;
  const TabFnbEngine({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          KitchenRecipeSpecsTab(controller: controller, colors: colors),
          const SizedBox(height: 12),
          _buildAggregatorPanel(colors),
        ],
      ),
    );
  }

  Widget _buildAggregatorPanel(ZenoSemanticColors colors) {
    final p = controller.product;
    return ZenoCard(
      title: "≡ƒîÉ AGGREGATOR MAPPING (SWIGGY / ZOMATO / UBER)",
      child: Row(
        children: [
          Expanded(
            child: ZenoTextField(
              label: "SWIGGY SKU",
              initialValue: p.swiggySku,
              onChanged: (v) => controller.updateField(swiggySku: v),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ZenoTextField(
              label: "ZOMATO SKU",
              initialValue: p.zomatoSku,
              onChanged: (v) => controller.updateField(zomatoSku: v),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ZenoTextField(
              label: "UBER EATS SKU",
              initialValue: p.uberEatsSku,
              onChanged: (v) => controller.updateField(uberEatsSku: v),
            ),
          ),
        ],
      ),
    );
  }
}
