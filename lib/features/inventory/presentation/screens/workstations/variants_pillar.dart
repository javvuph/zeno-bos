import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';
import 'variant_matrix.dart';

class VariantsPillar extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const VariantsPillar({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // 1. ATTRIBUTES SELECTION (LEFT 50%)
          Expanded(child: _buildAttributePanel()),
          const SizedBox(width: 24),
          // 2. MEDIA MANAGEMENT (RIGHT 50%)
          Expanded(child: _buildMediaPanel()),
        ]),
      ),
      if (controller.product.variants.isNotEmpty) ...[
        const SizedBox(height: 16),
        VariantMatrix(controller: controller, colors: colors),
      ],
    ]);
  }

  Widget _buildAttributePanel() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader("1. Color Attributes", Icons.palette_outlined),
      const SizedBox(height: 12),
      Wrap(spacing: 6, runSpacing: 6, children: [
        ...controller.availableColors.map((c) => _colorChip(c)),
        _addBtn(() => controller.addCustomColor("New Color")),
      ]),
      const SizedBox(height: 24),
      _sectionHeader("2. Size Attributes", Icons.straighten_rounded),
      const SizedBox(height: 12),
      _sizeSystemTabs(),
      const SizedBox(height: 12),
      Wrap(spacing: 6, runSpacing: 6, children: [
        ...controller.getSizesForType(controller.sizeType).map((s) => _sizeChip(s)),
        _addBtn(() => controller.addCustomSize("New Size")),
      ]),
    ]);
  }

  Widget _buildMediaPanel() {
    final activeColor = controller.activeMediaColor;
    return Container(
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
      child: Column(children: [
        _mediaTabs(),
        if (activeColor != null) Expanded(child: _mediaUploadBox(activeColor))
        else Expanded(child: _emptyMediaState()),
      ]),
    );
  }

  Widget _mediaTabs() {
    return Container(
      height: 36, width: double.infinity, decoration: BoxDecoration(color: colors.bgTier3, borderRadius: const BorderRadius.vertical(top: Radius.circular(11))),
      child: ListView(scrollDirection: Axis.horizontal, children: controller.selectedColors.map((c) => _mediaTab(c)).toList()),
    );
  }

  Widget _mediaTab(String color) {
    final isActive = controller.activeMediaColor == color;
    return InkWell(
      onTap: () => controller.setActiveMediaColor(color),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? colors.accentPrimary : Colors.transparent, width: 2))),
        alignment: Alignment.center,
        child: Text(color, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: isActive ? colors.accentPrimary : colors.textDisabled)),
      ),
    );
  }

  Widget _mediaUploadBox(String color) {
    final assets = controller.product.colorMediaLibrary[color] ?? [];
    return Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      Row(children: [Text("Media for $color", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)), const Spacer(), Text("${assets.length} Assets", style: TextStyle(fontSize: 9, color: colors.textDisabled))]),
      const SizedBox(height: 12),
      Expanded(child: SingleChildScrollView(child: Wrap(spacing: 10, runSpacing: 10, children: [
        ...assets.asMap().entries.map((e) => _mediaThumb(color, e.key, e.value.url)),
        _addMediaPlaceholder(color),
      ]))),
      const SizedBox(height: 16),
      Row(children: [
        ZenoButton(label: "USE CUSTOM", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {}),
        const SizedBox(width: 6),
        ZenoButton(label: "OVERRIDE", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {}),
      ]),
    ]));
  }

  Widget _sectionHeader(String t, IconData i) => Row(children: [Icon(i, size: 14, color: colors.accentPrimary), const SizedBox(width: 8), Text(t, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.3))]);

  Widget _colorChip(String color) {
    final isSelected = controller.selectedColors.contains(color);
    
    // Check if any variant of this color has stock
    final variantsOfColor = controller.generatedVariants.where((v) => v.color == color);
    final int totalStock = variantsOfColor.fold(0, (sum, v) => sum + v.stock);
    final bool hasStock = controller.generatedVariants.isEmpty || totalStock > 0;

    return Tooltip(
      message: hasStock ? (controller.generatedVariants.isEmpty ? color : "$color ($totalStock in stock)") : "$color (No Stock)",
      child: InkWell(
        onTap: () => controller.toggleColor(color),
        child: Opacity(
          opacity: hasStock ? 1.0 : 0.4,
          child: Container(
            padding: const EdgeInsets.fromLTRB(6, 4, 10, 4),
            decoration: BoxDecoration(
              color: isSelected ? colors.accentPrimary : colors.bgTier3, 
              borderRadius: BorderRadius.circular(16), 
              border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle),
              boxShadow: isSelected ? [
                BoxShadow(color: colors.accentPrimary.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))
              ] : null,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 12, height: 12, 
                    decoration: BoxDecoration(
                      color: controller.getColorValue(color), 
                      shape: BoxShape.circle, 
                      border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1)
                    )
                  ),
                  if (!hasStock && controller.generatedVariants.isNotEmpty)
                    Container(
                      width: 14, height: 1,
                      transform: Matrix4.rotationZ(0.785), // 45 degrees
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                ],
              ),
              const SizedBox(width: 6),
              Text(
                color, 
                style: TextStyle(
                  fontSize: 10, 
                  fontWeight: FontWeight.bold, 
                  color: isSelected ? Colors.white : colors.textPrimary,
                  decoration: hasStock ? null : TextDecoration.lineThrough,
                  decorationColor: colors.textDisabled,
                )
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _sizeChip(String size) {
    final isSelected = controller.selectedSizes.contains(size);

    // Check stock for this size
    final activeColor = controller.activeVariantIndex != null 
        ? controller.generatedVariants[controller.activeVariantIndex!].color 
        : (controller.selectedColors.isNotEmpty ? controller.selectedColors.first : null);
    
    int stockCount = 0;
    if (activeColor != null) {
      stockCount = controller.generatedVariants.where((v) => v.size == size && v.color == activeColor).fold(0, (sum, v) => sum + v.stock);
    } else {
      stockCount = controller.generatedVariants.where((v) => v.size == size).fold(0, (sum, v) => sum + v.stock);
    }
    final bool hasStock = controller.generatedVariants.isEmpty || stockCount > 0;

    return Tooltip(
      message: hasStock ? (controller.generatedVariants.isEmpty ? "Size $size" : "Size $size ($stockCount in stock)") : "Size $size (No Stock)",
      child: InkWell(
        onTap: () => controller.toggleSize(size),
        child: Opacity(
          opacity: hasStock ? 1.0 : 0.4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), 
            decoration: BoxDecoration(
              color: isSelected ? colors.accentPrimary : colors.bgTier3, 
              borderRadius: BorderRadius.circular(6), 
              border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle)
            ), 
            child: Text(
              size, 
              style: TextStyle(
                fontSize: 10, 
                fontWeight: FontWeight.bold, 
                color: isSelected ? Colors.white : colors.textPrimary,
                decoration: hasStock ? null : TextDecoration.lineThrough,
                decorationColor: colors.textDisabled,
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget _sizeSystemTabs() => Row(children: VariantSizeType.values.map((t) => Padding(padding: const EdgeInsets.only(right: 6), child: InkWell(onTap: () => controller.setSizeType(t), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: controller.sizeType == t ? colors.accentPrimary.withValues(alpha: 0.1) : Colors.transparent, borderRadius: BorderRadius.circular(4), border: Border.all(color: controller.sizeType == t ? colors.accentPrimary : colors.borderSubtle)), child: Text(_toTitleCase(t.name), style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: controller.sizeType == t ? colors.accentPrimary : colors.textDisabled)))))).toList());

  String _toTitleCase(String s) {
    if (s == 'numericUK') return 'UK Numeric';
    if (s == 'numericEU') return 'EU Numeric';
    return s[0].toUpperCase() + s.substring(1);
  }

  Widget _addBtn(VoidCallback onTap) => InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: colors.bgTier3, shape: BoxShape.circle, border: Border.all(color: colors.borderSubtle)), child: Icon(Icons.add, size: 12, color: colors.textSecondary)));

  Widget _mediaThumb(String c, int i, String url) => Stack(children: [Container(width: 90, height: 120, decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8)), child: url.isNotEmpty ? Image.network(url, fit: BoxFit.cover) : Icon(Icons.image, color: colors.textDisabled)), Positioned(top: 4, right: 4, child: InkWell(onTap: () => controller.removeMedia(c, i), child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, size: 10, color: Colors.white))))]);

  Widget _addMediaPlaceholder(String c) => InkWell(onTap: () => controller.addColorMedia(c), child: Container(width: 90, height: 120, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)), child: Icon(Icons.add_a_photo_outlined, color: colors.textDisabled, size: 20)));

  Widget _emptyMediaState() => Center(child: Text("Select a color to manage assets", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: colors.textDisabled)));
}
