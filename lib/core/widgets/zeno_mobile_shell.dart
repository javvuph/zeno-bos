import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/zeno_router.dart';

/// ZENO mobile presentation layer.
/// Reuses the existing navigation, routes and business logic while giving
/// phones a dedicated futuristic command-center experience.
class ZenoMobileShell extends StatefulWidget {
  final NavigationController navigationController;

  const ZenoMobileShell({super.key, required this.navigationController});

  @override
  State<ZenoMobileShell> createState() => _ZenoMobileShellState();
}

class _ZenoMobileShellState extends State<ZenoMobileShell> {
  int _bottomIndex = 0;

  static const _bottomRoutes = ['dashboard', 'sales/pos', 'inventory/products', 'orders/dashboard'];
  static const _bottomLabels = ['Home', 'Billing', 'Inventory', 'Orders'];
  static const _bottomIcons = [
    Icons.grid_view_rounded,
    Icons.point_of_sale_rounded,
    Icons.inventory_2_rounded,
    Icons.shopping_bag_rounded,
  ];

  @override
  void initState() {
    super.initState();
    widget.navigationController.addListener(_onNavigationChanged);
    _syncBottomIndex();
  }

  @override
  void dispose() {
    widget.navigationController.removeListener(_onNavigationChanged);
    super.dispose();
  }

  void _onNavigationChanged() {
    if (!mounted) return;
    setState(_syncBottomIndex);
  }

  void _syncBottomIndex() {
    final route = widget.navigationController.currentRoute;
    final index = _bottomRoutes.indexWhere((item) {
      if (item == 'dashboard') return route == 'dashboard' || route == 'home';
      return route == item || route.startsWith('$item/');
    });
    if (index >= 0) _bottomIndex = index;
  }

  void _navigate(String route) => widget.navigationController.navigateTo(route);

  void _selectBottom(int index) => _navigate(_bottomRoutes[index]);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final route = widget.navigationController.currentRoute;
    final isHome = route == 'dashboard' || route == 'home';

    return Scaffold(
      backgroundColor: colors.bgTier1,
      drawer: _buildDrawer(context, colors),
      extendBody: true,
      appBar: _buildAppBar(context, colors, route),
      body: Stack(
        children: [
          const _AuroraBackground(),
          SafeArea(
            top: false,
            bottom: true,
            child: KeyedSubtree(
              key: ValueKey('$route-mobile'),
              child: isHome
                  ? _MobileCommandCenter(onRoute: _navigate)
                  : ZenoRouter.getScreen(
                      route,
                      params: widget.navigationController.activeTab.params,
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(colors),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ZenoSemanticColors colors,
    String route,
  ) {
    return AppBar(
      toolbarHeight: 68,
      elevation: 0,
      backgroundColor: colors.bgTier1.withValues(alpha: 0.92),
      surfaceTintColor: Colors.transparent,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            tooltip: 'Menu',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: colors.borderSubtle),
              ),
              child: Icon(Icons.menu_rounded, color: colors.textPrimary, size: 21),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      titleSpacing: 6,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: ZenoTheme.aiGlowGradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: colors.accentPrimary.withValues(alpha: 0.20),
                  blurRadius: 16,
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 19),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ZENO', style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 2.0,
                color: colors.textPrimary,
              )),
              Text(_routeTitle(route).toUpperCase(), style: TextStyle(
                fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.2,
                color: colors.textSecondary,
              )),
            ],
          ),
        ],
      ),
      actions: [
        _HeaderButton(icon: Icons.search_rounded, onTap: () => _openSearch(context), colors: colors),
        const SizedBox(width: 2),
        _HeaderButton(
          icon: Icons.notifications_none_rounded,
          onTap: () => widget.navigationController.toggleNotifications(),
          colors: colors,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildBottomBar(ZenoSemanticColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: colors.bgTier2.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.borderSubtle),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 28, offset: const Offset(0, 10)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_bottomLabels.length, (index) {
            final selected = _bottomIndex == index;
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _selectBottom(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: selected ? 44 : 34,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: selected ? ZenoTheme.aiGlowGradient : null,
                        color: selected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _bottomIcons[index],
                        size: 19,
                        color: selected ? Colors.black : colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _bottomLabels[index],
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                        color: selected ? colors.textPrimary : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, ZenoSemanticColors colors) {
    return Drawer(
      backgroundColor: colors.bgTier1,
      width: MediaQuery.of(context).size.width * 0.86,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.bgTier2, colors.bgTier1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(bottom: BorderSide(color: colors.borderSubtle)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(
                      gradient: ZenoTheme.aiGlowGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 23),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ZENO', style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w900,
                          letterSpacing: 2.2, color: colors.textPrimary,
                        )),
                        const SizedBox(height: 3),
                        Text('BUSINESS OPERATING SYSTEM', style: TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w800,
                          letterSpacing: 1.25, color: colors.accentPrimary,
                        )),
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
                itemBuilder: (context, index) => _MobileMenuGroup(
                  category: MenuRegistry.all[index],
                  currentRoute: widget.navigationController.currentRoute,
                  onRoute: _navigate,
                  colors: colors,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _ZenoMobileSearchDelegate(onSelect: _navigate),
    );
  }

  String _routeTitle(String route) {
    if (route == 'dashboard' || route == 'home') return 'Command Center';
    if (route.startsWith('sales/') || route.startsWith('billing/')) return 'Billing';
    if (route.startsWith('inventory/')) return 'Inventory';
    if (route.startsWith('orders/') || route.startsWith('procurement/')) return 'Orders';
    if (route.startsWith('customers/')) return 'Customers';
    if (route.startsWith('finance/')) return 'Finance';
    if (route.startsWith('staff/')) return 'Staff';
    if (route.startsWith('suppliers/')) return 'Suppliers';
    if (route.startsWith('ai/')) return 'AI Centre';
    return 'Workspace';
  }
}

class _MobileCommandCenter extends StatelessWidget {
  final ValueChanged<String> onRoute;
  const _MobileCommandCenter({required this.onRoute});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 104),
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Good morning,\nrun your business.', style: TextStyle(
                fontSize: 27, height: 1.05, fontWeight: FontWeight.w900,
                letterSpacing: -0.8, color: c.textPrimary,
              )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
              decoration: BoxDecoration(
                color: c.statusSuccess.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: c.statusSuccess.withValues(alpha: 0.24)),
              ),
              child: Row(children: [
                Container(width: 7, height: 7, decoration: BoxDecoration(
                  color: c.statusSuccess, shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: c.statusSuccess.withValues(alpha: 0.7), blurRadius: 7)],
                )),
                const SizedBox(width: 6),
                Text('LIVE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1, color: c.statusSuccess)),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _AiCommandCard(onTap: () => onRoute('ai')),
        const SizedBox(height: 14),
        _KpiStrip(),
        const SizedBox(height: 14),
        _InsightCard(onTap: () => onRoute('reports')),
        const SizedBox(height: 18),
        Row(children: [
          Expanded(child: _ActionCard(
            icon: Icons.point_of_sale_rounded, label: 'NEW BILL', sub: 'Checkout',
            accent: c.accentPrimary, onTap: () => onRoute('sales/pos'),
          )),
          const SizedBox(width: 10),
          Expanded(child: _ActionCard(
            icon: Icons.add_box_rounded, label: 'PRODUCT', sub: 'Add stock',
            accent: c.accentPurple, onTap: () => onRoute('inventory/products'),
          )),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: _ActionCard(
            icon: Icons.local_shipping_rounded, label: 'DELIVERY', sub: 'Track orders',
            accent: c.statusSuccess, onTap: () => onRoute('orders/dashboard'),
          )),
          const SizedBox(width: 10),
          Expanded(child: _ActionCard(
            icon: Icons.analytics_rounded, label: 'ANALYTICS', sub: 'Business view',
            accent: c.amberGold, onTap: () => onRoute('reports'),
          )),
        ]),
        const SizedBox(height: 20),
        Text('WORKSPACES', style: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.6, color: c.textSecondary,
        )),
        const SizedBox(height: 10),
        _WorkspaceTile(icon: Icons.inventory_2_rounded, title: 'Inventory Control', subtitle: 'Products • Stock • Suppliers', accent: c.accentPrimary, onTap: () => onRoute('inventory/products')),
        _WorkspaceTile(icon: Icons.groups_rounded, title: 'Customer Hub', subtitle: 'Customers • CRM • Loyalty', accent: c.accentPurple, onTap: () => onRoute('customers')),
        _WorkspaceTile(icon: Icons.auto_awesome_rounded, title: 'AI Command Center', subtitle: 'Insights • Automation • Copilot', accent: c.statusSuccess, onTap: () => onRoute('ai')),
        const SizedBox(height: 6),
        Text('ZENO OS • MOBILE', textAlign: TextAlign.center, style: TextStyle(
          fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 1.4, color: c.textDisabled,
        )),
      ],
    );
  }
}

class _AiCommandCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AiCommandCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF111A2B), Color(0xFF171225)],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: c.accentPrimary.withValues(alpha: 0.25)),
          boxShadow: [BoxShadow(color: c.accentPrimary.withValues(alpha: 0.07), blurRadius: 28)],
        ),
        child: Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              gradient: ZenoTheme.aiGlowGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ZENO AI COPILOT', style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: c.accentPrimary,
              )),
              const SizedBox(height: 5),
              Text('Ask ZENO anything about your business.', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: c.textPrimary,
              )),
              const SizedBox(height: 3),
              Text('Insights • Actions • Automation', style: TextStyle(fontSize: 10, color: c.textSecondary)),
            ],
          )),
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: c.textSecondary),
        ]),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final Color accent;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.label, required this.sub, required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.bgTier2.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: c.borderSubtle),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 22, color: accent),
          const SizedBox(height: 15),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.1, color: c.textPrimary)),
          const SizedBox(height: 3),
          Text(sub, style: TextStyle(fontSize: 9, color: c.textSecondary)),
        ]),
      ),
    );
  }
}

class _WorkspaceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;
  const _WorkspaceTile({required this.icon, required this.title, required this.subtitle, required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: c.bgTier2.withValues(alpha: 0.84),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: c.borderSubtle),
          ),
          child: Row(children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: accent.withValues(alpha: 0.22)),
              ),
              child: Icon(icon, size: 20, color: accent),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: c.textPrimary)),
                const SizedBox(height: 3),
                Text(subtitle, style: TextStyle(fontSize: 9, color: c.textSecondary)),
              ],
            )),
            Icon(Icons.chevron_right_rounded, size: 19, color: c.textSecondary),
          ]),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  const _HeaderButton({required this.icon, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Container(
      width: 38, height: 38,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Icon(icon, size: 19, color: colors.textPrimary),
    ),
  );
}

class _AuroraBackground extends StatelessWidget {
  const _AuroraBackground();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return IgnorePointer(
      child: Stack(children: [
        Positioned(top: -110, right: -90, child: _GlowOrb(color: c.accentPrimary, size: 250)),
        Positioned(top: 250, left: -150, child: _GlowOrb(color: c.accentPurple, size: 300)),
      ]),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [color.withValues(alpha: 0.10), Colors.transparent]),
    ),
  );
}

class _MobileMenuGroup extends StatelessWidget {
  final ZenoMenuCategory category;
  final String currentRoute;
  final ValueChanged<String> onRoute;
  final ZenoSemanticColors colors;

  const _MobileMenuGroup({required this.category, required this.currentRoute, required this.onRoute, required this.colors});

  @override
  Widget build(BuildContext context) {
    final items = category.columns.expand((column) => column.items).where((item) => item.route != null).toList();
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(category.icon, color: category.color, size: 20),
        title: Text(category.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: colors.textPrimary)),
        iconColor: colors.accentPrimary,
        collapsedIconColor: colors.textSecondary,
        tilePadding: const EdgeInsets.symmetric(horizontal: 18),
        childrenPadding: const EdgeInsets.only(left: 14, right: 10, bottom: 4),
        children: [
          for (final item in items)
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -1),
              leading: Icon(item.icon, size: 17, color: item.color ?? category.color),
              title: Text(item.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textPrimary)),
              trailing: currentRoute == item.route ? Icon(Icons.check_rounded, size: 16, color: colors.accentPrimary) : null,
              onTap: () {
                Navigator.of(context).pop();
                onRoute(item.route!);
              },
            ),
        ],
      ),
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
    if (query.isNotEmpty) IconButton(icon: const Icon(Icons.clear_rounded), onPressed: () => query = ''),
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
    final results = _items.where((item) => q.isEmpty || item.label.toLowerCase().contains(q)).take(30).toList();
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
