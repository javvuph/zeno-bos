import 'package:flutter/material.dart';

/// ZenoWorkspacePreferences v1.0
/// Service to persist UI states and user preferences across ZENO BOS sessions.
class ZenoWorkspacePreferences extends ChangeNotifier {
  static final ZenoWorkspacePreferences _instance =
      ZenoWorkspacePreferences._internal();
  factory ZenoWorkspacePreferences() => _instance;
  ZenoWorkspacePreferences._internal();

  final Map<String, double> _inspectorWidths = {};
  final Map<String, List<String>> _hiddenColumns = {};
  final Map<String, int> _lastActiveTabs = {};

  double getInspectorWidth(String workspaceId) =>
      _inspectorWidths[workspaceId] ?? 380.0;
  List<String> getHiddenColumns(String workspaceId) =>
      _hiddenColumns[workspaceId] ?? [];
  int getLastActiveTab(String workspaceId) => _lastActiveTabs[workspaceId] ?? 0;

  void setInspectorWidth(String workspaceId, double width) {
    _inspectorWidths[workspaceId] = width;
    notifyListeners();
  }

  void toggleColumnVisibility(String workspaceId, String columnKey) {
    final list = _hiddenColumns[workspaceId] ?? [];
    if (list.contains(columnKey)) {
      list.remove(columnKey);
    } else {
      list.add(columnKey);
    }
    _hiddenColumns[workspaceId] = list;
    notifyListeners();
  }

  void setLastActiveTab(String workspaceId, int index) {
    _lastActiveTabs[workspaceId] = index;
    notifyListeners();
  }
}
