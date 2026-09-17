import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "NOTIFICATION CENTER",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "Stay updated with system and operational events.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            CommandCenterWidget(
              title: "Unread Notifications",
              accentColor: ZenoTheme.neonCyan,
              trailing: TextButton(
                  onPressed: () {},
                  child: const Text("Mark all read",
                      style: TextStyle(fontSize: 12))),
              child: const Column(
                children: [
                  HomeNotificationItem(
                      title: "Inventory low for SKU: PHN-15-PRO",
                      time: "2m ago",
                      type: "Inventory",
                      color: Colors.orange),
                  HomeNotificationItem(
                      title: "New high-value order #1245 received",
                      time: "15m ago",
                      type: "Sales",
                      color: ZenoTheme.neonGreen),
                  HomeNotificationItem(
                      title: "AI Suggestion: Reorder 'X-Series' now",
                      time: "1h ago",
                      type: "AI",
                      color: ZenoTheme.neonCyan,
                      isAI: true),
                  HomeNotificationItem(
                      title: "System update scheduled for 02:00 AM",
                      time: "3h ago",
                      type: "System",
                      color: Colors.purple),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const CommandCenterWidget(
              title: "Earlier Today",
              accentColor: ZenoTheme.textSecondary,
              child: Column(
                children: [
                  HomeNotificationItem(
                      title: "Backup process completed successfully",
                      time: "5h ago",
                      type: "System",
                      color: ZenoTheme.textSecondary),
                  HomeNotificationItem(
                      title: "Employee Alex R. checked in",
                      time: "6h ago",
                      type: "Staff",
                      color: ZenoTheme.textSecondary),
                  HomeNotificationItem(
                      title: "Daily business summary ready",
                      time: "8h ago",
                      type: "AI",
                      color: ZenoTheme.textSecondary,
                      isAI: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
