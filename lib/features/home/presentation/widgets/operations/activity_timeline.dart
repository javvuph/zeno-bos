import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class ActivityTimeline extends StatelessWidget {
  const ActivityTimeline({super.key});

  static const _activities = [
    {
      "user": "Admin",
      "action": "New Sale INV-2021 created",
      "time": "Just now",
      "color": ZenoTheme.neonGreen,
      "mod": "SALES"
    },
    {
      "user": "System",
      "action": "Daily DB Backup Succeeded",
      "time": "20m ago",
      "color": ZenoTheme.neonCyan,
      "mod": "SYS"
    },
    {
      "user": "Manager",
      "action": "Approved Expense EXP-88",
      "time": "1h ago",
      "color": Colors.amber,
      "mod": "FIN"
    },
    {
      "user": "Sarah",
      "action": "Stock adjusted for SKU-10",
      "time": "3h ago",
      "color": Colors.purple,
      "mod": "INV"
    },
    {
      "user": "System",
      "action": "Failed Login attempt (IP: 192.x)",
      "time": "5h ago",
      "color": Colors.red,
      "mod": "SEC"
    },
    {
      "user": "John",
      "action": "Customer CUST-42 added",
      "time": "6h ago",
      "color": Colors.blue,
      "mod": "CRM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Real-Time Activity Timeline",
      accentColor: Colors.blueGrey,
      trailing: Row(
        children: [
          _filterBtn("USER"),
          const SizedBox(width: 6),
          _filterBtn("MODULE"),
          const SizedBox(width: 6),
          _filterBtn("BRANCH"),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final act = _activities[index];
          final isLast = index == _activities.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: act['color'] as Color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: (act['color'] as Color)
                                  .withValues(alpha: 0.3),
                              blurRadius: 4)
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                          child: Container(
                              width: 1,
                              color: ZenoTheme.border,
                              margin: const EdgeInsets.symmetric(vertical: 4))),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(act['user']!.toString().toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                      color: ZenoTheme.border,
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Text(act['mod']!.toString(),
                                      style: const TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold,
                                          color: ZenoTheme.textSecondary)),
                                ),
                              ],
                            ),
                            Text(act['time']!.toString(),
                                style: const TextStyle(
                                    fontSize: 9,
                                    color: ZenoTheme.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(act['action']!.toString(),
                            style: const TextStyle(
                                fontSize: 11,
                                color: ZenoTheme.textSecondary,
                                height: 1.4)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _filterBtn(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: ZenoTheme.border, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: ZenoTheme.textSecondary)),
          const Icon(Icons.arrow_drop_down,
              size: 10, color: ZenoTheme.textSecondary),
        ],
      ),
    );
  }
}
