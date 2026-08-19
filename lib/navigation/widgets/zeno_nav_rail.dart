import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class ZenoNavRail extends StatelessWidget {
  final ZenoMenuCategory? activeCategory;
  final Function(ZenoMenuCategory?, Offset?) onHover;

  const ZenoNavRail({
    super.key,
    required this.activeCategory,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      width: 60, // Standardized premium rail width
      height: double.infinity,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(right: BorderSide(color: colors.borderSubtle)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: MenuRegistry.all.map((category) {
                  final isActive = activeCategory?.id == category.id;
                  return _NavRailItem(
                    category: category,
                    isActive: isActive,
                    onHover: (offset) => onHover(category, offset),
                    onExit: () => onHover(null, null),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavRailItem extends StatefulWidget {
  final ZenoMenuCategory category;
  final bool isActive;
  final Function(Offset) onHover;
  final VoidCallback onExit;

  const _NavRailItem({
    required this.category,
    required this.isActive,
    required this.onHover,
    required this.onExit,
  });

  @override
  State<_NavRailItem> createState() => _NavRailItemState();
}

class _NavRailItemState extends State<_NavRailItem> {
  bool _isHovered = false;

  String _getDisplayLabel(String label) {
    if (label == "Inventory") return "INVENT";
    if (label == "Procurement") return "PROCURE";
    if (label == "Human Resources") return "HR";
    if (label == "HR & Payroll") return "HR";
    if (label == "Finance & Accounting") return "FINANCE";
    if (label == "Finance & Expenses") return "FINANCE";
    if (label == "Reports & Analytics") return "REPORTS";
    if (label == "AI Centre") return "AI";
    if (label == "Admin") return "ADMIN";
    return label;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final bool hasDropdown = widget.category.hasDropdown;

    final Color symbolColor = widget.isActive || _isHovered
        ? widget.category.color
        : widget.category.color.withValues(alpha: 0.6);

    final Color labelColor = widget.isActive || _isHovered
        ? colors.textPrimary
        : colors.textSecondary;

    return MouseRegion(
      onEnter: (event) {
        if (!mounted) return;
        final renderObject = context.findRenderObject();
        if (renderObject is! RenderBox || !renderObject.hasSize) return;

        setState(() => _isHovered = true);

        if (hasDropdown) {
          final position = renderObject.localToGlobal(Offset.zero);
          widget.onHover(position);
        }
      },
      onExit: (_) {
        if (!mounted) return;
        setState(() => _isHovered = false);
        if (hasDropdown) {
          widget.onExit();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.category.columns.isNotEmpty &&
              widget.category.columns.first.items.isNotEmpty) {
            final firstItem = widget.category.columns.first.items.first;
            if (firstItem.route != null) {
              NavigationController().navigateTo(firstItem.route!);
            }
          }
        },
        child: AnimatedContainer(
          duration: ZenoDuration.fast,
          width: 60,
          height: 46, // Reduced from 48 to ensure full visibility
          margin: const EdgeInsets.symmetric(vertical: 0.5), // Minimal margin
          decoration: BoxDecoration(
            color: widget.isActive
                ? colors.bgTier3
                : (_isHovered ? colors.bgHover : Colors.transparent),
            border: Border(
              left: BorderSide(
                color: widget.isActive ? widget.category.color : Colors.transparent,
                width: 3.0,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.category.icon,
                size: 17, // Reduced from 18
                color: symbolColor,
              ),
              const SizedBox(height: 2), // Reduced from 3
              Text(
                _getDisplayLabel(widget.category.label).toUpperCase(),
                style: TextStyle(
                  fontSize: 7.2, // Reduced from 7.5
                  fontWeight: widget.isActive ? FontWeight.w900 : FontWeight.w700,
                  color: labelColor,
                  letterSpacing: 0.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
