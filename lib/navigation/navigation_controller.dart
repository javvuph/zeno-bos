import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zeno/navigation/navigation_models.dart';
import 'package:zeno/navigation/menu_registry.dart';

class NavigationController extends ChangeNotifier {
  static final NavigationController _instance =
      NavigationController._internal();
  factory NavigationController() => _instance;
  NavigationController._internal() {
    final dashboardTab = ZenoTab(
      id: 'default_dashboard',
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      route: 'dashboard',
    );
    _tabs.add(dashboardTab);
    _activeTabId = dashboardTab.id;
    _activeHubId = 'home';
  }

  final List<ZenoTab> _tabs = [];
  final List<ZenoTab> _closedTabsStack = [];
  String _activeTabId = '';
  String _activeHubId = 'home';
  bool _isSidePanelOpen = false;
  bool _isSearchOpen = false;
  bool _isNotificationsOpen = false;
  bool _isCreateMenuOpen = false;
  bool _isSidebarCollapsed = false;

  final List<ZenoNotification> _notifications = [];
  final LicenseStatus _license = LicenseStatus(
    type: "ENTERPRISE ELITE",
    expiryDate: DateTime(2027, 12, 31),
    isActive: true,
    userLimit: 500,
    activeUsers: 34,
  );

  final List<FavouriteRecord> _favourites = [];
  final List<RecentRecord> _recentlyViewed = [];

  List<ZenoTab> get tabs => List.unmodifiable(_tabs);
  String get activeTabId => _activeTabId;
  ZenoTab get activeTab =>
      _tabs.firstWhere((t) => t.id == _activeTabId, orElse: () => _tabs.first);
  String get currentRoute => activeTab.route;
  String get activeHubId => _activeHubId;
  ZenoMenuCategory get activeHub =>
      MenuRegistry.all.firstWhere((h) => h.id == _activeHubId,
          orElse: () => MenuRegistry.all.first);
  bool get isSidePanelOpen => _isSidePanelOpen;
  bool get isSearchOpen => _isSearchOpen;
  bool get isNotificationsOpen => _isNotificationsOpen;
  bool get isCreateMenuOpen => _isCreateMenuOpen;
  bool get isSidebarCollapsed => _isSidebarCollapsed;
  LicenseStatus get license => _license;
  List<ZenoNotification> get notifications => List.unmodifiable(_notifications);

  List<FavouriteRecord> get favourites => List.unmodifiable(_favourites);
  List<RecentRecord> get recentlyViewed => List.unmodifiable(_recentlyViewed);

  void openTab(String route,
      {String? title,
      IconData? icon,
      Map<String, dynamic>? params,
      String? recordId}) {
    final newTab = ZenoTab(
      id: const Uuid().v4(),
      title: title ?? _getLabelFromRoute(route),
      icon: icon ?? _getIconFromRoute(route),
      route: route,
      params: params ?? {},
      filterState: activeTab.filterState, // Preserving filters
      recordId: recordId,
    );

    _tabs.add(newTab);
    _activeTabId = newTab.id;

    if (recordId != null) {
      _addToRecent(newTab);
    }

    notifyListeners();
  }

  void switchTab(String id) {
    if (_activeTabId == id) return;
    _activeTabId = id;
    notifyListeners();
  }

  void closeTab(String id) {
    if (_tabs.length <= 1) return;
    final index = _tabs.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final closedTab = _tabs.removeAt(index);
    _closedTabsStack.add(closedTab);
    if (_closedTabsStack.length > 10) _closedTabsStack.removeAt(0);

    if (_activeTabId == id) {
      _activeTabId = _tabs[index > 0 ? index - 1 : 0].id;
    }
    notifyListeners();
  }

  void restoreClosedTab() {
    if (_closedTabsStack.isNotEmpty) {
      final tab = _closedTabsStack.removeLast();
      _tabs.add(tab);
      _activeTabId = tab.id;
      notifyListeners();
    }
  }

  void closeOthers(String id) {
    _tabs.removeWhere((t) => t.id != id && !t.isPinned);
    _activeTabId = id;
    notifyListeners();
  }

  void closeAll() {
    _tabs.removeWhere((t) => !t.isPinned);
    if (_tabs.isEmpty) {
      openTab('dashboard');
    } else {
      _activeTabId = _tabs.first.id;
    }
    notifyListeners();
  }

  void togglePin(String id) {
    final index = _tabs.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tabs[index] = _tabs[index].copyWith(isPinned: !_tabs[index].isPinned);
      notifyListeners();
    }
  }

  void duplicateTab(String id) {
    final original = _tabs.firstWhere((t) => t.id == id);
    final copy = original.copyWith(
        id: const Uuid().v4(), title: "${original.title} (Copy)");
    _tabs.add(copy);
    _activeTabId = copy.id;
    notifyListeners();
  }

  void setActiveHub(String hubId) {
    if (_activeHubId == hubId) return;
    _activeHubId = hubId;
    notifyListeners();
  }

  void toggleSidebar() {
    _isSidebarCollapsed = !_isSidebarCollapsed;
    notifyListeners();
  }

  void toggleSidePanel() {
    _isSidePanelOpen = !_isSidePanelOpen;
    notifyListeners();
  }

  void toggleSearch() {
    _isSearchOpen = !_isSearchOpen;
    if (_isSearchOpen) {
      _isNotificationsOpen = false;
      _isCreateMenuOpen = false;
    }
    notifyListeners();
  }

  void toggleNotifications() {
    _isNotificationsOpen = !_isNotificationsOpen;
    if (_isNotificationsOpen) {
      _isSearchOpen = false;
      _isCreateMenuOpen = false;
    }
    notifyListeners();
  }

  void toggleCreateMenu() {
    _isCreateMenuOpen = !_isCreateMenuOpen;
    if (_isCreateMenuOpen) {
      _isSearchOpen = false;
      _isNotificationsOpen = false;
    }
    notifyListeners();
  }

  void navigateTo(String route,
      {Map<String, dynamic>? params, String? recordId}) {
    debugPrint("Navigating to: $route with params: $params");

    final index = _tabs.indexWhere((t) => t.id == _activeTabId);
    if (index != -1) {
      _tabs[index] = _tabs[index].copyWith(
        route: route,
        title: _getLabelFromRoute(route),
        icon: _getIconFromRoute(route),
        params: params ?? {},
        recordId: recordId,
      );

      if (recordId != null) {
        _addToRecent(_tabs[index]);
      }

      notifyListeners();
    }
  }

  void addToFavourites(String id, String title, String route, IconData icon) {
    if (!_favourites.any((f) => f.id == id)) {
      _favourites.add(FavouriteRecord(
          id: id,
          title: title,
          route: route,
          icon: icon,
          addedAt: DateTime.now()));
      notifyListeners();
    }
  }

  void _addToRecent(ZenoTab tab) {
    _recentlyViewed.removeWhere((r) => r.id == tab.recordId);
    _recentlyViewed.insert(
        0,
        RecentRecord(
          id: tab.recordId!,
          title: tab.title,
          route: tab.route,
          icon: tab.icon,
          viewedAt: DateTime.now(),
        ));
    if (_recentlyViewed.length > 50) _recentlyViewed.removeLast();
  }

  String _getLabelFromRoute(String route) {
    if (route == 'dashboard') return 'Dashboard';
    final parts = route.split('/');
    return parts.last.replaceAll('_', ' ').toUpperCase();
  }

  IconData _getIconFromRoute(String route) {
    if (route.contains('sales')) return Icons.analytics_outlined;
    if (route.contains('inventory')) return Icons.inventory_2_outlined;
    if (route.contains('customer')) return Icons.people_outline;
    if (route.contains('ai')) return Icons.auto_awesome;
    return Icons.layers_outlined;
  }

  List<BreadcrumbItem> getBreadcrumbs() {
    final List<BreadcrumbItem> items = [
      const BreadcrumbItem(
          label: 'HOME', route: 'dashboard', icon: Icons.home_outlined),
    ];

    final parts = currentRoute.split('/');
    String currentPath = '';

    for (var i = 0; i < parts.length; i++) {
      if (parts[i] == 'dashboard' && i == 0) continue;
      currentPath += (i == 0 ? '' : '/') + parts[i];
      items.add(BreadcrumbItem(
        label: parts[i].replaceAll('_', ' ').toUpperCase(),
        route: currentPath,
      ));
    }

    return items;
  }

  List<ZenoSearchResult> search(String query) {
    if (query.isEmpty) return [];

    // Mock enterprise search results
    final List<ZenoSearchResult> results = [];
    final q = query.toLowerCase();

    if ("sales invoice".contains(q) || "inv".contains(q)) {
      results.add(ZenoSearchResult(
          title: "INV-2026-00125",
          subtitle: "Sales Invoice - Global Corp",
          icon: Icons.receipt_long,
          route: "billing/invoices/details",
          type: SearchResultType.record));
      results.add(ZenoSearchResult(
          title: "INV-2026-00128",
          subtitle: "Sales Invoice - Tech Solutions",
          icon: Icons.receipt_long,
          route: "billing/invoices/details",
          type: SearchResultType.record));
    }

    if ("customer".contains(q)) {
      results.add(ZenoSearchResult(
          title: "Apple Inc.",
          subtitle: "Premium Tier Customer",
          icon: Icons.person,
          route: "customers/mgmt/profile",
          type: SearchResultType.record));
    }

    if ("inventory".contains(q) || "stock".contains(q)) {
      results.add(ZenoSearchResult(
          title: "Stock Movement Report",
          subtitle: "Inventory Analytics",
          icon: Icons.bar_chart,
          route: "inventory/reports/movement",
          type: SearchResultType.module));
    }

    results.add(ZenoSearchResult(
        title: "Create New Invoice",
        subtitle: "Quick Action",
        icon: Icons.add_shopping_cart,
        route: "billing/sales/new",
        type: SearchResultType.action,
        color: Colors.orange));

    return results;
  }
}
