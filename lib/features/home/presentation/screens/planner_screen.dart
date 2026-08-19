import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PLANNER & CALENDAR",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2),
                  ),
                  const Text(
                    "Master schedule for the entire business operation.",
                    style: TextStyle(color: ZenoTheme.textSecondary),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: ZenoTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ZenoTheme.border),
                    ),
                    child: const Center(
                        child: Text("Interactive Monthly Calendar View")),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1, color: ZenoTheme.border),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("TODAY'S SCHEDULE",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: ZenoTheme.textSecondary,
                          letterSpacing: 1)),
                  const SizedBox(height: 24),
                  _ScheduleItem(
                      time: "09:00 AM",
                      title: "Daily Stand-up",
                      desc: "Main Meeting Room"),
                  _ScheduleItem(
                      time: "11:00 AM",
                      title: "Supplier Review",
                      desc: "Logistics Hub",
                      color: Colors.orange),
                  _ScheduleItem(
                      time: "01:00 PM", title: "Lunch Break", desc: ""),
                  _ScheduleItem(
                      time: "03:00 PM",
                      title: "Quarterly Planning",
                      desc: "Board Room",
                      color: Colors.purple),
                  _ScheduleItem(
                      time: "06:00 PM",
                      title: "Ops Close-out",
                      desc: "Remote Access"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final String time;
  final String title;
  final String desc;
  final Color? color;

  const _ScheduleItem(
      {required this.time,
      required this.title,
      required this.desc,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(width: 32, height: 1, color: ZenoTheme.border),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (color ?? ZenoTheme.neonCyan).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color:
                        (color ?? ZenoTheme.neonCyan).withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                  if (desc.isNotEmpty)
                    Text(desc,
                        style: const TextStyle(
                            fontSize: 11, color: ZenoTheme.textSecondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
