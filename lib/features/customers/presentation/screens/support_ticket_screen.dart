import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class SupportTicket {
  final String id;
  final String customer;
  final String subject;
  final String priority;
  final String status;

  SupportTicket(
      {required this.id,
      required this.customer,
      required this.subject,
      required this.priority,
      required this.status});
}

class SupportTicketScreen extends StatelessWidget {
  const SupportTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final List<SupportTicket> _items = [
      SupportTicket(
          id: "TKT-5521",
          customer: "Alex Rivera",
          subject: "Delayed Delivery #ORD-882",
          priority: "HIGH",
          status: "OPEN"),
      SupportTicket(
          id: "TKT-5520",
          customer: "Samantha Lee",
          subject: "Billing Discrepancy",
          priority: "MEDIUM",
          status: "IN PROGRESS"),
      SupportTicket(
          id: "TKT-5519",
          customer: "John Doe",
          subject: "Product Support: X-Series",
          priority: "LOW",
          status: "CLOSED"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Customer Support & Claims".toUpperCase(),
          subtitle:
              "MANAGE SERVICE TICKETS, WARRANTY CLAIMS, AND AFTER-SALES ENGAGEMENT.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("NEW TICKET"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<SupportTicket>(
              items: _items,
              columns: [
                ZenoTableColumn(
                  label: "Ticket ID",
                  width: 120,
                  builder: (t) => Text(t.id,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Customer",
                  width: 180,
                  builder: (t) => Text(t.customer),
                ),
                ZenoTableColumn(
                  label: "Issue Subject",
                  builder: (t) => Text(t.subject,
                      style: TextStyle(color: colors.textPrimary)),
                ),
                ZenoTableColumn(
                  label: "Priority",
                  width: 120,
                  builder: (t) =>
                      _PriorityBadge(priority: t.priority, colors: colors),
                ),
                ZenoTableColumn(
                  label: "State",
                  width: 150,
                  builder: (t) => ZenoBadge(
                      label: t.status,
                      color: t.status == "OPEN"
                          ? colors.statusDanger
                          : (t.status == "CLOSED"
                              ? colors.statusSuccess
                              : colors.statusWarning)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;
  final ZenoSemanticColors colors;
  const _PriorityBadge({required this.priority, required this.colors});

  @override
  Widget build(BuildContext context) {
    Color color = colors.statusSuccess;
    if (priority == "HIGH") color = colors.statusDanger;
    if (priority == "MEDIUM") color = colors.statusWarning;

    return Row(
      children: [
        Icon(Icons.circle, size: 8, color: color),
        const SizedBox(width: 8),
        Text(priority,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 10)),
      ],
    );
  }
}
