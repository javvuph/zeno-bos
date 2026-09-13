import 'package:flutter/material.dart';

enum ToolbarState { expanded, compact }

class ZenoToolbarController extends ChangeNotifier {
  static final ZenoToolbarController _instance = ZenoToolbarController._internal();
  factory ZenoToolbarController() => _instance;
  ZenoToolbarController._internal();

  ToolbarState _state = ToolbarState.expanded;
  bool _isPinned = false;

  ToolbarState get state => _state;
  bool get isPinned => _isPinned;

  void toggleState() {
    if (_isPinned) return;
    _state = _state == ToolbarState.expanded ? ToolbarState.compact : ToolbarState.expanded;
    notifyListeners();
  }

  void togglePin() {
    _isPinned = !_isPinned;
    if (_isPinned) _state = ToolbarState.expanded;
    notifyListeners();
  }
}
