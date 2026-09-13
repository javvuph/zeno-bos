import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../widgets/product_studio_redesign_widgets.dart';

class FashionBasicTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionBasicTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      StudioSectionCard(
        title: "Product Identity",
        subtitle: "Style naming and master SKU code",
        icon: Icons.checkroom_outlined,
        child: Column(children: [
          Wrap(spacing: 20, runSpacing: 20, children: [
            if (controller.isFieldVisible('title'))
            ZenoTextField(key: const ValueKey('title'), label: "Style Title / Product Name", initialValue: p.title, onChanged: (v) => controller.updateField(title: v), width: ZenoFieldWidth.standard, isRequired: true),
            if (controller.isFieldVisible('sku'))
            ZenoTextField(key: const ValueKey('sku'), label: "Master Style Code (Parent SKU)", initialValue: p.sku, onChanged: (v) => controller.updateField(sku: v), width: ZenoFieldWidth.standard, isRequired: true),
          ]),
          if (controller.isFieldVisible('description')) ...[
            const SizedBox(height: 20),
            ZenoTextField(key: const ValueKey('description'), label: "Merchandising Notes", initialValue: p.description, onChanged: (v) => controller.updateField(description: v), maxLines: 3, width: ZenoFieldWidth.full),
          ],
        ]),
      ),
      StudioSectionCard(
        title: "Brand & Audience",
        subtitle: "Labels, targeting and origin",
        icon: Icons.people_outline_rounded,
        accentColor: colors.accentPurple,
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          if (controller.isFieldVisible('brand'))
          ZenoTextField(key: const ValueKey('brand'), label: "Principal Brand / Label", initialValue: p.brand, onChanged: (v) => controller.updateField(brand: v), width: ZenoFieldWidth.medium, isRequired: true),
          if (controller.isFieldVisible('gender'))
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Target Gender", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
            const SizedBox(height: 8),
            _buildGenderChips(),
          ]),
          if (controller.isFieldVisible('targetAgeGroup'))
          ZenoDropdown<String>(key: const ValueKey('targetAgeGroup'), label: "Age Group", value: p.targetAgeGroup.isEmpty ? null : p.targetAgeGroup, items: ["Adult", "Teens", "Kids", "Toddler", "Baby"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(targetAgeGroup: v), width: ZenoFieldWidth.medium),
          if (controller.isFieldVisible('countryOfOrigin'))
          ZenoTextField(key: const ValueKey('countryOfOrigin'), label: "Country of Origin", initialValue: p.countryOfOrigin, onChanged: (v) => controller.updateField(countryOfOrigin: v), width: ZenoFieldWidth.medium),
        ]),
      ),
      StudioSectionCard(
        title: "Collection & Lifecycle",
        subtitle: "Seasonality and drop information",
        icon: Icons.calendar_today_outlined,
        accentColor: colors.statusInfo,
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          if (controller.isFieldVisible('season'))
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Fashion Season", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
            const SizedBox(height: 8),
            _buildSeasonChips(),
          ]),
          if (controller.isFieldVisible('collectionEdition'))
          ZenoTextField(key: const ValueKey('collectionEdition'), label: "Collection / Edition Name", initialValue: p.collectionEdition, onChanged: (v) => controller.updateField(collectionEdition: v), width: ZenoFieldWidth.standard, hint: "e.g., Summer Oasis 2026"),
          if (controller.isFieldVisible('status'))
          ZenoDropdown<String>(key: const ValueKey('status'), label: "Lifecycle Status", value: p.status, items: ["Active", "Phase-Out", "Discontinued"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(status: v), width: ZenoFieldWidth.medium),
        ]),
      ),
    ]);
  }

  Widget _buildGenderChips() {
    final list = ["Men", "Women", "Unisex", "Boys", "Girls", "Infant"];
    return Wrap(spacing: 6, children: list.map((g) => Padding(padding: const EdgeInsets.only(bottom: 4), child: ChoiceChip(label: Text(g, style: const TextStyle(fontSize: 12)), selected: controller.product.gender == g, onSelected: (s) => controller.updateField(gender: s ? g : ""), selectedColor: colors.accentPrimary.withValues(alpha: 0.2), checkmarkColor: colors.accentPrimary))).toList());
  }

  Widget _buildSeasonChips() {
    final list = ["Spring", "Summer", "Autumn", "Winter", "All-Season", "Festive"];
    return Wrap(spacing: 6, children: list.map((s) => Padding(padding: const EdgeInsets.only(bottom: 4), child: ChoiceChip(label: Text(s, style: const TextStyle(fontSize: 12)), selected: controller.product.season == s, onSelected: (v) => controller.updateField(season: v ? s : ""), selectedColor: colors.accentPrimary.withValues(alpha: 0.2), checkmarkColor: colors.accentPrimary))).toList());
  }
}
