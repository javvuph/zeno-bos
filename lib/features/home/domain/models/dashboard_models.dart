import 'package:equatable/equatable.dart';

enum WidgetSize {
  small, // 3 cols, 150h
  medium, // 6 cols, 300h
  large, // 12 cols, 400h
  wide, // 12 cols, 200h
  full, // 12 cols, 600h
}

enum WidgetLoadStatus {
  idle,
  loading,
  success,
  error,
  offline,
}

class DashboardWidgetInstance extends Equatable {
  final String id;
  final String widgetKey;
  final int x; // 0-11
  final int y;
  final WidgetSize size;
  final String? title;

  // Performance & Real-time
  final int refreshInterval; // in seconds, 0 = manual only
  final DateTime? lastUpdated;
  final int loadDurationMs;
  final int loadPriority; // 0 = highest, loaded first
  final WidgetLoadStatus status;

  // Security
  final List<String> requiredPermissions;

  const DashboardWidgetInstance({
    required this.id,
    required this.widgetKey,
    required this.x,
    required this.y,
    required this.size,
    this.title,
    this.refreshInterval = 0,
    this.lastUpdated,
    this.loadDurationMs = 0,
    this.loadPriority = 10,
    this.status = WidgetLoadStatus.idle,
    this.requiredPermissions = const [],
  });

  DashboardWidgetInstance copyWith({
    String? id,
    String? widgetKey,
    int? x,
    int? y,
    WidgetSize? size,
    String? title,
    int? refreshInterval,
    DateTime? lastUpdated,
    int? loadDurationMs,
    int? loadPriority,
    WidgetLoadStatus? status,
    List<String>? requiredPermissions,
  }) {
    return DashboardWidgetInstance(
      id: id ?? this.id,
      widgetKey: widgetKey ?? this.widgetKey,
      x: x ?? this.x,
      y: y ?? this.y,
      size: size ?? this.size,
      title: title ?? this.title,
      refreshInterval: refreshInterval ?? this.refreshInterval,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      loadDurationMs: loadDurationMs ?? this.loadDurationMs,
      loadPriority: loadPriority ?? this.loadPriority,
      status: status ?? this.status,
      requiredPermissions: requiredPermissions ?? this.requiredPermissions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        widgetKey,
        x,
        y,
        size,
        title,
        refreshInterval,
        lastUpdated,
        loadDurationMs,
        loadPriority,
        status,
        requiredPermissions
      ];
}

class DashboardLayout extends Equatable {
  final String id;
  final String name;
  final List<DashboardWidgetInstance> widgets;
  final bool isDefault;

  const DashboardLayout({
    required this.id,
    required this.name,
    required this.widgets,
    this.isDefault = false,
  });

  DashboardLayout copyWith({
    String? id,
    String? name,
    List<DashboardWidgetInstance>? widgets,
    bool? isDefault,
  }) {
    return DashboardLayout(
      id: id ?? this.id,
      name: name ?? this.name,
      widgets: widgets ?? this.widgets,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [id, name, widgets, isDefault];
}
