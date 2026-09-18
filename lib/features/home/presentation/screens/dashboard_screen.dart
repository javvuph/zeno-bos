import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/global_filters.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/premium_dashboard_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    return Scaffold(
      backgroundColor: colors?.bgTier1 ?? ZenoTheme.background,
      body: const Column(
        children: [
          GlobalFilterBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: PremiumDashboardLayout(),
            ),
          ),
        ],
      ),
    );
  }
}
