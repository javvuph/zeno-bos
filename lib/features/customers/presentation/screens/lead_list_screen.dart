import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class Lead {
  final String id;
  final String name;
  final String source;
  final String status;
  final double expectedValue;

  Lead(
      {required this.id,
      required this.name,
      required this.source,
      required this.status,
      required this.expectedValue});
}

class LeadListScreen extends StatelessWidget {
  const LeadListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final List<Lead> items = [
      Lead(
          id: "LD-2024-001",
          name: "Initech Corp",
          source: "Website",
          status: "NEW",
          expectedValue: 5000),
      Lead(
          id: "LD-2024-002",
          name: "Cyberdyne Systems",
          source: "Referral",
          status: "QUALIFIED",
          expectedValue: 12000),
      Lead(
          id: "LD-2024-003",
          name: "Weyland-Yutani",
          source: "Cold Call",
          status: "NEGOTIATION",
          expectedValue: 45000),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Leads & Opportunities".toUpperCase(),
          subtitle:
              "TRACK POTENTIAL CLIENTS, INBOUND INQUIRIES, AND STRATEGIC SALES OPPORTUNITIES.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("LOG NEW LEAD"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Lead>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Lead Identity",
                  builder: (l) => Text(l.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Origin Source",
                  width: 150,
                  builder: (l) => Text(l.source,
                      style: TextStyle(color: colors.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (l) =>
                      ZenoBadge(label: l.status, color: colors.accentPrimary),
                ),
                ZenoTableColumn(
                  label: "Est. Value",
                  width: 150,
                  isNumeric: true,
                  builder: (l) => Text(
                      "\$${l.expectedValue.toStringAsFixed(0)}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (l) => IconButton(
                      icon: const Icon(Icons.arrow_forward), onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
