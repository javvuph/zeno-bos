import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/context_menu.dart';
import '../navigation_controller.dart';
import '../navigation_models.dart';

class ZenoTabStrip extends StatelessWidget {
  const ZenoTabStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        return Container(
          height: 32,
          decoration: const BoxDecoration(
            color: ZenoTheme.background,
            border: Border(bottom: BorderSide(color: ZenoTheme.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nav.tabs.length,
                  itemBuilder: (context, index) {
                    final tab = nav.tabs[index];
                    return _ZenoTabItem(
                      tab: tab,
                      isActive: nav.activeTabId == tab.id,
                      onTap: () => nav.switchTab(tab.id),
                      onClose: () => nav.closeTab(tab.id),
                    );
                  },
                ),
              ),
              const VerticalDivider(width: 1, color: ZenoTheme.border),
              IconButton(
                icon: const Icon(Icons.add,
                    size: 18, color: ZenoTheme.textSecondary),
                onPressed: () => nav.openTab('dashboard'),
                tooltip: 'Open New Dashboard Tab',
              ),
              _verticalDivider(),
              IconButton(
                icon: Icon(
                  nav.isSidePanelOpen
                      ? Icons.view_sidebar
                      : Icons.view_sidebar_outlined,
                  size: 18,
                  color: nav.isSidePanelOpen
                      ? ZenoTheme.accent
                      : ZenoTheme.textSecondary,
                ),
                onPressed: nav.toggleSidePanel,
                tooltip: 'Toggle Side Information Panel',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _verticalDivider() => Container(
      width: 1,
      height: 20,
      color: ZenoTheme.border,
      margin: const EdgeInsets.symmetric(horizontal: 4));
}

class _ZenoTabItem extends StatelessWidget {
  final ZenoTab tab;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const _ZenoTabItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();
    return ZenoContextMenu(
      items: [
        ZenoContextMenuItem(
            label: 'Switch to Tab', icon: Icons.tab, onTap: onTap),
        ZenoContextMenuItem(
            label: 'Duplicate Tab',
            icon: Icons.copy,
            onTap: () => nav.duplicateTab(tab.id)),
        ZenoContextMenuItem(
            label: tab.isPinned ? 'Unpin Tab' : 'Pin Tab',
            icon: Icons.push_pin,
            onTap: () => nav.togglePin(tab.id)),
        ZenoContextMenuItem(
            label: 'Close Tab', icon: Icons.close, onTap: onClose),
        ZenoContextMenuItem(
            label: 'Close Others',
            icon: Icons.tab_unselected,
            onTap: () => nav.closeOthers(tab.id)),
        ZenoContextMenuItem(
            label: 'Close All',
            icon: Icons.close_fullscreen,
            onTap: nav.closeAll,
            isDestructive: true),
      ],
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isActive ? ZenoTheme.surface : Colors.transparent,
            border: Border(
              right: const BorderSide(color: ZenoTheme.border),
              top: BorderSide(
                  color: isActive
                      ? ZenoTheme.accent
                      : (tab.isPinned
                          ? ZenoTheme.accent.withValues(alpha: 0.3)
                          : Colors.transparent),
                  width: 2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(tab.icon,
                  size: 14,
                  color: isActive ? ZenoTheme.accent : ZenoTheme.textSecondary),
              const SizedBox(width: 8),
              if (tab.isPinned)
                const Icon(Icons.push_pin, size: 10, color: ZenoTheme.accent),
              Text(
                tab.title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive
                      ? ZenoTheme.textPrimary
                      : ZenoTheme.textSecondary,
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  onClose();
                },
                child: Icon(Icons.close,
                    size: 12,
                    color: isActive
                        ? ZenoTheme.textSecondary
                        : ZenoTheme.textSecondary.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
