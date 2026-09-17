import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class AIMorningReportScreen extends StatelessWidget {
  const AIMorningReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.auto_awesome,
                    color: ZenoTheme.neonCyan, size: 28),
                SizedBox(width: 16),
                Text(
                  "AI MORNING REPORT",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2),
                ),
              ],
            ),
            const Text(
              "Generated July 25, 2026 • 08:00 AM",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            const CommandCenterWidget(
              title: "Executive Summary",
              accentColor: ZenoTheme.neonCyan,
              child: Text(
                "Good morning, Alex. Business health is up 4% compared to yesterday. "
                "The surge is driven by high pre-orders for the 'X-Series' products. "
                "However, shipping delays from North Branch may impact delivery SLAs by 12% today.",
                style: TextStyle(
                    fontSize: 15, height: 1.6, color: ZenoTheme.textPrimary),
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(
                  child: CommandCenterWidget(
                    title: "Risk Alerts",
                    accentColor: Colors.red,
                    child: Column(
                      children: [
                        _AIInsightItem(
                            text:
                                "High risk of 'Out of Stock' for iPhone 15 Pro within 48 hours.",
                            icon: Icons.warning_amber),
                        _AIInsightItem(
                            text:
                                "Unusual activity detected in login logs (3 failed attempts).",
                            icon: Icons.security),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: CommandCenterWidget(
                    title: "Opportunities",
                    accentColor: ZenoTheme.neonGreen,
                    child: Column(
                      children: [
                        _AIInsightItem(
                            text:
                                "Upsell potential identified for 'Premium Plan' users.",
                            icon: Icons.trending_up),
                        _AIInsightItem(
                            text:
                                "Optimizing delivery route #4 could save 15% in fuel costs.",
                            icon: Icons.local_shipping),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CommandCenterWidget(
              title: "Forecast",
              accentColor: Colors.purple,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12)),
                child: const Center(child: Text("Projected Revenue Curve")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AIInsightItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const _AIInsightItem({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: ZenoTheme.textSecondary),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
