import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class EnterpriseLeftSidebar extends StatefulWidget {
  const EnterpriseLeftSidebar({super.key});

  @override
  State<EnterpriseLeftSidebar> createState() => _EnterpriseLeftSidebarState();
}

class _EnterpriseLeftSidebarState extends State<EnterpriseLeftSidebar> {
  bool _isCollapsed = false;
  String? _expandedCategoryId;

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isCollapsed ? 64 : 240,
          color: ZenoTheme.navigationBackground,
          child: Column(
            children: [
              // LOGO
              Container(
                height: 52,
                padding:
                    EdgeInsets.symmetric(horizontal: _isCollapsed ? 0 : 16),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: _isCollapsed
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.apps, color: Colors.white, size: 28),
                    if (!_isCollapsed) ...[
                      const SizedBox(width: 12),
                      const Text(
                        "ZBOS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: MenuRegistry.all.map((category) {
                    final isActive = nav.currentRoute.startsWith(category.id);
                    final isExpanded = _expandedCategoryId == category.id;

                    return Column(
                      children: [
                        _SidebarItem(
                          icon: category.icon,
                          label: category.label,
                          isCollapsed: _isCollapsed,
                          isActive: isActive,
                          onTap: () {
                            if (_isCollapsed) {
                              setState(() => _isCollapsed = false);
                              _expandedCategoryId = category.id;
                            } else {
                              setState(() {
                                if (_expandedCategoryId == category.id) {
                                  _expandedCategoryId = null;
                                } else {
                                  _expandedCategoryId = category.id;
                                }
                              });
                            }
                          },
                          trailing: _isCollapsed
                              ? null
                              : Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  color: Colors.white54,
                                  size: 16,
                                ),
                        ),
                        if (!_isCollapsed && isExpanded)
                          ...category.columns
                              .expand((col) => col.items)
                              .map((item) {
                            final isSubActive = nav.currentRoute == item.route;
                            return _SidebarSubItem(
                              label: item.label,
                              isActive: isSubActive,
                              onTap: () => nav.navigateTo(item.route!),
                            );
                          }),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // COLLAPSE BUTTON
              const Divider(color: Colors.white12, height: 1),
              _SidebarItem(
                icon: _isCollapsed
                    ? Icons.keyboard_double_arrow_right
                    : Icons.keyboard_double_arrow_left,
                label: "Collapse",
                isCollapsed: _isCollapsed,
                onTap: () => setState(() => _isCollapsed = !_isCollapsed),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isCollapsed;
  final bool isActive;
  final VoidCallback onTap;
  final Widget? trailing;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isCollapsed,
    this.isActive = false,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 16),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  left: BorderSide(color: ZenoTheme.primary, width: 4))
              : null,
          color: isActive
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment:
              isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(icon,
                color: isActive ? ZenoTheme.primary : Colors.white70, size: 22),
            if (!isCollapsed) ...[
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.white70,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class _SidebarSubItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarSubItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsets.only(left: 54, right: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? ZenoTheme.primary : Colors.white54,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
