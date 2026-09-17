import 'package:flutter/material.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/zeno_router.dart';
import 'package:zeno/navigation/widgets/enterprise/top_command_bar.dart';
import 'package:zeno/navigation/widgets/enterprise/enterprise_bottom_status_bar.dart';
import 'package:zeno/navigation/widgets/enterprise/enterprise_right_panel.dart';
import 'package:zeno/navigation/widgets/zeno_nav_rail.dart';
import 'package:zeno/navigation/widgets/zeno_quick_access_toolbar.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/widgets/enterprise/workspace_control_bar.dart';
import 'package:zeno/navigation/widgets/zeno_mega_menu_overlay.dart';
import 'package:zeno/core/widgets/premium/zeno_quick_actions_dock.dart';

class ZenoShell extends StatefulWidget {
  const ZenoShell({super.key});

  @override
  State<ZenoShell> createState() => _ZenoShellState();
}

class _ZenoShellState extends State<ZenoShell> {
  late final NavigationController _navController;
  final GlobalKey<ZenoMegaMenuOverlayState> _megaMenuKey = GlobalKey();
  ZenoMenuCategory? _activeNavCategory;

  @override
  void initState() {
    super.initState();
    _navController = NavigationController(); // Singleton
    _navController.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _navController.removeListener(_rebuild);
    super.dispose();
  }

  bool get _isDashboardPage {
    final route = _navController.currentRoute;
    return route == 'dashboard' || route.endsWith('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _navController,
      builder: (context, _) {
        // Global chords (Ctrl+K, F1, Ctrl+/, tab cycling) are owned by
        // ZenoShortcuts in main.dart, which wraps this shell.
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              // 1. MAIN UI LAYER
              Column(
                children: [
                  const TopCommandBar(),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MouseRegion(
                          onExit: (_) => _megaMenuKey.currentState?.hideMenu(),
                          child: ZenoNavRail(
                            activeCategory: _activeNavCategory,
                            onHover: (cat, offset) => _megaMenuKey.currentState
                                ?.showMenu(cat, offset),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const ZenoQuickAccessToolbar(),
                              if (_isDashboardPage) const WorkspaceControlBar(),
                              Expanded(
                                child: Container(
                                  key: ValueKey(_navController.activeTab.id),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: KeyedSubtree(
                                    key: ValueKey(
                                        _navController.activeTab.route),
                                    child: ZenoRouter.getScreen(
                                      _navController.activeTab.route,
                                      params: _navController.activeTab.params,
                                    ),
                                  ),
                                ),
                              ),
                              const EnterpriseBottomStatusBar(),
                            ],
                          ),
                        ),
                        if (_navController.isSidePanelOpen)
                          const EnterpriseRightPanel(),
                      ],
                    ),
                  ),
                ],
              ),
              // 2. MEGA MENU LAYER
              ZenoMegaMenuOverlay(
                key: _megaMenuKey,
                onCategoryChanged: (cat) {
                  if (mounted) {
                    setState(() => _activeNavCategory = cat);
                  }
                },
              ),
              // 4. QUICK ACTIONS DOCK (Self-positioning)
              const ZenoQuickActionsDock(),
            ],
          ),
        );
      },
    );
  }
}
