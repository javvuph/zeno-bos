import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class BusinessSnapshotScreen extends StatelessWidget {
  const BusinessSnapshotScreen({super.key});

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
              "BUSINESS SNAPSHOT",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "Real-time overview across all operational divisions.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: const [
                HomeStatCard(
                    label: "TOTAL REVENUE",
                    value: "\$1,240,500",
                    trend: "+12.5%",
                    color: ZenoTheme.neonGreen,
                    icon: Icons.payments_outlined),
                HomeStatCard(
                    label: "NET PROFIT",
                    value: "\$342,000",
                    trend: "+5.2%",
                    color: ZenoTheme.neonCyan,
                    icon: Icons.trending_up),
                HomeStatCard(
                    label: "ACTIVE ORDERS",
                    value: "1,240",
                    trend: "+8.1%",
                    color: Colors.orange,
                    icon: Icons.shopping_cart_outlined),
                HomeStatCard(
                    label: "CUSTOMER SAT",
                    value: "98.2%",
                    trend: "+0.5%",
                    color: Colors.purple,
                    icon: Icons.star_outline),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CommandCenterWidget(
                    title: "Operational Status",
                    accentColor: ZenoTheme.neonCyan,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text("Interactive Growth Chart Placeholder")),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  child: CommandCenterWidget(
                    title: "Branch Performance",
                    accentColor: Colors.orange,
                    child: Column(
                      children: [
                        _BranchRow(
                            name: "Main HQ",
                            value: "\$540k",
                            percent: 85,
                            color: ZenoTheme.neonGreen),
                        _BranchRow(
                            name: "North Branch",
                            value: "\$320k",
                            percent: 65,
                            color: ZenoTheme.neonCyan),
                        _BranchRow(
                            name: "East Distribution",
                            value: "\$180k",
                            percent: 45,
                            color: Colors.orange),
                        _BranchRow(
                            name: "South Retail",
                            value: "\$200k",
                            percent: 55,
                            color: Colors.purple),
                      ],
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

class _BranchRow extends StatelessWidget {
  final String name;
  final String value;
  final double percent;
  final Color color;

  const _BranchRow(
      {required this.name,
      required this.value,
      required this.percent,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 12, color: ZenoTheme.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: ZenoTheme.border,
            color: color,
            minHeight: 4,
          ),
        ],
      ),
    );
  }
}
