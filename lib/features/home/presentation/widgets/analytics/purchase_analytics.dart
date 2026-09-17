import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class PurchaseAnalytics extends StatelessWidget {
  const PurchaseAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Purchase Analytics",
      accentColor: Colors.blueAccent,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PurchaseMetric(
                    label: "Order Volume", value: "245", trend: "+12%"),
                _PurchaseMetric(
                    label: "Avg Order Value", value: "\$4.2k", trend: "+5%"),
              ],
            ),
            const SizedBox(height: 20),
            const BIAnalyticRow(
                label: "Vendor Reliability",
                value: "94%",
                percentage: 94,
                color: ZenoTheme.neonGreen),
            const BIAnalyticRow(
                label: "Lead Time Accuracy",
                value: "88%",
                percentage: 88,
                color: ZenoTheme.neonCyan),
            const BIAnalyticRow(
                label: "Cost Variance",
                value: "4.2%",
                percentage: 15,
                color: Colors.orange),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ZenoTheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, size: 16, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Vendor A delivery lead times are increasing. Consider secondary sources.",
                      style: TextStyle(
                          fontSize: 10, color: ZenoTheme.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PurchaseMetric extends StatelessWidget {
  final String label;
  final String value;
  final String trend;

  const _PurchaseMetric(
      {required this.label, required this.value, required this.trend});

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
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(width: 6),
            Text(trend,
                style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.neonGreen)),
          ],
        ),
      ],
    );
  }
}
