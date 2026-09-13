import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class Campaign {
  final String name;
  final String channel;
  final String status;
  final int reach;
  final double budget;

  Campaign(
      {required this.name,
      required this.channel,
      required this.status,
      required this.reach,
      required this.budget});
}

class MarketingCampaignScreen extends StatelessWidget {
  const MarketingCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final List<Campaign> _items = [
      Campaign(
          name: "Holiday Blast 2024",
          channel: "Email",
          status: "SCHEDULED",
          reach: 12500,
          budget: 1500),
      Campaign(
          name: "Summer Clearance",
          channel: "SMS",
          status: "ACTIVE",
          reach: 8400,
          budget: 2200),
      Campaign(
          name: "VIP Appreciation",
          channel: "Direct Mail",
          status: "COMPLETED",
          reach: 500,
          budget: 5000),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Marketing Campaigns".toUpperCase(),
          subtitle:
              "DESIGN, EXECUTE, AND ANALYZE MULTI-CHANNEL OUTREACH STRATEGIES.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.campaign),
              label: const Text("NEW CAMPAIGN"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Campaign>(
              items: _items,
              columns: [
                ZenoTableColumn(
                  label: "Campaign Name",
                  builder: (c) => Text(c.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Channel",
                  width: 150,
                  builder: (c) => Text(c.channel),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (c) => ZenoBadge(
                      label: c.status,
                      color: c.status == "ACTIVE"
                          ? colors.statusSuccess
                          : (c.status == "SCHEDULED"
                              ? colors.accentPrimary
                              : colors.textDisabled)),
                ),
                ZenoTableColumn(
                  label: "Reach",
                  width: 120,
                  isNumeric: true,
                  builder: (c) => Text(c.reach.toString(),
                      style: const TextStyle(fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Budget",
                  width: 120,
                  isNumeric: true,
                  builder: (c) => Text("\$${c.budget.toStringAsFixed(0)}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
