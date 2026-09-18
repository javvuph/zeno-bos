import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu/menu_models.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/zeno_router.dart';

/// Mobile presentation of the existing ZENO navigation.
/// It reuses the existing menu registry, routes and screens; no business
/// logic or data models are duplicated here.
class ZenoMobileShell extends StatefulWidget {
  final NavigationController navigationController;

  const ZenoMobileShell({
    super.key,
    required this.navigationController,
  });

  @override
  State<ZenoMobileShell> createState() => _ZenoMobileShellState();
}

class _ZenoMobileShellState extends State<ZenoMobileShell> {
  int _bottomIndex = 0;

  static const _bottomRoutes = <String>[
    'dashboard',
    'sales/pos',
    'inventory/products',
    'orders/dashboard',
  ];

  void _navigate(String route) {
    Navigator.of(context).maybePop();
    widget.navigationController.navigateTo(route);
  }

  void _selectBottom(int index) {
    setState(() => _bottomIndex = index);
    widget.navigationController.navigateTo(_bottomRoutes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final route = widget.navigationController.activeTab.route;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: _buildDrawer(context, colors),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.bgTier2,
        surfaceTintColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            tooltip: 'Menu',
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 0,
        title: _buildTitle(colors, route),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search_rounded),
            onPressed: () => _openSearch(context),
          ),
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        top: false,
        child: KeyedSubtree(
          key: ValueKey('\${widget.navigationController.activeTab.route}-mobile'),
          child: ZenoRouter.getScreen(
            widget.navigationController.activeTab.route,
            params: widget.navigationController.activeTab.params,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, colors),
    );
  }

  Widget _buildTitle(ZenoSemanticColors colors, String route) {
    final label = _routeTitle(route);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ZENO',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
            color: colors.accentPrimary,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context, ZenoSemanticColors colors) {
    return Drawer(
      backgroundColor: colors.bgTier1,
      width: MediaQuery.of(context).size.width * 0.84,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
              decoration: BoxDecoration(
                color: colors.bgTier2,
                border: Border(
                  bottom: BorderSide(color: colors.borderSubtle),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: colors.accentPrimary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colors.accentPrimary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: colors.accentPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ZENO BUSINESS OPERATING SYSTEM',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'MENU',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.4,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: MenuRegistry.all.length,
                itemBuilder: (context, index) {
                  return _MobileMenuGroup(
                    category: MenuRegistry.all[index],
                    currentRoute: widget.navigationController.currentRoute,
                    onRoute: _navigate,
                    colors: colors,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ZenoSemanticColors colors) {
    const labels = ['Home', 'Billing', 'Inventory', 'Orders'];
    const icons = [
      Icons.dashboard_rounded,
      Icons.point_of_sale_rounded,
      Icons.inventory_2_rounded,
      Icons.shopping_bag_rounded,
    ];

    return NavigationBar(
      selectedIndex: _bottomIndex,
      onDestinationSelected: _selectBottom,
      backgroundColor: colors.bgTier2,
      indicatorColor: colors.accentPrimary.withValues(alpha: 0.14),
      height: 66,
      destinations: List.generate(
        labels.length,
        (index) => NavigationDestination(
          icon: Icon(icons[index]),
          selectedIcon: Icon(icons[index]),
          label: labels[index],
        ),
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _ZenoMobileSearchDelegate(
        onSelect: _navigate,
      ),
    );
  }

  String _routeTitle(String route) {
    if (route == 'dashboard' || route == 'home') return 'Dashboard';
    if (route.startsWith('sales/')) return 'Billing';
    if (route.startsWith('inventory/')) return 'Inventory';
    if (route.startsWith('orders/')) return 'Orders';
    if (route.startsWith('customers/')) return 'Customers';
    if (route.startsWith('finance/')) return 'Finance';
    if (route.startsWith('staff/')) return 'Staff';
    if (route.startsWith('suppliers/')) return 'Suppliers';
    if (route.startsWith('ai/')) return 'AI Centre';
    return 'Workspace';
  }
}

class _MobileMenuGroup extends StatelessWidget {
  final ZenoMenuCategory category;
  final String currentRoute;
  final ValueChanged<String> onRoute;
  final ZenoSemanticColors colors;

  const _MobileMenuGroup({
    required this.category,
    required this.currentRoute,
    required this.onRoute,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final items = category.columns.expand((column) => column.items).toList();
    final hasItems = items.isNotEmpty;

    return ExpansionTile(
      leading: Icon(category.icon, color: category.color, size: 20),
      title: Text(
        category.label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: colors.textPrimary,
        ),
      ),
      iconColor: colors.accentPrimary,
      collapsedIconColor: colors.textSecondary,
      tilePadding: const EdgeInsets.symmetric(horizontal: 18),
      childrenPadding: const EdgeInsets.only(left: 14, right: 10, bottom: 4),
      children: hasItems
          ? items
              .where((item) => item.route != null)
              .map(
                (item) => ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -1),
                  leading: Icon(
                    item.icon,
                    size: 17,
                    color: item.color ?? category.color,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  trailing: currentRoute == item.route
                      ? Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: colors.accentPrimary,
                        )
                      : null,
                  onTap: () => onRoute(item.route!),
                ),
              )
              .toList()
          : const [],
    );
  }
}

class _ZenoMobileSearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onSelect;

  _ZenoMobileSearchDelegate({required this.onSelect});

  List<ZenoMenuItem> get _items => MenuRegistry.all
      .expand((category) => category.columns)
      .expand((column) => column.items)
      .where((item) => item.route != null)
      .toList();

  @override
  List<Widget>? buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () => query = '',
          ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) => _results(context);

  @override
  Widget buildSuggestions(BuildContext context) => _results(context);

  Widget _results(BuildContext context) {
    final q = query.trim().toLowerCase();
    final results = _items
        .where((item) => q.isEmpty || item.label.toLowerCase().contains(q))
        .take(30)
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Icon(item.icon),
          title: Text(item.label),
          onTap: () {
            close(context, item.route!);
            onSelect(item.route!);
          },
        );
      },
    );
  }
}
