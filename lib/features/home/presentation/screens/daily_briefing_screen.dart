import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class DailyBriefingScreen extends StatelessWidget {
  const DailyBriefingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DAILY BRIEFING",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            Text(
              "Your personalized priority list for today.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            SizedBox(height: 32),
            CommandCenterWidget(
              title: "Immediate Attention",
              accentColor: Colors.red,
              child: Column(
                children: [
                  _BriefingItem(
                      title: "5 Inventory items out of stock",
                      priority: "Critical",
                      icon: Icons.warning_amber),
                  _BriefingItem(
                      title: "2 Large payments overdue",
                      priority: "High",
                      icon: Icons.payment),
                  _BriefingItem(
                      title: "System backup failed at 02:00",
                      priority: "High",
                      icon: Icons.backup),
                ],
              ),
            ),
            SizedBox(height: 24),
            CommandCenterWidget(
              title: "Today's Schedule",
              accentColor: ZenoTheme.neonCyan,
              child: Column(
                children: [
                  _BriefingItem(
                      title: "Meeting with Suppliers (Logistics)",
                      priority: "10:00 AM",
                      icon: Icons.groups),
                  _BriefingItem(
                      title: "Staff Performance Review",
                      priority: "02:00 PM",
                      icon: Icons.badge),
                  _BriefingItem(
                      title: "Daily Sales Close-out",
                      priority: "08:00 PM",
                      icon: Icons.lock),
                ],
              ),
            ),
            SizedBox(height: 24),
            CommandCenterWidget(
              title: "Drafts & Pending",
              accentColor: Colors.orange,
              child: Column(
                children: [
                  _BriefingItem(
                      title: "Draft Purchase Order: iPhone Series",
                      priority: "Draft",
                      icon: Icons.edit_note),
                  _BriefingItem(
                      title: "Pending Employee Approval: Mark S.",
                      priority: "Pending",
                      icon: Icons.person_add),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BriefingItem extends StatelessWidget {
  final String title;
  final String priority;
  final IconData icon;

  const _BriefingItem(
      {required this.title, required this.priority, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ZenoTheme.border,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: ZenoTheme.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold))),
          Text(priority,
              style: const TextStyle(
                  fontSize: 12,
                  color: ZenoTheme.textSecondary,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
