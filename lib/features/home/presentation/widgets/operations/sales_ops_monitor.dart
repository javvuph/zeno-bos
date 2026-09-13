import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class SalesOpsMonitor extends StatelessWidget {
  const SalesOpsMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Live Sales Operations",
      accentColor: ZenoTheme.neonGreen,
      trailing: _highestInvoiceBadge("\$24,500"),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: 5,
              separatorBuilder: (_, __) =>
                  const Divider(color: ZenoTheme.border, height: 16),
              itemBuilder: (context, index) {
                final items = [
                  {
                    "inv": "INV-1021",
                    "cust": "Global Tech",
                    "amt": "\$12,500",
                    "status": "Unpaid",
                    "type": "Large Sale"
                  },
                  {
                    "inv": "INV-1022",
                    "cust": "Design Co",
                    "amt": "\$2,100",
                    "status": "Pending",
                    "type": "Standard"
                  },
                  {
                    "inv": "INV-1023",
                    "cust": "Retailer X",
                    "amt": "\$8,400",
                    "status": "Returns",
                    "type": "Sales Return"
                  },
                  {
                    "inv": "INV-1024",
                    "cust": "Personal",
                    "amt": "\$450",
                    "status": "Paid",
                    "type": "Standard"
                  },
                  {
                    "inv": "INV-1025",
                    "cust": "Alpha Corp",
                    "amt": "\$3,200",
                    "status": "Cancelled",
                    "type": "Cancelled"
                  },
                ];
                final item = items[index];
                final statusColor = _getStatusColor(item['status'] as String);

                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(item['inv'] as String,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              _typeLabel(item['type'] as String),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(item['cust'] as String,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: ZenoTheme.textSecondary)),
                          Text(item['amt'] as String,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: ZenoTheme.textPrimary)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(item['status']!.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: statusColor)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _actionButton("LEDGER", Icons.menu_book_outlined,
                                ZenoTheme.textSecondary),
                            const SizedBox(width: 6),
                            _actionButton("PAY", Icons.payments_outlined,
                                ZenoTheme.neonGreen),
                            const SizedBox(width: 6),
                            _actionButton("PRINT", Icons.print_outlined,
                                ZenoTheme.neonCyan),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          _operationalSummary(),
        ],
      ),
    );
  }

  Widget _operationalSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ZenoTheme.surface.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _miniMetric("Today's High", "\$24.5k"),
          _miniMetric("Returns", "3"),
          _miniMetric("Pending", "12"),
          _miniMetric("Unpaid", "\$42k", color: Colors.red),
        ],
      ),
    );
  }

  Widget _miniMetric(String label, String val,
      {Color color = ZenoTheme.textPrimary}) {
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return ZenoTheme.neonGreen;
      case 'Unpaid':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      case 'Returns':
        return Colors.purple;
      case 'Cancelled':
        return Colors.grey;
      default:
        return ZenoTheme.textSecondary;
    }
  }

  Widget _typeLabel(String type) {
    if (type == 'Standard') return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
          color: ZenoTheme.border, borderRadius: BorderRadius.circular(2)),
      child: Text(type.toUpperCase(),
          style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: ZenoTheme.textSecondary)),
    );
  }

  Widget _highestInvoiceBadge(String val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: ZenoTheme.neonCyan.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text("TOP: $val",
          style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: ZenoTheme.neonCyan)),
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
              border: Border.all(color: color.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(4)),
          child: Icon(icon, size: 12, color: color),
        ),
      ),
    );
  }
}
