import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class LiveAnalyticsScreen extends StatelessWidget {
  const LiveAnalyticsScreen({super.key});

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
              "LIVE ANALYTICS",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "Real-time data visualization and trend analysis.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CommandCenterWidget(
                    title: "Revenue Trends",
                    accentColor: ZenoTheme.neonGreen,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Interactive Multi-Series Area Chart")),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: CommandCenterWidget(
                    title: "Operational Efficiency",
                    accentColor: ZenoTheme.neonCyan,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Radar/Spider Chart for KPIs")),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CommandCenterWidget(
                    title: "Customer Growth",
                    accentColor: Colors.purple,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Customer Acquisition Funnel")),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: CommandCenterWidget(
                    title: "Inventory Velocity",
                    accentColor: Colors.orange,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Product Turn-rate Bar Chart")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
