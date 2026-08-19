import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class ExecutiveAISummary extends StatelessWidget {
  const ExecutiveAISummary({super.key});

  static const _summaries = [
    "Revenue increased 18% compared to previous month.",
    "Profit margin improved by 4% due to reduced logistics cost.",
    "Inventory turnover slowed by 6% in North Branch.",
    "Customer growth exceeded target by 12% in Q3.",
    "Expenses increased 8% due to fuel surcharge spikes.",
    "Receivables are increasing; 12 invoices overdue.",
    "Three suppliers have delayed deliveries in transit.",
    "Two flagship products require immediate reorder.",
    "Overall cash flow remains healthy with 3x coverage.",
  ];

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Executive AI Summary",
      accentColor: ZenoTheme.neonGreen,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _summaries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(Icons.auto_awesome,
                      size: 14, color: ZenoTheme.neonGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _summaries[index],
                    style: const TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: ZenoTheme.textPrimary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
