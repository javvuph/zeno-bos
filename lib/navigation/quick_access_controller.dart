import 'package:flutter/material.dart';
import 'package:zeno/navigation/menu_registry.dart';

class QuickAccessItem {
  final String label;
  final IconData icon;
  final String route;
  final bool isAI;
  final Color? color;

  const QuickAccessItem({
    required this.label,
    required this.icon,
    required this.route,
    this.isAI = false,
    this.color,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'icon': icon.codePoint,
        'route': route,
        'isAI': isAI,
        'color': color?.toARGB32(),
      };

  factory QuickAccessItem.fromJson(Map<String, dynamic> json) =>
      QuickAccessItem(
        label: json['label'],
        // ignore: non_const_argument_for_const_parameter
        icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
        route: json['route'],
        isAI: json['isAI'] ?? false,
        color: json['color'] != null ? Color(json['color']) : null,
      );
}

class QuickAccessController extends ChangeNotifier {
  static final QuickAccessController _instance =
      QuickAccessController._internal();
  factory QuickAccessController() => _instance;
  QuickAccessController._internal() {
    _loadDefaults();
  }

  static const int maxItems = 12;

  final List<QuickAccessItem> _items = [];
  List<QuickAccessItem> get items => List.unmodifiable(_items);

  void _loadDefaults() {
    // Fixed defaults are now hardcoded in the QuickAccessWorkspace template.
    // Dynamic items are managed by the user.
  }

  bool addItem(ZenoMenuItem menuItem) {
    if (_items.any((item) => item.route == menuItem.route)) {
      return true; // Already exists
    }
    if (_items.length >= maxItems) return false; // Limit reached

    _items.add(QuickAccessItem(
      label: menuItem.label,
      icon: menuItem.icon,
      route: menuItem.route!,
      isAI: menuItem.isAI,
      color: menuItem.color,
    ));
    notifyListeners();
    return true;
  }

  void removeItem(String route) {
    _items.removeWhere((item) => item.route == route);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    notifyListeners();
  }

  List<ZenoMenuItem> search(String query) {
    if (query.isEmpty) return [];
    final results = <ZenoMenuItem>[];
    query = query.toLowerCase();

    for (var category in MenuRegistry.all) {
      for (var column in category.columns) {
        for (var item in column.items) {
          if (item.route == null) continue;
          if (item.label.toLowerCase().contains(query) ||
              (item.description?.toLowerCase().contains(query) ?? false)) {
            results.add(item);
          }
        }
      }
    }
    return results;
  }
}
