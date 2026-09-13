import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class BICalendar extends StatelessWidget {
  const BICalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Master Operational Calendar",
      accentColor: Colors.pinkAccent,
      child: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            calendarFormat: CalendarFormat.month,
            headerVisible: false,
            rowHeight: 28,
            daysOfWeekHeight: 18,
            calendarStyle: const CalendarStyle(
              defaultTextStyle:
                  TextStyle(fontSize: 9, color: ZenoTheme.textPrimary),
              weekendTextStyle:
                  TextStyle(fontSize: 9, color: ZenoTheme.textSecondary),
              todayDecoration: BoxDecoration(
                  color: ZenoTheme.accent, shape: BoxShape.circle),
              markerDecoration: BoxDecoration(
                  color: ZenoTheme.neonGreen, shape: BoxShape.circle),
              markerSize: 3,
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: ZenoTheme.textSecondary),
              weekendStyle: TextStyle(
                  fontSize: 8, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const Divider(color: ZenoTheme.border, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                _EventItem(
                    time: "09:00",
                    title: "HQ Dispatch Start",
                    type: "Delivery",
                    color: ZenoTheme.neonCyan),
                _EventItem(
                    time: "11:30",
                    title: "PO-9921 Payment Due",
                    type: "Purchase",
                    color: Colors.red),
                _EventItem(
                    time: "14:00",
                    title: "Sarah Leave Start",
                    type: "HR",
                    color: Colors.purple),
                _EventItem(
                    time: "15:30",
                    title: "Tax Filing Deadline",
                    type: "Tax",
                    color: Colors.orange),
                _EventItem(
                    time: "17:00",
                    title: "Maintenance Window",
                    type: "System",
                    color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final String time;
  final String title;
  final String type;
  final Color color;

  const _EventItem(
      {required this.time,
      required this.title,
      required this.type,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: color.withValues(alpha: 0.2))),
            child: Text(time,
                style: TextStyle(
                    fontSize: 8, fontWeight: FontWeight.bold, color: color)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis)),
                Text(type.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 7,
                        color: ZenoTheme.textSecondary,
                        letterSpacing: 0.5)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              size: 12, color: ZenoTheme.textSecondary),
        ],
      ),
    );
  }
}
