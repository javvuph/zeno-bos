import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class OrderAIHubScreen extends StatelessWidget {
  const OrderAIHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ZenoHeader(
          title: "AI Logistics Engine",
          subtitle:
              "Smart routing, delay prevention, and predictive fulfillment.",
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
                            Text("Predictive Routing Active",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00F0FF))),
                            SizedBox(height: 4),
                            Text(
                                "AI is monitoring 18 active deliveries. 2 orders on the 'Downtown' route have a 65% probability of a 15-minute delay due to construction.",
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
                            label: "Fulfillment Accuracy",
                            value: "99.8%",
                            change: "+0.2%",
                            icon: Icons.verified_outlined,
                            iconColor: Color(0xFF38ef7d))),
                    SizedBox(width: 24),
                    Expanded(
                        child: ZenoStatCard(
                            label: "Avg Delivery Time",
                            value: "42 min",
                            change: "-5 min",
                            isPositive: true,
                            icon: Icons.timer_outlined,
                            iconColor: Color(0xFF00D2FF))),
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
