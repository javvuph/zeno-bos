import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoSidePalette extends StatelessWidget {
  const ZenoSidePalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: const BoxDecoration(
        color: ZenoTheme.surface,
        border: Border(right: BorderSide(color: ZenoTheme.border)),
      ),
      child: const Column(
        children: [
          SizedBox(height: 16),
          _SideIcon(
              icon: Icons.dashboard_outlined,
              label: 'Dashboard',
              isActive: true),
          _SideIcon(icon: Icons.flash_on_outlined, label: 'Quick Actions'),
          _SideIcon(icon: Icons.star_outline, label: 'Favorites'),
          _SideIcon(icon: Icons.history_outlined, label: 'Recent'),
          _SideIcon(icon: Icons.layers_outlined, label: 'Workspaces'),
          Spacer(),
          _SideIcon(icon: Icons.help_outline, label: 'Help & Support'),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SideIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _SideIcon(
      {required this.icon, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      preferBelow: false,
      margin: const EdgeInsets.only(left: 16),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? ZenoTheme.accent.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isActive ? ZenoTheme.accent : ZenoTheme.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}
