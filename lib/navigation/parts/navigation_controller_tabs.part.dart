part of '../navigation_controller.dart';

extension NavigationControllerTabsPart on NavigationController {
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
      filterState: activeTab.filterState,
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
}
