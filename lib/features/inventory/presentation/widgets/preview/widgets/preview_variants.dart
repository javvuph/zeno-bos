import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';

Widget buildVariantSelectors(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Divider(height: 12),
    if (controller.selectedColors.isNotEmpty) ...[
      Text("COLOR", style: TextStyle(fontSize: 6.5, fontWeight: FontWeight.w900, color: colors.textDisabled)),
      const SizedBox(height: 4),
      SizedBox(height: 18, child: ListView.separated(
        scrollDirection: Axis.horizontal, itemCount: controller.selectedColors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 5),
        itemBuilder: (context, idx) {
          final colorName = controller.selectedColors[idx];
          bool isSelected = controller.activeVariantIndex != null && controller.generatedVariants[controller.activeVariantIndex!].color == colorName;
          
          // Check if any variant of this color has stock
          final variantsOfColor = controller.generatedVariants.where((v) => v.color == colorName);
          final int totalStock = variantsOfColor.fold(0, (sum, v) => sum + v.stock);
          final bool hasStock = totalStock > 0;
          
          return Tooltip(
            message: hasStock ? "$colorName ($totalStock in stock)" : "$colorName (No Stock)",
            waitDuration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onTap: () {
                final vIdx = controller.generatedVariants.indexWhere((v) => v.color == colorName);
                if (vIdx != -1) controller.setActiveVariant(vIdx);
              },
              child: Opacity(
                opacity: hasStock ? 1.0 : 0.4,
                child: Container(
                  width: 18, 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    color: getColorFromName(colorName), 
                    border: Border.all(
                      color: isSelected ? colors.accentPrimary : colors.borderSubtle, 
                      width: isSelected ? 1.5 : 1
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(color: colors.accentPrimary.withValues(alpha: 0.3), blurRadius: 4, spreadRadius: 1)
                    ] : null,
                  )
                ),
              ),
            ),
          );
        },
      )),
    ],
    if (controller.selectedSizes.isNotEmpty) ...[
      const SizedBox(height: 6),
      Text("SIZE", style: TextStyle(fontSize: 6.5, fontWeight: FontWeight.w900, color: colors.textDisabled)),
      const SizedBox(height: 4),
      SizedBox(height: 18, child: ListView.separated(
        scrollDirection: Axis.horizontal, itemCount: controller.selectedSizes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 5),
        itemBuilder: (context, idx) {
          final sizeName = controller.selectedSizes[idx];
          bool isSelected = controller.activeVariantIndex != null && controller.generatedVariants[controller.activeVariantIndex!].size == sizeName;
          
          // Check stock for this size (relative to active color if possible)
          final activeColor = controller.activeVariantIndex != null 
              ? controller.generatedVariants[controller.activeVariantIndex!].color 
              : (controller.selectedColors.isNotEmpty ? controller.selectedColors.first : null);
          
          int stockCount = 0;
          if (activeColor != null) {
            stockCount = controller.generatedVariants.where((v) => v.size == sizeName && v.color == activeColor).fold(0, (sum, v) => sum + v.stock);
          } else {
            stockCount = controller.generatedVariants.where((v) => v.size == sizeName).fold(0, (sum, v) => sum + v.stock);
          }
          final bool hasStock = stockCount > 0;

          return Tooltip(
            message: hasStock ? "Size $sizeName ($stockCount in stock)" : "Size $sizeName (No Stock)",
            child: GestureDetector(
              onTap: () {
                final color = controller.activeVariantIndex != null ? controller.generatedVariants[controller.activeVariantIndex!].color : controller.selectedColors.first;
                final vIdx = controller.generatedVariants.indexWhere((v) => v.size == sizeName && v.color == color);
                if (vIdx != -1) { controller.setActiveVariant(vIdx); } else { final vIdxAny = controller.generatedVariants.indexWhere((v) => v.size == sizeName); if (vIdxAny != -1) controller.setActiveVariant(vIdxAny); }
              },
              child: Opacity(
                opacity: hasStock ? 1.0 : 0.4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6), 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), 
                    color: isSelected ? colors.accentPrimary : colors.bgTier3, 
                    border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle)
                  ), 
                  child: Center(
                    child: Text(
                      sizeName, 
                      style: TextStyle(
                        fontSize: 7.5, 
                        fontWeight: FontWeight.bold, 
                        color: isSelected ? Colors.black : colors.textPrimary
                      )
                    )
                  )
                ),
              ),
            ),
          );
        },
      )),
    ],
  ]);
}

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'black': return Colors.black; case 'white': return Colors.white; case 'red': return Colors.red;
    case 'blue': return Colors.blue; case 'green': return Colors.green; case 'yellow': return Colors.yellow;
    case 'grey': return Colors.grey; case 'orange': return Colors.orange; case 'purple': return Colors.purple;
    case 'brown': return Colors.brown; case 'pink': return Colors.pink; case 'beige': return const Color(0xFFF5F5DC);
    default: return Colors.grey;
  }
}
