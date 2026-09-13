import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class NotificationCentre extends StatelessWidget {
  const NotificationCentre({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Notification Hub",
      accentColor: Colors.indigo,
      trailing: Row(
        children: [
          const Icon(Icons.search, size: 14, color: ZenoTheme.textSecondary),
          const SizedBox(width: 12),
          const Icon(Icons.push_pin_outlined,
              size: 14, color: ZenoTheme.textSecondary),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            child: const Text("CLEAR ALL",
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.textSecondary)),
          ),
        ],
      ),
      child: Column(
        children: [
          _filterChips(),
          const Divider(height: 1, color: ZenoTheme.border),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: 5,
              separatorBuilder: (_, __) =>
                  const Divider(color: ZenoTheme.border, height: 16),
              itemBuilder: (context, index) {
                final alerts = [
                  {
                    "cat": "Inventory",
                    "msg": "Low stock on 12 items",
                    "time": "2m ago",
                    "p": "High"
                  },
                  {
                    "cat": "Finance",
                    "msg": "Large payment received \$45k",
                    "time": "15m ago",
                    "p": "Medium"
                  },
                  {
                    "cat": "Security",
                    "msg": "Suspicious login attempt",
                    "time": "1h ago",
                    "p": "Critical"
                  },
                  {
                    "cat": "Delivery",
                    "msg": "DEL-992 delayed in North",
                    "time": "3h ago",
                    "p": "High"
                  },
                  {
                    "cat": "HR",
                    "msg": "3 Leave requests pending",
                    "time": "5h ago",
                    "p": "Low"
                  },
                ];
                final alert = alerts[index];
                final color = _getPriorityColor(alert['p']!);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 3,
                        height: 24,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(alert['cat']!.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                      color: color,
                                      letterSpacing: 0.5)),
                              Text(alert['time']!,
                                  style: const TextStyle(
                                      fontSize: 8,
                                      color: ZenoTheme.textSecondary)),
                            ],
                          ),
                          Text(alert['msg']!,
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _miniAction(Icons.archive_outlined),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChips() {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _chip("All", true),
          _chip("Sales", false),
          _chip("Stock", false),
          _chip("Finance", false),
          _chip("Delivery", false),
        ],
      ),
    );
  }

  Widget _chip(String label, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 6, top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: active ? ZenoTheme.accent : ZenoTheme.border,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(label,
          style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: active ? Colors.white : ZenoTheme.textSecondary)),
    );
  }

  Color _getPriorityColor(String p) {
    if (p == 'Critical') return Colors.red;
    if (p == 'High') return Colors.orange;
    if (p == 'Medium') return Colors.blue;
    return ZenoTheme.textSecondary;
  }

  Widget _miniAction(IconData icon) {
    return Icon(icon, size: 12, color: ZenoTheme.textSecondary);
  }
}
