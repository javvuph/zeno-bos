import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/fashion_config.dart';
import '../variant_matrix.dart';

class FashionVariantsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final FashionCategoryConfig config;
  const FashionVariantsTab({super.key, required this.controller, required this.colors, required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(child: _buildAttributePanel()),
          const SizedBox(width: 24),
          Expanded(child: _buildMediaPanel()),
        ]),
      ),
      const SizedBox(height: 16),
      VariantMatrix(controller: controller, colors: colors),
    ]);
  }

  Widget _buildAttributePanel() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader("1. ${config.axis1Name} Attributes", Icons.straighten_rounded),
      const SizedBox(height: 12),
      Wrap(spacing: 6, runSpacing: 6, children: [
        ...config.defaultAxis1Options.map((o) => _chip(o, controller.selectedSizes.contains(o), () => controller.toggleSize(o))),
        _addBtn(() {}),
      ]),
      const SizedBox(height: 24),
      _sectionHeader("2. ${config.axis2Name} Attributes", Icons.palette_outlined),
      const SizedBox(height: 12),
      Wrap(spacing: 6, runSpacing: 6, children: [
        ...controller.availableColors.map((c) => _colorChip(c)),
        _addBtn(() {}),
      ]),
    ]);
  }

  Widget _buildMediaPanel() {
    return Container(
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(children: [Text("COLOR-TABBED MEDIA", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)), const Spacer()]),
        const SizedBox(height: 12),
        Container(width: 120, height: 160, decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Center(child: Icon(Icons.add_a_photo_outlined, color: colors.textDisabled, size: 24))),
      ]),
    );
  }

  Widget _sectionHeader(String t, IconData i) => Row(children: [Icon(i, size: 14, color: colors.accentPrimary), const SizedBox(width: 8), Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900))]);
  Widget _chip(String l, bool s, VoidCallback t) => InkWell(onTap: t, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: s ? colors.accentPrimary : colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: s ? colors.accentPrimary : colors.borderSubtle)), child: Text(l, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: s ? colors.bgTier1 : colors.textPrimary))));
  Widget _colorChip(String c) => InkWell(onTap: () => controller.toggleColor(c), child: Container(padding: const EdgeInsets.fromLTRB(6, 4, 10, 4), decoration: BoxDecoration(color: controller.selectedColors.contains(c) ? colors.accentPrimary : colors.bgTier3, borderRadius: BorderRadius.circular(16), border: Border.all(color: controller.selectedColors.contains(c) ? colors.accentPrimary : colors.borderSubtle)), child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 10, height: 10, decoration: BoxDecoration(color: controller.getColorValue(c), shape: BoxShape.circle, border: Border.all(color: Colors.white54))), const SizedBox(width: 6), Text(c, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: controller.selectedColors.contains(c) ? colors.bgTier1 : colors.textPrimary))])));
  Widget _addBtn(VoidCallback onTap) => InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: colors.bgTier3, shape: BoxShape.circle, border: Border.all(color: colors.borderSubtle)), child: Icon(Icons.add, size: 12, color: colors.textSecondary)));
}
