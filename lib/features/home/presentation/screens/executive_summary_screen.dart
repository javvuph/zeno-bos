import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class ExecutiveSummaryScreen extends StatelessWidget {
  const ExecutiveSummaryScreen({super.key});

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
              "EXECUTIVE SUMMARY",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "High-level performance analysis for decision makers.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            CommandCenterWidget(
              title: "Strategic Overview",
              accentColor: ZenoTheme.accent,
              child: const Text(
                "In Q3 2026, ZENO has seen a 15% increase in operational efficiency due to the integration of the AI Command Center. "
                "Revenue growth is stable at 8% MoM, with a significant reduction in customer churn (down 2%). "
                "The upcoming expansion into the South Region is projected to contribute an additional 12% to the annual profit target.",
                style: TextStyle(
                    fontSize: 16, height: 1.8, color: ZenoTheme.textPrimary),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CommandCenterWidget(
                    title: "Financial Health",
                    accentColor: ZenoTheme.neonGreen,
                    child: Column(
                      children: const [
                        _SummaryRow(label: "Operating Margin", value: "28.5%"),
                        _SummaryRow(label: "Current Ratio", value: "2.1"),
                        _SummaryRow(label: "ROI (AI Hub)", value: "340%"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: CommandCenterWidget(
                    title: "Operational Health",
                    accentColor: ZenoTheme.neonCyan,
                    child: Column(
                      children: const [
                        _SummaryRow(label: "SLA Fulfillment", value: "99.2%"),
                        _SummaryRow(
                            label: "Inventory Turnover", value: "12.4x"),
                        _SummaryRow(
                            label: "Employee Satisfaction", value: "4.8/5"),
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: ZenoTheme.textSecondary)),
          Text(value,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ZenoTheme.textPrimary)),
        ],
      ),
    );
  }
}
