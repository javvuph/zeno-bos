import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class KPICenterScreen extends StatelessWidget {
  const KPICenterScreen({super.key});

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
              "KPI CENTER",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "Deep dive into key performance indicators.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 1.8,
              children: const [
                HomeStatCard(
                    label: "Revenue Today",
                    value: "\$12,450",
                    trend: "+12%",
                    color: ZenoTheme.neonGreen,
                    icon: Icons.attach_money_outlined),
                HomeStatCard(
                    label: "Orders Today",
                    value: "84",
                    trend: "+5%",
                    color: Colors.orange,
                    icon: Icons.shopping_cart_outlined),
                HomeStatCard(
                    label: "Profit Today",
                    value: "\$3,200",
                    trend: "+8%",
                    color: ZenoTheme.neonCyan,
                    icon: Icons.trending_up),
                HomeStatCard(
                    label: "Customers Today",
                    value: "12",
                    trend: "+2",
                    color: Colors.purple,
                    icon: Icons.person_add_outlined),
                HomeStatCard(
                    label: "Low Stock Alerts",
                    value: "4",
                    trend: "-1",
                    color: Colors.red,
                    icon: Icons.warning_amber_outlined),
                HomeStatCard(
                    label: "Pending Deliveries",
                    value: "18",
                    trend: "+3",
                    color: ZenoTheme.neonCyan,
                    icon: Icons.local_shipping_outlined),
                HomeStatCard(
                    label: "Cash Position",
                    value: "\$450,200",
                    trend: "+2%",
                    color: ZenoTheme.neonGreen,
                    icon: Icons.account_balance_wallet_outlined),
                HomeStatCard(
                    label: "Employee Attendance",
                    value: "94%",
                    trend: "-1%",
                    color: Colors.blue,
                    icon: Icons.badge_outlined),
                HomeStatCard(
                    label: "Business Growth",
                    value: "+14.2%",
                    trend: "+0.5%",
                    color: ZenoTheme.neonGreen,
                    icon: Icons.auto_graph),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
