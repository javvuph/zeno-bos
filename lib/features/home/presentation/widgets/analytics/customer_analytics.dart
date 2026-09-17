import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class CustomerAnalytics extends StatelessWidget {
  const CustomerAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return const BISectionContainer(
      title: "Customer Analytics",
      accentColor: Colors.purple,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(
                    label: "Total Customers",
                    value: "12.4k",
                    trend: "+8.2%",
                    color: ZenoTheme.neonCyan),
                _StatItem(
                    label: "Active Users",
                    value: "8.1k",
                    trend: "+12.4%",
                    color: ZenoTheme.neonGreen),
              ],
            ),
            SizedBox(height: 20),
            Text("RETENTION RATE",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.textSecondary)),
            SizedBox(height: 8),
            BIAnalyticRow(
                label: "Q3 Retention",
                value: "78%",
                percentage: 78,
                color: ZenoTheme.neonGreen),
            SizedBox(height: 12),
            Text("LIFETIME VALUE (LTV)",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.textSecondary)),
            SizedBox(height: 8),
            BIAnalyticRow(
                label: "Avg LTV",
                value: "\$1,240",
                percentage: 65,
                color: Colors.purple),
            SizedBox(height: 12),
            Text("CUSTOMER GROWTH",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.textSecondary)),
            SizedBox(height: 8),
            BIAnalyticRow(
                label: "Monthly Growth",
                value: "12%",
                percentage: 40,
                color: ZenoTheme.neonCyan),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final Color color;

  const _StatItem(
      {required this.label,
      required this.value,
      required this.trend,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 10, color: ZenoTheme.textSecondary)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(width: 8),
            Text(trend,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.neonGreen)),
          ],
        ),
      ],
    );
  }
}
