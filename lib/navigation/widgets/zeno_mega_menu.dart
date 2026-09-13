import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class ZenoMegaMenu extends StatefulWidget {
  final ZenoMenuCategory category;
  final VoidCallback onEnter;
  final VoidCallback onExit;
  final VoidCallback? onAction; // Added to handle menu dismissal on click

  const ZenoMegaMenu({
    super.key,
    required this.category,
    required this.onEnter,
    required this.onExit,
    this.onAction,
  });

  @override
  State<ZenoMegaMenu> createState() => _ZenoMegaMenuState();
}

class _ZenoMegaMenuState extends State<ZenoMegaMenu> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // We assume single column for the new ZBOS hierarchy
    final column = widget.category.columns.first;
    final themeColor = colors.accentPrimary;

    return MouseRegion(
      onEnter: (_) => widget.onEnter(),
      onExit: (_) => widget.onExit(),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 280, // Slightly wider for full labels
          constraints:
              const BoxConstraints(maxHeight: 420), // Spec: Max-Height 420px
          decoration: BoxDecoration(
            color: colors.bgTier2
                .withValues(alpha: isDark ? 0.95 : 0.98), // Solider background
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark
                  ? colors.accentPrimary.withValues(alpha: 0.2)
                  : colors.borderSubtle,
              width: isDark ? 1.2 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: (isDark ? Colors.black : Colors.black12)
                    .withValues(alpha: 0.5),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
              if (isDark)
                BoxShadow(
                  color: colors.accentPrimary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  spreadRadius: -2,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MODULE HEADER
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.bgTier1.withValues(alpha: 0.6),
                    border:
                        Border(bottom: BorderSide(color: colors.borderSubtle)),
                  ),
                  child: Text(
                    "${widget.category.label.toUpperCase()} WORKSPACE",
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: widget.category.color,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                // ITEMS LIST WITH SCROLLING
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: column.items
                          .map((item) => _MenuItem(
                                item: item,
                                category: widget.category,
                                themeColor: themeColor,
                                onAction: widget.onAction,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  final ZenoMenuItem item;
  final ZenoMenuCategory category;
  final Color themeColor;
  final VoidCallback? onAction;

  const _MenuItem(
      {required this.item,
      required this.category,
      required this.themeColor,
      this.onAction});

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    final bool isQuickAction = widget.item.label.startsWith('⚡') ||
        widget.item.label.startsWith('📍') ||
        widget.item.label.startsWith('🏦');

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color itemColor = isQuickAction
        ? (isDark
            ? colors.accentPrimary
            : colors.accentPrimary
                .withRed(20)
                .withBlue(200)) // Sharper accent for light theme
        : colors.textPrimary; // Maximum visibility for all items

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // Dismiss menu before action
          widget.onAction?.call();

          if (widget.item.route != null) {
            NavigationController().navigateTo(widget.item.route!);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.category.color.withValues(alpha: isDark ? 0.15 : 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                size: 14,
                color: _isHovered ? colors.textPrimary : widget.category.color, // Submenu icons now colorful too
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.item.label,
                  style: TextStyle(
                    fontSize: 11.5, // Slightly larger
                    fontFamily: 'Inter',
                    fontWeight: (isQuickAction || _isHovered)
                        ? FontWeight.w800 // Ultra bold for visibility
                        : FontWeight.w700, // Bold as base
                    color: _isHovered ? colors.textPrimary : itemColor,
                  ),
                ),
              ),
              if (widget.item.isAI) _aiBadge(colors.accentPrimary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aiBadge(Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text('AI',
            style: TextStyle(
                fontSize: 9, color: color, fontWeight: FontWeight.bold)),
      );
}
