import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class SalesReport {
  final String title;
  final String metric;
  final IconData icon;

  SalesReport({required this.title, required this.metric, required this.icon});
}

class BillingReportScreen extends StatelessWidget {
  const BillingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SalesReport> _reports = [
      SalesReport(title: "Daily Sales", metric: "\$4,250", icon: Icons.today),
      SalesReport(
          title: "Tax Collected",
          metric: "\$637.50",
          icon: Icons.gavel_outlined),
      SalesReport(title: "Refunds", metric: "\$85.00", icon: Icons.undo),
      SalesReport(
          title: "Top Seller", metric: "iPhone 15", icon: Icons.star_outline),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Sales Intelligence",
          subtitle:
              "Detailed reporting and tax summaries for business accounting.",
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              final r = _reports[index];
              return ZenoCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(r.icon, size: 28, color: Color(0xFFee0979)),
                    const SizedBox(height: 12),
                    Text(r.title,
                        style: const TextStyle(
                            fontSize: 12, color: ZenoTheme.textSecondary)),
                    const SizedBox(height: 4),
                    Text(r.metric,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
