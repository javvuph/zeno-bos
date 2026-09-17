import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class SupplierOpsMonitor extends StatelessWidget {
  const SupplierOpsMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Supplier Obligations & Performance",
      accentColor: Colors.deepOrange,
      trailing: _performanceIndicator("94.2%"),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: 4,
              separatorBuilder: (_, __) =>
                  const Divider(color: ZenoTheme.border, height: 16),
              itemBuilder: (context, index) {
                final items = [
                  {
                    "name": "Intel Corp",
                    "amt": "\$45,000",
                    "due": "in 2 days",
                    "status": "Pending",
                    "perf": "A"
                  },
                  {
                    "name": "Apple Inc",
                    "amt": "\$120,000",
                    "due": "TODAY",
                    "status": "Urgent",
                    "perf": "A+"
                  },
                  {
                    "name": "Logitech",
                    "amt": "\$12,400",
                    "due": "in 5 days",
                    "status": "Scheduled",
                    "perf": "B"
                  },
                  {
                    "name": "Samsung",
                    "amt": "\$8,100",
                    "due": "Overdue",
                    "status": "Critical",
                    "perf": "A-"
                  },
                ];
                final item = items[index];
                final color = _getStatusColor(item['status'] as String);

                return Row(
                  children: [
                    _perfBadge(item['perf'] as String),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['name']!,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Text(item['amt']!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: ZenoTheme.neonGreen)),
                              const SizedBox(width: 8),
                              Text("Due ${item['due']}",
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: color,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        _actionButton("LEDGER", Icons.menu_book_outlined,
                            ZenoTheme.textSecondary),
                        const SizedBox(width: 6),
                        _actionButton("MESSAGE", Icons.forum_outlined,
                            ZenoTheme.neonCyan),
                        const SizedBox(width: 6),
                        _actionButton("PAY", Icons.account_balance_outlined,
                            ZenoTheme.accent),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          _supplierFooter(),
        ],
      ),
    );
  }

  Widget _supplierFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ZenoTheme.surface.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _miniStat("Late Deliveries", "4", Colors.red),
          _miniStat("Pending POs", "15", Colors.orange),
          _miniStat("Returns", "2", Colors.purple),
          _miniStat("Communication", "Active", ZenoTheme.neonGreen),
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

  Color _getStatusColor(String s) {
    if (s == 'Urgent' || s == 'Critical') return Colors.red;
    if (s == 'Pending') return Colors.orange;
    return ZenoTheme.neonCyan;
  }

  Widget _perfBadge(String grade) {
    return Container(
      width: 30,
      height: 30,
      decoration:
          const BoxDecoration(color: ZenoTheme.border, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(grade,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: ZenoTheme.neonCyan)),
    );
  }

  Widget _performanceIndicator(String val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: ZenoTheme.neonGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text("PERF: $val",
          style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: ZenoTheme.neonGreen)),
    );
  }

  Widget _actionButton(String tip, IconData icon, Color color) {
    return Tooltip(
      message: tip,
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
