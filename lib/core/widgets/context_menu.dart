import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoContextMenu extends StatelessWidget {
  final Widget child;
  final List<ZenoContextMenuItem> items;

  const ZenoContextMenu({
    super.key,
    required this.child,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) =>
          _showMenu(context, details.globalPosition),
      child: child,
    );
  }

  void _showMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      color: ZenoTheme.surface,
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: ZenoTheme.border)),
      items: items.map((item) {
        return PopupMenuItem(
          onTap: item.onTap,
          child: Row(
            children: [
              Icon(item.icon,
                  size: 16,
                  color: item.isDestructive
                      ? Colors.redAccent
                      : ZenoTheme.textSecondary),
              const SizedBox(width: 12),
              Text(item.label,
                  style: TextStyle(
                      fontSize: 12,
                      color: item.isDestructive
                          ? Colors.redAccent
                          : ZenoTheme.textPrimary)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ZenoContextMenuItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const ZenoContextMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
}
