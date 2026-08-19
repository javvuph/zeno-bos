import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../../domain/models/recipe_ingredient.dart';

class ServiceExecutionSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ServiceExecutionSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "⚙️ Consumables (Internal BOM), Add-ons & Resource Allocation",
        titleColor: colors.accentPrimary,
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildResourceSection(),
          const SizedBox(height: 24),
          _buildConsumablesSection(),
          const SizedBox(height: 24),
          _buildAddonsSection(),
        ]),
      ),
    ]);
  }

  Widget _buildResourceSection() {
    return Row(children: [
      Expanded(child: ZenoTextField(label: "RESOURCE / CABIN / CHAIR ASSIGNMENT", initialValue: controller.product.resourceAssignment, onChanged: (v) => controller.updateField(resourceAssignment: v), hint: "e.g., Massage Cabin 1, Stylist Chair 3")),
      const Spacer(),
    ]);
  }

  Widget _buildConsumablesSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("CONSUMABLES AUTO-DEDUCTION (INTERNAL BOM)", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.grey)),
      const SizedBox(height: 12),
      ...controller.product.recipeBOM.map((i) => _bomItem(i)),
      const SizedBox(height: 12),
      ZenoButton(label: "ADD CONSUMABLE", icon: Icons.add_link_rounded, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => controller.addRecipeIngredient()),
    ]);
  }

  Widget _bomItem(RecipeIngredient item) {
    return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.inventory_2_outlined, size: 14, color: Colors.grey), const SizedBox(width: 12), Expanded(child: Text("${item.quantity}${item.unit} ${item.ingredientName}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))), const Spacer(), IconButton(icon: const Icon(Icons.delete_outline, size: 14, color: Colors.red), onPressed: () => controller.removeRecipeIngredient(item.id))]));
  }

  Widget _buildAddonsSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("SERVICE UPGRADES & ADD-ONS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.grey)),
      const SizedBox(height: 12),
      ...controller.product.modifierGroups.map((g) => _addonItem(g)),
      const SizedBox(height: 12),
      ZenoButton(label: "ADD SERVICE UPGRADE", icon: Icons.playlist_add_check_rounded, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => controller.addModifierGroup("New Upgrade")),
    ]);
  }

  Widget _addonItem(String name) {
    return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.star_outline_rounded, size: 14, color: Colors.grey), const SizedBox(width: 12), Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const Spacer(), IconButton(icon: const Icon(Icons.close, size: 14), onPressed: () => controller.removeModifierGroup(name))]));
  }
}
