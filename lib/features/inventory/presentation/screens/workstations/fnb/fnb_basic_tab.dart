import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import 'fnb_schemas.dart';
import '../../widgets/product_studio_redesign_widgets.dart';

class FnbBasicTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FnbBasicTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      StudioSectionCard(
        title: "Dish Identity",
        subtitle: "Primary identification and multilingual dish names",
        icon: Icons.restaurant_menu_outlined,
        child: Column(children: [
          Wrap(spacing: 20, runSpacing: 20, children: [
            ZenoTextField(key: const ValueKey('title'), label: "Dish / Item Name", initialValue: p.title, onChanged: (v) => controller.updateField(title: v), width: ZenoFieldWidth.standard, isRequired: true),
            ZenoTextField(key: const ValueKey('arabicTitle'), label: "اسم الوجبة (Arabic Name)", textAlign: TextAlign.right, initialValue: p.arabicTitle, onChanged: (v) => controller.updateField(arabicTitle: v), width: ZenoFieldWidth.standard, isRequired: true),
          ]),
          const SizedBox(height: 20),
          Wrap(spacing: 20, runSpacing: 20, children: [
            ZenoDropdown<String>(key: const ValueKey('fineDiningCourse'), label: "Course Type", value: p.fineDiningCourse, items: fnbCourses.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(fineDiningCourse: v), width: ZenoFieldWidth.medium),
            ZenoTextField(key: const ValueKey('sku'), label: "Master SKU", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v), width: ZenoFieldWidth.medium),
            ZenoTextField(key: const ValueKey('posShortThermalName'), label: "Kitchen Short Name", initialValue: p.posShortThermalName, onChanged: (v) => controller.updateField(posShortThermalName: v), width: ZenoFieldWidth.medium, hint: "Max 22 chars"),
            ZenoTextField(key: const ValueKey('packagingSurcharge'), label: "Packaging Surcharge", initialValue: p.packagingSurcharge.toString(), onChanged: (v) => controller.updateField(packagingSurcharge: double.tryParse(v)), width: ZenoFieldWidth.short, prefix: const Text("₹")),
          ]),
          const SizedBox(height: 20),
          ZenoTextField(key: const ValueKey('description'), label: "Menu Story & Preparation Notes", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 3, width: ZenoFieldWidth.full),
        ]),
      ),
      StudioSectionCard(
        title: "Preparation & Dietary",
        subtitle: "Kitchen-specific flags and nutrition matrix",
        icon: Icons.outdoor_grill_outlined,
        accentColor: colors.statusWarning,
        child: Column(children: [
          Wrap(spacing: 20, runSpacing: 20, children: [
            ZenoDropdown<String>(key: const ValueKey('foodClass'), label: "Dietary Classification", value: p.foodClass, items: dietaryClassifications.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(foodClass: v), width: ZenoFieldWidth.medium),
            ZenoDropdown<String>(key: const ValueKey('spiceLevel'), label: "Spice Level", value: p.spiceLevel, items: fnbSpiceLevels.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(spiceLevel: v), width: ZenoFieldWidth.medium),
            ZenoTextField(key: const ValueKey('prepTime'), label: "Prep Time (Mins)", initialValue: p.prepTime.toString(), onChanged: (v) => controller.updateField(prepTime: int.tryParse(v)), width: ZenoFieldWidth.micro),
            _toggle("CHEF'S SIGNATURE", p.featuredProduct, (v) => controller.updateField(featuredProduct: v)),
          ]),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 20),
          const Text("ALLERGENS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.5)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: ["Gluten", "Dairy", "Nuts", "Soy", "Shellfish", "Eggs", "Sesame"].map((a) {
            final isSelected = p.allergens.contains(a);
            return FilterChip(label: Text(a, style: const TextStyle(fontSize: 11)), selected: isSelected, onSelected: (s) {
              final list = List<String>.from(p.allergens);
              if (s) list.add(a); else list.remove(a);
              controller.updateField(allergens: list);
            }, selectedColor: colors.accentPrimary.withValues(alpha: 0.2), checkmarkColor: colors.accentPrimary);
          }).toList()),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.5)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
