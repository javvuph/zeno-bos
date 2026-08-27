import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../workstations/fashion/variant_matrix.dart';

class TabVariants extends StatelessWidget {
  final ProductStudioController controller;
  const TabVariants({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZenoCard(
            title: "≡ƒº¼ CARTESIAN VARIANT ENGINE",
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildAttributePanel(colors)),
                      const SizedBox(width: 24),
                      Expanded(child: _buildImagePanel(colors)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                VariantMatrix(controller: controller, colors: colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributePanel(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("SELECT VARIANT ATTRIBUTES", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textSecondary)),
        const SizedBox(height: 12),
        const Text("COLORS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: controller.availableColors.map((c) => _colorChip(colors, c)).toList(),
        ),
        const SizedBox(height: 16),
        const Text("SIZES", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: ["XS", "S", "M", "L", "XL", "XXL"].map((s) => _sizeChip(colors, s)).toList(),
        ),
      ],
    );
  }

  Widget _buildImagePanel(ZenoSemanticColors colors) {
    return Container(
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo_outlined, color: colors.textDisabled, size: 32),
          const SizedBox(height: 8),
          Text("VARIANT IMAGES", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textSecondary)),
          const SizedBox(height: 4),
          const Text("Images will be linked to selected colors.", style: TextStyle(fontSize: 9, color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _colorChip(ZenoSemanticColors colors, String c) {
    final isSelected = controller.selectedColors.contains(c);
    
    // Determine if this color has stock across generated variants
    final variantsOfColor = controller.generatedVariants.where((v) => v.color == c);
    // If no variants generated yet, we assume it's "available" for selection
    final bool hasStock = controller.generatedVariants.isEmpty || variantsOfColor.any((v) => v.stock > 0);

    return Tooltip(
      message: hasStock ? c : "$c (No Stock)",
      child: InkWell(
        onTap: () => controller.toggleColor(c),
        child: Opacity(
          opacity: hasStock ? 1.0 : 0.4,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.fromLTRB(6, 4, 10, 4),
            decoration: BoxDecoration(
              color: isSelected ? colors.accentPrimary : colors.bgTier3,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle),
              boxShadow: isSelected ? [
                BoxShadow(color: colors.accentPrimary.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))
              ] : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10, height: 10, 
                  decoration: BoxDecoration(
                    color: controller.getColorValue(c), 
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1),
                  )
                ),
                const SizedBox(width: 8),
                Text(
                  c, 
                  style: TextStyle(
                    fontSize: 10, 
                    fontWeight: FontWeight.bold, 
                    color: isSelected ? Colors.white : colors.textPrimary
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sizeChip(ZenoSemanticColors colors, String s) {
    final isSelected = controller.selectedSizes.contains(s);
    
    // Check stock for this size
    final activeColor = controller.activeVariantIndex != null 
        ? controller.generatedVariants[controller.activeVariantIndex!].color 
        : (controller.selectedColors.isNotEmpty ? controller.selectedColors.first : null);
    
    int stockCount = 0;
    if (activeColor != null) {
      stockCount = controller.generatedVariants.where((v) => v.size == s && v.color == activeColor).fold(0, (sum, v) => sum + v.stock);
    } else {
      stockCount = controller.generatedVariants.where((v) => v.size == s).fold(0, (sum, v) => sum + v.stock);
    }
    final bool hasStock = controller.generatedVariants.isEmpty || stockCount > 0;

    return Tooltip(
      message: hasStock ? (controller.generatedVariants.isEmpty ? "Size $s" : "Size $s ($stockCount in stock)") : "Size $s (No Stock)",
      child: InkWell(
        onTap: () => controller.toggleSize(s),
        child: Opacity(
          opacity: hasStock ? 1.0 : 0.4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? colors.accentPrimary : colors.bgTier3,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle),
            ),
            child: Text(
              s, 
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
}
