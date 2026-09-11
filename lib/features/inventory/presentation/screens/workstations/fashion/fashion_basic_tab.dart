import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../widgets/product_studio_redesign_widgets.dart';

class FashionBasicTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionBasicTab({super.key, required this.controller, required this.colors});

  static const List<String> _brandOptions = ["ZENO", "Urban Thread", "Classic Loom", "Street Core", "Heritage Wear"];
  static const List<String> _genderOptions = ["Men", "Women", "Unisex", "Boys", "Girls", "Infant"];
  static const List<String> _ageGroupOptions = ["Adult", "Teens", "Kids", "Toddler", "Baby"];
  static const List<String> _countryOptions = ["India", "Sri Lanka", "Bangladesh", "China", "Vietnam", "Turkey"];
  static const List<String> _seasonOptions = ["Spring", "Summer", "Autumn", "Winter", "All-Season", "Festive"];
  static const List<String> _collectionOptions = ["Core", "Summer Drop", "Festive Edit", "Premium Capsule", "Limited Edition"];
  static const List<String> _statusOptions = ["Active", "Phase-Out", "Discontinued"];

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
          ZenoDropdown<String>(key: const ValueKey('brand'), label: "Brand / Label", value: p.brand.isEmpty ? null : p.brand, items: _withCurrent(_brandOptions, p.brand).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(brand: v), width: ZenoFieldWidth.medium, isRequired: true, onQuickAdd: () => _showQuickAddDialog(context, "Brand / Label", (val) => controller.updateField(brand: val))),
          if (controller.isFieldVisible('gender'))
          ZenoDropdown<String>(label: "Gender", value: p.gender.isEmpty ? null : p.gender, items: _withCurrent(_genderOptions, p.gender).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(gender: v), width: ZenoFieldWidth.medium, onQuickAdd: () => _showQuickAddDialog(context, "Gender", (val) => controller.updateField(gender: val))),
          if (controller.isFieldVisible('targetAgeGroup'))
          ZenoDropdown<String>(key: const ValueKey('targetAgeGroup'), label: "Age Group", value: p.targetAgeGroup.isEmpty ? null : p.targetAgeGroup, items: _withCurrent(_ageGroupOptions, p.targetAgeGroup).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(targetAgeGroup: v), width: ZenoFieldWidth.medium, onQuickAdd: () => _showQuickAddDialog(context, "Age Group", (val) => controller.updateField(targetAgeGroup: val))),
          if (controller.isFieldVisible('countryOfOrigin'))
          ZenoDropdown<String>(key: const ValueKey('countryOfOrigin'), label: "Country of Origin", value: p.countryOfOrigin.isEmpty ? null : p.countryOfOrigin, items: _withCurrent(_countryOptions, p.countryOfOrigin).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(countryOfOrigin: v), width: ZenoFieldWidth.medium, onQuickAdd: () => _showQuickAddDialog(context, "Country of Origin", (val) => controller.updateField(countryOfOrigin: val))),
        ]),
      ),
      StudioSectionCard(
        title: "Collection & Lifecycle",
        subtitle: "Seasonality and drop information",
        icon: Icons.calendar_today_outlined,
        accentColor: colors.statusInfo,
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          if (controller.isFieldVisible('season'))
          ZenoDropdown<String>(label: "Season", value: p.season.isEmpty ? null : p.season, items: _withCurrent(_seasonOptions, p.season).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(season: v), width: ZenoFieldWidth.medium, onQuickAdd: () => _showQuickAddDialog(context, "Season", (val) => controller.updateField(season: val))),
          if (controller.isFieldVisible('collectionEdition'))
          ZenoDropdown<String>(key: const ValueKey('collectionEdition'), label: "Collection / Edition", value: p.collectionEdition.isEmpty ? null : p.collectionEdition, items: _withCurrent(_collectionOptions, p.collectionEdition).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(collectionEdition: v), width: ZenoFieldWidth.standard, onQuickAdd: () => _showQuickAddDialog(context, "Collection / Edition", (val) => controller.updateField(collectionEdition: val))),
          if (controller.isFieldVisible('status'))
          ZenoDropdown<String>(key: const ValueKey('status'), label: "Status", value: p.status, items: _withCurrent(_statusOptions, p.status).map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(status: v), width: ZenoFieldWidth.medium, onQuickAdd: () => _showQuickAddDialog(context, "Status", (val) => controller.updateField(status: val))),
        ]),
      ),
    ]);
  }

  List<String> _withCurrent(List<String> options, String current) {
    if (current.isEmpty || options.contains(current)) return options;
    return [...options, current];
  }

  void _showQuickAddDialog(BuildContext context, String type, Function(String) onAdd) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Add Custom $type", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: textController,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            labelText: "$type Name",
            hintText: "Enter $type name",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onAdd(textController.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
