import 'package:flutter/material.dart';

class ZenoTab {
  final String id;
  final String title;
  final IconData icon;
  final String route;
  final Map<String, dynamic> params;
  final Map<String, dynamic> filterState;
  final bool isPinned;
  final String? recordId;

  const ZenoTab({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    this.params = const {},
    this.filterState = const {},
    this.isPinned = false,
    this.recordId,
  });

  ZenoTab copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? route,
    Map<String, dynamic>? params,
    Map<String, dynamic>? filterState,
    bool? isPinned,
    String? recordId,
  }) {
    return ZenoTab(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      params: params ?? this.params,
      filterState: filterState ?? this.filterState,
      isPinned: isPinned ?? this.isPinned,
      recordId: recordId ?? this.recordId,
    );
  }
}

class BreadcrumbItem {
  final String label;
  final String? route;
  final IconData? icon;

  const BreadcrumbItem({
    required this.label,
    this.route,
    this.icon,
  });
}

class FavouriteRecord {
  final String id;
  final String title;
  final String route;
  final IconData icon;
  final DateTime addedAt;

  const FavouriteRecord({
    required this.id,
    required this.title,
    required this.route,
    required this.icon,
    required this.addedAt,
  });
}

class RecentRecord {
  final String id;
  final String title;
  final String route;
  final IconData icon;
  final DateTime viewedAt;

  const RecentRecord({
    required this.id,
    required this.title,
    required this.route,
    required this.icon,
    required this.viewedAt,
  });
}

enum NotificationCategory {
  business,
  finance,
  inventory,
  delivery,
  hr,
  ai,
  system,
}

class ZenoNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationCategory category;
  final bool isRead;
  final bool isPinned;
  final String? actionRoute;

  const ZenoNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.category,
    this.isRead = false,
    this.isPinned = false,
    this.actionRoute,
  });

  ZenoNotification copyWith({
    bool? isRead,
    bool? isPinned,
  }) {
    return ZenoNotification(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      category: category,
      isRead: isRead ?? this.isRead,
      isPinned: isPinned ?? this.isPinned,
      actionRoute: actionRoute,
    );
  }
}

class LicenseStatus {
  final String type;
  final DateTime expiryDate;
  final bool isActive;
  final int userLimit;
  final int activeUsers;

  const LicenseStatus({
    required this.type,
    required this.expiryDate,
    required this.isActive,
    required this.userLimit,
    required this.activeUsers,
  });
}

enum SearchResultType {
  record,
  module,
  action,
  aiInsight,
}

class ZenoSearchResult {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final SearchResultType type;
  final Color? color;

  const ZenoSearchResult({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.type,
    this.color,
  });
}
