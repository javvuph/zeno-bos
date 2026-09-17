import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/top_nav_bar_items.part.dart';

class ZenoTopNavBar extends StatelessWidget {
  final ZenoMenuCategory? activeCategory;
  final Function(ZenoMenuCategory?, Offset?) onHover;

  const ZenoTopNavBar({
    super.key,
    required this.activeCategory,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final screenWidth = MediaQuery.of(context).size.width;

    final double dynamicGap = (screenWidth * 0.015).clamp(10.0, 24.0);

    return Container(
      height: 38,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: MenuRegistry.all.map((category) {
                  final isActive = activeCategory?.id == category.id;
                  final isLast = category.id == MenuRegistry.all.last.id;

                  return Padding(
                    padding: EdgeInsets.only(right: isLast ? 24 : dynamicGap),
                    child: _NavBarItem(
                      category: category,
                      isActive: isActive,
                      onHover: (offset) => onHover(category, offset),
                      onExit: () => onHover(null, null),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LiveStatusWidget(),
              SizedBox(width: 16),
              _ShortcutsButton(),
            ],
          ),
        ],
      ),
    );
  }
}
