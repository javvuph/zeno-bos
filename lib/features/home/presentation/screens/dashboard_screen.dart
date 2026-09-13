import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/global_filters.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/premium_dashboard_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ZenoTheme.background,
      body: Column(
        children: [
          GlobalFilterBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: PremiumDashboardLayout(),
            ),
          ),
        ],
      ),
    );
  }
}
