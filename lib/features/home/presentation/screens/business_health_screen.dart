import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class BusinessHealthScreen extends StatelessWidget {
  const BusinessHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BUSINESS HEALTH SCORE",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "AI-driven composite score of overall business vitality.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            const Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: 0.88,
                          strokeWidth: 12,
                          backgroundColor: ZenoTheme.border,
                          color: ZenoTheme.neonGreen,
                        ),
                      ),
                      Column(
                        children: [
                          Text("88",
                              style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w900,
                                  color: ZenoTheme.neonGreen)),
                          Text("HEALTHY",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  color: ZenoTheme.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                      "Your business is performing 12% better than last month.",
                      style: TextStyle(
                          color: ZenoTheme.textPrimary,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 48),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.0,
              children: const [
                _HealthMetric(
                    label: "Liquidity Ratio",
                    value: "2.4",
                    status: "Excellent",
                    color: ZenoTheme.neonGreen),
                _HealthMetric(
                    label: "Profit Margin",
                    value: "32%",
                    status: "Stable",
                    color: ZenoTheme.neonCyan),
                _HealthMetric(
                    label: "Inventory Turnover",
                    value: "8.2x",
                    status: "Improving",
                    color: Colors.orange),
                _HealthMetric(
                    label: "CAC / LTV",
                    value: "4.5",
                    status: "Healthy",
                    color: Colors.purple),
                _HealthMetric(
                    label: "Staff Retention",
                    value: "94%",
                    status: "Critical",
                    color: Colors.red),
                _HealthMetric(
                    label: "System Uptime",
                    value: "99.9%",
                    status: "Optimal",
                    color: ZenoTheme.neonGreen),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthMetric extends StatelessWidget {
  final String label;
  final String value;
  final String status;
  final Color color;

  const _HealthMetric(
      {required this.label,
      required this.value,
      required this.status,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: ZenoTheme.textSecondary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6)),
                child: Text(status,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
