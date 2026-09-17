import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class TodayOverviewScreen extends StatelessWidget {
  const TodayOverviewScreen({super.key});

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
              "TODAY'S OVERVIEW",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "Live operational pulse for today.",
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
                    label: "REVENUE TODAY",
                    value: "\$12,450",
                    trend: "+15%",
                    color: ZenoTheme.neonGreen,
                    icon: Icons.payments_outlined),
                HomeStatCard(
                    label: "ORDERS TODAY",
                    value: "84",
                    trend: "+12%",
                    color: Colors.orange,
                    icon: Icons.shopping_cart_outlined),
                HomeStatCard(
                    label: "VISITORS TODAY",
                    value: "1,204",
                    trend: "+25%",
                    color: ZenoTheme.neonCyan,
                    icon: Icons.people_outline),
                HomeStatCard(
                    label: "PENDING TASKS",
                    value: "12",
                    trend: "-2",
                    color: Colors.purple,
                    icon: Icons.task_alt),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CommandCenterWidget(
                    title: "Hourly Activity",
                    accentColor: ZenoTheme.neonGreen,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Hourly Sales/Orders Chart")),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  child: CommandCenterWidget(
                    title: "Live Feed",
                    accentColor: ZenoTheme.neonCyan,
                    child: Column(
                      children: [
                        HomeNotificationItem(
                            title: "New Order #1245 from Web",
                            time: "2m ago",
                            type: "Sales",
                            color: ZenoTheme.neonGreen),
                        HomeNotificationItem(
                            title: "Payment Received: \$450",
                            time: "15m ago",
                            type: "Finance",
                            color: ZenoTheme.neonCyan),
                        HomeNotificationItem(
                            title: "Low Stock Alert: iPhone 15",
                            time: "1h ago",
                            type: "Inventory",
                            color: Colors.orange),
                        HomeNotificationItem(
                            title: "Staff Login: Alex R.",
                            time: "2h ago",
                            type: "System",
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
