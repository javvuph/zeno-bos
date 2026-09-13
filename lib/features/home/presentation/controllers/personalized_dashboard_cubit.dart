import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';
import 'package:zeno/core/services/permission_service.dart';
import 'package:zeno/core/services/settings_service.dart';
import 'package:zeno/core/di/service_locator.dart';

class DashboardState extends Equatable {
  final List<DashboardLayout> layouts;
  final String activeLayoutId;
  final bool isEditMode;
  final bool isOffline;
  final bool isMonitorOpen;

  const DashboardState({
    required this.layouts,
    required this.activeLayoutId,
    this.isEditMode = false,
    this.isOffline = false,
    this.isMonitorOpen = false,
  });

  DashboardLayout get activeLayout => layouts
      .firstWhere((l) => l.id == activeLayoutId, orElse: () => layouts.first);

  List<DashboardWidgetInstance> get authorizedWidgets {
    final permissions = PermissionService();
    return activeLayout.widgets
        .where((w) => permissions.canViewWidget(w.requiredPermissions))
        .toList();
  }

  DashboardState copyWith({
    List<DashboardLayout>? layouts,
    String? activeLayoutId,
    bool? isEditMode,
    bool? isOffline,
    bool? isMonitorOpen,
  }) {
    return DashboardState(
      layouts: layouts ?? this.layouts,
      activeLayoutId: activeLayoutId ?? this.activeLayoutId,
      isEditMode: isEditMode ?? this.isEditMode,
      isOffline: isOffline ?? this.isOffline,
      isMonitorOpen: isMonitorOpen ?? this.isMonitorOpen,
    );
  }

  @override
  List<Object?> get props =>
      [layouts, activeLayoutId, isEditMode, isOffline, isMonitorOpen];
}

class DashboardCubit extends Cubit<DashboardState> {
  final SettingsService _settings = sl<SettingsService>();
  Timer? _autoRefreshTimer;

  DashboardCubit() : super(_initialState()) {
    _loadPersistedLayout();
    _startAutoRefresh();
    _loadDashboardSequentially();
  }

  void _loadPersistedLayout() {
    final String? json = _settings.getCustomValue('user_dashboard_layout');
    if (json != null) {
      try {
        // Mock deserialization for now
      } catch (e) {
        // Fallback to initial
      }
    }
  }

  void _persistLayout() {
    // _settings.setCustomValue('user_dashboard_layout', jsonEncode(state.activeLayout));
  }

  void resetToDefault() {
    emit(_initialState());
    _persistLayout();
    _loadDashboardSequentially();
  }

  static DashboardState _initialState() {
    const defaultLayout = DashboardLayout(
      id: 'default_exec',
      name: 'Executive Dashboard',
      isDefault: true,
      widgets: [
        DashboardWidgetInstance(
          id: 'row1',
          widgetKey: 'exec_kpi_pulse',
          x: 0,
          y: 0,
          size: WidgetSize.wide, // Adjusted for height
          refreshInterval: 30,
          loadPriority: 0,
        ),
        DashboardWidgetInstance(
          id: 'row2',
          widgetKey: 'exec_analytical_core',
          x: 0,
          y: 1,
          size: WidgetSize.large,
          refreshInterval: 60,
          loadPriority: 1,
        ),
        DashboardWidgetInstance(
          id: 'row3',
          widgetKey: 'exec_performance_matrix',
          x: 0,
          y: 2,
          size: WidgetSize.large,
          refreshInterval: 120,
          loadPriority: 2,
        ),
      ],
    );

    return const DashboardState(
      layouts: [defaultLayout],
      activeLayoutId: 'default_exec',
    );
  }

  void _loadDashboardSequentially() async {
    final sortedWidgets =
        List<DashboardWidgetInstance>.from(state.activeLayout.widgets)
          ..sort((a, b) => a.loadPriority.compareTo(b.loadPriority));

    for (var widget in sortedWidgets) {
      refreshWidget(widget.id);
      await Future.delayed(
          const Duration(milliseconds: 500)); // Sequential visual effect
    }
  }

  void _startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      for (var widget in state.activeLayout.widgets) {
        // Only refresh if it has an interval, has been updated before, and IS NOT CURRENTLY LOADING
        if (widget.refreshInterval > 0 &&
            widget.lastUpdated != null &&
            widget.status != WidgetLoadStatus.loading) {
          final diff = now.difference(widget.lastUpdated!).inSeconds;
          if (diff >= widget.refreshInterval) {
            refreshWidget(widget.id);
          }
        }
      }
    });
  }

  Future<void> refreshWidget(String id) async {
    // Double check if already loading to prevent race conditions from timer
    final widget = state.activeLayout.widgets.firstWhere((w) => w.id == id);
    if (widget.status == WidgetLoadStatus.loading) return;

    final startTime = DateTime.now();
    _updateWidgetStatus(id, WidgetLoadStatus.loading);

    // Simulate real-world API latency
    await Future.delayed(const Duration(milliseconds: 500));

    final duration = DateTime.now().difference(startTime).inMilliseconds;
    _updateWidgetStatus(id,
        state.isOffline ? WidgetLoadStatus.offline : WidgetLoadStatus.success,
        updateTimestamp: true, duration: duration);
  }

  void _updateWidgetStatus(String id, WidgetLoadStatus status,
      {bool updateTimestamp = false, int duration = 0}) {
    final updatedLayout = state.activeLayout.copyWith(
      widgets: state.activeLayout.widgets.map((w) {
        if (w.id == id) {
          return w.copyWith(
            status: status,
            lastUpdated: updateTimestamp ? DateTime.now() : w.lastUpdated,
            loadDurationMs: duration > 0 ? duration : w.loadDurationMs,
          );
        }
        return w;
      }).toList(),
    );
    _updateActiveLayout(updatedLayout);
  }

  void toggleOffline() {
    emit(state.copyWith(isOffline: !state.isOffline));
    // Trigger refresh to show offline state
    for (var w in state.activeLayout.widgets) {
      _updateWidgetStatus(
          w.id,
          state.isOffline
              ? WidgetLoadStatus.offline
              : WidgetLoadStatus.success);
    }
  }

  void toggleMonitor() =>
      emit(state.copyWith(isMonitorOpen: !state.isMonitorOpen));

  void toggleEditMode() => emit(state.copyWith(isEditMode: !state.isEditMode));

  void addWidget(String widgetKey) {
    final newWidget = DashboardWidgetInstance(
      id: const Uuid().v4(),
      widgetKey: widgetKey,
      x: 0,
      y: 0, // In a real app, find the first available slot
      size: WidgetSize.medium,
    );

    final updatedLayout = state.activeLayout.copyWith(
      widgets: [...state.activeLayout.widgets, newWidget],
    );

    _updateActiveLayout(updatedLayout);
  }

  void removeWidget(String id) {
    final updatedLayout = state.activeLayout.copyWith(
      widgets: state.activeLayout.widgets.where((w) => w.id != id).toList(),
    );
    _updateActiveLayout(updatedLayout);
  }

  void moveWidget(String id, int x, int y) {
    final updatedLayout = state.activeLayout.copyWith(
      widgets: state.activeLayout.widgets.map((w) {
        if (w.id == id) {
          return w.copyWith(x: x, y: y);
        }
        return w;
      }).toList(),
    );
    _updateActiveLayout(updatedLayout);
  }

  void resizeWidget(String id, WidgetSize size) {
    final updatedLayout = state.activeLayout.copyWith(
      widgets: state.activeLayout.widgets.map((w) {
        if (w.id == id) {
          return w.copyWith(size: size);
        }
        return w;
      }).toList(),
    );
    _updateActiveLayout(updatedLayout);
  }

  void _updateActiveLayout(DashboardLayout layout) {
    final updatedLayouts = state.layouts.map((l) {
      if (l.id == state.activeLayoutId) return layout;
      return l;
    }).toList();

    emit(state.copyWith(layouts: updatedLayouts));
  }

  void switchLayout(String layoutId) {
    emit(state.copyWith(activeLayoutId: layoutId));
  }

  @override
  Future<void> close() {
    _autoRefreshTimer?.cancel();
    return super.close();
  }
}
