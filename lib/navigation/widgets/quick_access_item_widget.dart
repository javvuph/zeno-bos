import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/quick_access_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class QuickAccessItemWidget extends StatefulWidget {
  final QuickAccessItem item;
  final VoidCallback onTap;

  const QuickAccessItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<QuickAccessItemWidget> createState() => _QuickAccessItemWidgetState();
}

class _QuickAccessItemWidgetState extends State<QuickAccessItemWidget> {
  bool _isHovered = false;
  final NavigationController _navController = NavigationController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final isActive = _navController.currentRoute == widget.item.route;

    // Monochrome Standard: Inactive is textSecondary, Active/Hover is Primary or Accent
    final iconColor = isActive
        ? colors.accentPrimary
        : (_isHovered ? colors.textPrimary : colors.textSecondary);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onSecondaryTapDown: (details) =>
            _showContextMenu(context, details.globalPosition),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            // Spec: Raised Dark Charcoal pills (#131722)
            color: isActive
                ? colors.accentPrimary.withValues(alpha: 0.08)
                : (_isHovered ? colors.bgHover : colors.bgTier2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isActive
                  ? colors.accentPrimary.withValues(alpha: 0.3)
                  : colors.borderSubtle,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.item.icon, size: 14, color: iconColor),
              const SizedBox(width: 8),
              Text(
                widget.item.label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive || _isHovered
                      ? colors.textPrimary
                      : Colors.white.withValues(alpha: 0.9),
                ),
              ),
              if (widget.item.isAI) ...[
                const SizedBox(width: 6),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      ZenoTheme.aiVioletGradient.createShader(bounds),
                  child: const Text("AI",
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, Offset position) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      color: colors.bgSurface,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colors.borderSubtle),
      ),
      items: [
        PopupMenuItem<String>(
          value: 'remove',
          onTap: () => QuickAccessController().removeItem(widget.item.route),
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 16, color: colors.statusDanger),
              const SizedBox(width: 12),
              Text(
                "Remove from Quick Access",
                style: TextStyle(
                    fontSize: 12,
                    color: colors.statusDanger,
                    fontFamily: 'Inter'),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'pin',
          child: Row(
            children: [
              Icon(Icons.push_pin_outlined,
                  size: 16, color: colors.textSecondary),
              const SizedBox(width: 12),
              Text(
                "Pin to Workspace",
                style: TextStyle(
                    fontSize: 12,
                    color: colors.textPrimary,
                    fontFamily: 'Inter'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
