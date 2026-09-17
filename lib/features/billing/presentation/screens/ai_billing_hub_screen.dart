import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class AIBillingHubScreen extends StatelessWidget {
  const AIBillingHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ZenoHeader(
          title: "AI Billing Intelligence",
          subtitle:
              "Automated upsells, fraud detection, and buying predictions.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ZenoCard(
                  color: const Color(0xFF00F0FF).withValues(alpha: 0.05),
                  child: const Row(
                    children: [
                      Icon(Icons.auto_awesome,
                          color: Color(0xFF00F0FF), size: 32),
                      SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Active Recommendation",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00F0FF))),
                            SizedBox(height: 4),
                            Text(
                                "Smart Discounts: Offering a 5% discount on Apple accessories today could increase average bill value by 12%.",
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(
                        child: ZenoStatCard(
                            label: "Upsell Success",
                            value: "24%",
                            change: "+3%",
                            icon: Icons.trending_up,
                            iconColor: Color(0xFF00F0FF))),
                    SizedBox(width: 24),
                    Expanded(
                        child: ZenoStatCard(
                            label: "Fraud Risk",
                            value: "Low",
                            icon: Icons.security,
                            iconColor: Color(0xFF00FF88))),
                    SizedBox(width: 24),
                    Expanded(
                        child: ZenoStatCard(
                            label: "AI Bill Checks",
                            value: "850",
                            icon: Icons.check_circle_outline,
                            iconColor: Color(0xFF6a11cb))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
