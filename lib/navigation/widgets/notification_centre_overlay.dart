import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/navigation_models.dart';

class ZenoNotificationCentreOverlay extends StatefulWidget {
  const ZenoNotificationCentreOverlay({super.key});

  @override
  State<ZenoNotificationCentreOverlay> createState() =>
      _ZenoNotificationCentreOverlayState();
}

class _ZenoNotificationCentreOverlayState
    extends State<ZenoNotificationCentreOverlay> {
  NotificationCategory? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      child: Stack(
        children: [
          GestureDetector(onTap: nav.toggleNotifications),
          Positioned(
            top: 60,
            right: 150,
            child: Container(
              width: 450,
              height: 600,
              decoration: BoxDecoration(
                color: ZenoTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ZenoTheme.border),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 40)
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(nav),
                  _buildFilterTabs(),
                  const Divider(height: 1, color: ZenoTheme.border),
                  Expanded(child: _buildNotificationList(nav)),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(NavigationController nav) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(Icons.notifications_active_outlined,
              size: 18, color: ZenoTheme.accent),
          const SizedBox(width: 12),
          const Text("BUSINESS ALERTS",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5)),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text("MARK ALL READ",
                style: TextStyle(
                    fontSize: 10,
                    color: ZenoTheme.accent,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _filterChip("ALL", null),
          _filterChip("FINANCE", NotificationCategory.finance),
          _filterChip("INVENTORY", NotificationCategory.inventory),
          _filterChip("AI", NotificationCategory.ai),
          _filterChip("SYSTEM", NotificationCategory.system),
        ],
      ),
    );
  }

  Widget _filterChip(String label, NotificationCategory? category) {
    final isSelected = selectedFilter == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : ZenoTheme.textSecondary)),
        selected: isSelected,
        onSelected: (v) => setState(() => selectedFilter = category),
        backgroundColor: Colors.transparent,
        selectedColor: ZenoTheme.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side:
            BorderSide(color: isSelected ? ZenoTheme.accent : ZenoTheme.border),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildNotificationList(NavigationController nav) {
    // Mock Notifications for demo
    final List<ZenoNotification> mockNotifications = [
      ZenoNotification(
          id: "1",
          title: "Low Stock Alert",
          message: "iPhone 15 Pro is below safety level (4 units remaining).",
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          category: NotificationCategory.inventory,
          actionRoute: "inventory/stock/current"),
      ZenoNotification(
          id: "2",
          title: "Payment Received",
          message: "Global Corp settled invoice INV-2026-00125 (\$12,400).",
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          category: NotificationCategory.finance),
      ZenoNotification(
          id: "3",
          title: "AI Strategy Insight",
          message:
              "Demand forecast suggests 18% increase in weekend retail traffic.",
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          category: NotificationCategory.ai,
          actionRoute: "ai/business/insights"),
      ZenoNotification(
          id: "4",
          title: "System Maintenance",
          message: "Cloud sync will be paused for 15 mins at 02:00 UTC.",
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          category: NotificationCategory.system),
    ];

    final filtered = selectedFilter == null
        ? mockNotifications
        : mockNotifications.where((n) => n.category == selectedFilter).toList();

    if (filtered.isEmpty) {
      return const Center(
          child: Text("No alerts in this category.",
              style: TextStyle(color: ZenoTheme.textSecondary, fontSize: 12)));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filtered.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: ZenoTheme.border, indent: 60),
      itemBuilder: (context, index) {
        final n = filtered[index];
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _getCategoryColor(n.category).withValues(alpha: 0.1),
                shape: BoxShape.circle),
            child: Icon(_getCategoryIcon(n.category),
                size: 16, color: _getCategoryColor(n.category)),
          ),
          title: Text(n.title,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(n.message,
                  style: const TextStyle(
                      fontSize: 11, color: ZenoTheme.textPrimary, height: 1.4)),
              const SizedBox(height: 8),
              Text("12 minutes ago",
                  style: const TextStyle(
                      fontSize: 9, color: ZenoTheme.textSecondary)),
            ],
          ),
          onTap: n.actionRoute != null
              ? () {
                  nav.openTab(n.actionRoute!, title: n.title);
                  nav.toggleNotifications();
                }
              : null,
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: ZenoTheme.background,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Row(
        children: [
          const Icon(Icons.settings_outlined,
              size: 14, color: ZenoTheme.textSecondary),
          const SizedBox(width: 8),
          const Text("Notification Settings",
              style: TextStyle(fontSize: 10, color: ZenoTheme.textSecondary)),
          const Spacer(),
          const Text("VIEW ALL HISTORY",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: ZenoTheme.accent)),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.finance:
        return Icons.payments_outlined;
      case NotificationCategory.inventory:
        return Icons.inventory_2_outlined;
      case NotificationCategory.ai:
        return Icons.auto_awesome;
      case NotificationCategory.system:
        return Icons.settings_input_component;
      default:
        return Icons.info_outline;
    }
  }

  Color _getCategoryColor(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.finance:
        return Colors.orange;
      case NotificationCategory.inventory:
        return ZenoTheme.neonGreen;
      case NotificationCategory.ai:
        return ZenoTheme.neonCyan;
      case NotificationCategory.system:
        return Colors.blueGrey;
      default:
        return ZenoTheme.accent;
    }
  }
}
