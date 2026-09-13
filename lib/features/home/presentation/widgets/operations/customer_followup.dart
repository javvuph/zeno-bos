import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class CustomerFollowup extends StatelessWidget {
  const CustomerFollowup({super.key});

  @override
  Widget build(BuildContext context) {
    final items = BIMockData.getCustomerFollowups();

    return BISectionContainer(
      title: "Customer Engagement & Follow-up",
      accentColor: Colors.purple,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: ZenoTheme.border, height: 16),
              itemBuilder: (context, index) {
                final item = items[index];
                final color = _getPriorityColor(item['priority'] as String);

                return Row(
                  children: [
                    _customerAvatar(
                        item['name'] as String, item['type'] as String),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(item['name'] as String,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 6),
                              _typeIndicator(item['type'] as String),
                            ],
                          ),
                          Text(item['issue'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: color,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _actionIcon(
                                  Icons.phone_outlined, Colors.blue, "Call"),
                              const SizedBox(width: 8),
                              _actionIcon(Icons.chat_bubble_outline,
                                  ZenoTheme.neonGreen, "WhatsApp"),
                              const SizedBox(width: 8),
                              _actionIcon(
                                  Icons.email_outlined, Colors.orange, "Email"),
                              const SizedBox(width: 8),
                              _actionIcon(Icons.menu_book_outlined,
                                  Colors.purple, "Ledger"),
                              const SizedBox(width: 8),
                              _actionIcon(Icons.notification_add_outlined,
                                  ZenoTheme.neonCyan, "Reminder"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(item['days'] as String,
                            style: const TextStyle(
                                fontSize: 10, color: ZenoTheme.textSecondary)),
                        const SizedBox(height: 4),
                        _priorityBadge(item['priority'] as String, color),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          _statsFooter(),
        ],
      ),
    );
  }

  Widget _statsFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ZenoTheme.background.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _miniStat("Outstanding", "\$142k", Colors.red),
          _miniStat("Credit Exceeded", "12", Colors.orange),
          _miniStat("Birthdays", "3", Colors.pink),
          _miniStat("Inactive", "45", Colors.grey),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String val, Color color) {
    return Column(
      children: [
        Text(val,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w900, color: color)),
        Text(label,
            style: const TextStyle(
                fontSize: 8,
                color: ZenoTheme.textSecondary,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Color _getPriorityColor(String p) {
    if (p == 'Critical') return Colors.red;
    if (p == 'High') return Colors.orange;
    if (p == 'Medium') return Colors.blue;
    return ZenoTheme.textSecondary;
  }

  Widget _customerAvatar(String name, String type) {
    IconData icon = Icons.person_outline;
    Color iconColor = ZenoTheme.textSecondary;
    if (type == 'Birthday') {
      icon = Icons.cake_outlined;
      iconColor = Colors.pink;
    }
    if (type == 'Finance') {
      icon = Icons.account_balance_wallet_outlined;
      iconColor = Colors.amber;
    }

    return CircleAvatar(
      radius: 18,
      backgroundColor: ZenoTheme.border,
      child: Icon(icon, size: 16, color: iconColor),
    );
  }

  Widget _typeIndicator(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
          color: ZenoTheme.border, borderRadius: BorderRadius.circular(2)),
      child: Text(type.toUpperCase(),
          style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.w900,
              color: ZenoTheme.textSecondary)),
    );
  }

  Widget _priorityBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text(label.toUpperCase(),
          style: TextStyle(
              fontSize: 8, fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _actionIcon(IconData icon, Color color, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(4)),
          child: Icon(icon, size: 12, color: color),
        ),
      ),
    );
  }
}
