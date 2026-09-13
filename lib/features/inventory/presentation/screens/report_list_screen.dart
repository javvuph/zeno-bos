import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class InventoryReport {
  final String title;
  final String description;
  final IconData icon;

  InventoryReport(
      {required this.title, required this.description, required this.icon});
}

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InventoryReport> reports = [
      InventoryReport(
          title: "Stock Summary",
          description: "Consolidated view of all stock levels.",
          icon: Icons.summarize_outlined),
      InventoryReport(
          title: "Stock Movement",
          description: "History of all transactions and transfers.",
          icon: Icons.compare_arrows),
      InventoryReport(
          title: "Stock Valuation",
          description: "Total financial value of current inventory.",
          icon: Icons.attach_money),
      InventoryReport(
          title: "Low Stock Alert",
          description: "Items below their reorder points.",
          icon: Icons.trending_down),
      InventoryReport(
          title: "Dead Stock Analysis",
          description: "Products with no movement for 90+ days.",
          icon: Icons.block),
      InventoryReport(
          title: "Expiry Report",
          description: "Perishable items nearing their end dates.",
          icon: Icons.event_busy),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Inventory Reports",
          subtitle:
              "Generate and schedule automated reports for business intelligence.",
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
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final r = reports[index];
              return ZenoCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(r.icon, size: 32, color: ZenoTheme.accent),
                    const SizedBox(height: 16),
                    Text(r.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(r.description,
                        style: const TextStyle(
                            fontSize: 11, color: ZenoTheme.textSecondary),
                        textAlign: TextAlign.center),
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
