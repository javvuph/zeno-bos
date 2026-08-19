import 'package:flutter/material.dart';
import 'package:zeno/core/models/zeno_window_models.dart';

class ZenoWindowController extends ChangeNotifier {
  static final ZenoWindowController _instance =
      ZenoWindowController._internal();
  factory ZenoWindowController() => _instance;
  ZenoWindowController._internal();

  final List<ZenoWindow> _windows = [];
  int _nextZIndex = 1;

  List<ZenoWindow> get windows => List.unmodifiable(_windows);
  List<ZenoWindow> get activeWindows =>
      _windows.where((w) => w.status != ZenoWindowStatus.closed).toList()
        ..sort((a, b) => a.zIndex.compareTo(b.zIndex));

  List<ZenoWindow> get minimizedWindows =>
      _windows.where((w) => w.status == ZenoWindowStatus.minimized).toList();

  bool get hasActiveWindows =>
      _windows.any((w) => w.status == ZenoWindowStatus.open);

  void openWindow({
    required String id,
    required String title,
    required Widget content,
    required IconData icon,
    Size size = const Size(880, 600),
    Offset? position,
    String? updateRoute, // New parameter to signal tab change
  }) {
    debugPrint("Opening Window: $id ($title)");

    // CALCULATE CENTER POSITION IF NULL
    Offset finalPosition = position ?? const Offset(100, 100);
    if (position == null) {
      try {
        final view = WidgetsBinding.instance.platformDispatcher.views.first;
        final screenSize = view.physicalSize / view.devicePixelRatio;

        // Define the visible boundaries (excluding Top/Bottom system bars)
        const double topBoundary = 48.0 + 48.0; // Command Bar + Nav Bar
        const double bottomBoundary = 28.0; // Status Bar

        final double usableHeight =
            screenSize.height - topBoundary - bottomBoundary;
        final double usableWidth = screenSize.width;

        // Auto-scale window if it exceeds screen dimensions
        Size finalSize = size;
        if (finalSize.height > usableHeight - 40) {
          finalSize = Size(finalSize.width, usableHeight - 40);
        }
        if (finalSize.width > usableWidth - 40) {
          finalSize = Size(usableWidth - 40, finalSize.height);
        }

        finalPosition = Offset(
          (usableWidth - finalSize.width) / 2,
          topBoundary + (usableHeight - finalSize.height) / 2,
        );

        // Final safety clamp: Ensure header is ALWAYS visible and below system bars
        if (finalPosition.dy < topBoundary) {
          finalPosition = Offset(finalPosition.dx, topBoundary + 20);
        }
      } catch (e) {
        finalPosition = const Offset(100, 150);
      }
    }

    final existingIndex = _windows.indexWhere((w) => w.id == id);
    if (existingIndex != -1) {
      debugPrint("Window $id already exists, focusing...");

      // If it's a tabbed window, we might need to refresh it with a new initial route
      if (updateRoute != null) {
        _windows[existingIndex] = _windows[existingIndex].copyWith(
          content:
              content, // Replace with new content instance carrying the new route
          zIndex: _nextZIndex++,
          status: ZenoWindowStatus.open,
        );
      } else {
        if (_windows[existingIndex].status == ZenoWindowStatus.minimized) {
          restoreWindow(id);
        } else {
          focusWindow(id);
        }
      }
      notifyListeners();
      return;
    }

    final newWindow = ZenoWindow(
      id: id,
      title: title,
      content: content,
      icon: icon,
      size: size,
      position: finalPosition,
      zIndex: _nextZIndex++,
    );
    _windows.add(newWindow);
    notifyListeners();
  }

  void focusWindow(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1 && _windows[index].zIndex < _nextZIndex - 1) {
      _windows[index] = _windows[index].copyWith(zIndex: _nextZIndex++);
      notifyListeners();
    }
  }

  void minimizeWindow(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index] =
          _windows[index].copyWith(status: ZenoWindowStatus.minimized);
      notifyListeners();
    }
  }

  void restoreWindow(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index] = _windows[index]
          .copyWith(status: ZenoWindowStatus.open, zIndex: _nextZIndex++);
      notifyListeners();
    }
  }

  void toggleMaximize(String id) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index] =
          _windows[index].copyWith(isMaximized: !_windows[index].isMaximized);
      notifyListeners();
    }
  }

  void closeWindow(String id) {
    _windows.removeWhere((w) => w.id == id);
    notifyListeners();
  }

  void updatePosition(String id, Offset newPosition) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index] = _windows[index].copyWith(position: newPosition);
      notifyListeners();
    }
  }

  void updateSize(String id, Size newSize) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index] = _windows[index].copyWith(size: newSize);
      notifyListeners();
    }
  }

  void resizeWindow(
    String id, {
    required Offset delta,
    bool top = false,
    bool left = false,
    bool right = false,
    bool bottom = false,
    Size minSize = const Size(400, 300),
  }) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index == -1) return;

    final window = _windows[index];
    double newX = window.position.dx;
    double newY = window.position.dy;
    double newWidth = window.size.width;
    double newHeight = window.size.height;

    // Handle Horizontal
    if (left) {
      final potentialWidth = window.size.width - delta.dx;
      if (potentialWidth >= minSize.width) {
        newX = window.position.dx + delta.dx;
        newWidth = potentialWidth;
      }
    } else if (right) {
      newWidth =
          (window.size.width + delta.dx).clamp(minSize.width, double.infinity);
    }

    // Handle Vertical
    if (top) {
      final potentialHeight = window.size.height - delta.dy;
      if (potentialHeight >= minSize.height) {
        newY = window.position.dy + delta.dy;
        newHeight = potentialHeight;
      }
    } else if (bottom) {
      newHeight = (window.size.height + delta.dy)
          .clamp(minSize.height, double.infinity);
    }

    _windows[index] = window.copyWith(
      position: Offset(newX, newY),
      size: Size(newWidth, newHeight),
      isDragging: true, // Reuse isDragging to disable animation during resize
    );
    notifyListeners();
  }

  void setDragging(String id, bool dragging) {
    final index = _windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _windows[index] = _windows[index].copyWith(isDragging: dragging);
      notifyListeners();
    }
  }
}
