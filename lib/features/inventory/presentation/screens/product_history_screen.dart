import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class AuditEntry {
  final String date;
  final String user;
  final String action;
  final String field;
  final String oldValue;
  final String newValue;

  AuditEntry({
    required this.date,
    required this.user,
    required this.action,
    required this.field,
    required this.oldValue,
    required this.newValue,
  });
}

class ProductHistoryScreen extends StatelessWidget {
  const ProductHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AuditEntry> history = [
      AuditEntry(
          date: "Oct 24, 11:20 AM",
          user: "Alex R.",
          action: "Update",
          field: "Selling Price",
          oldValue: "\$899.00",
          newValue: "\$999.00"),
      AuditEntry(
          date: "Oct 23, 04:15 PM",
          user: "System",
          action: "Inventory",
          field: "Stock Level",
          oldValue: "120",
          newValue: "115"),
      AuditEntry(
          date: "Oct 22, 09:30 AM",
          user: "Maria S.",
          action: "Update",
          field: "Description",
          oldValue: "Old desc...",
          newValue: "New detailed desc..."),
      AuditEntry(
          date: "Oct 20, 10:00 AM",
          user: "Alex R.",
          action: "Create",
          field: "Product",
          oldValue: "-",
          newValue: "New Product Created"),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Product Audit History",
          subtitle:
              "Full traceability of every change made to the product catalog.",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<AuditEntry>(
              items: history,
              columns: [
                ZenoTableColumn(
                  label: "Timestamp",
                  width: 180,
                  builder: (e) => Text(e.date,
                      style: const TextStyle(
                          fontSize: 12, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "User",
                  width: 120,
                  builder: (e) => Row(
                    children: [
                      const CircleAvatar(
                          radius: 10,
                          backgroundColor: ZenoTheme.accent,
                          child: Text("A",
                              style:
                                  TextStyle(fontSize: 8, color: Colors.white))),
                      const SizedBox(width: 8),
                      Text(e.user,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "Action",
                  width: 120,
                  builder: (e) => ZenoBadge(
                    label: e.action,
                    color: e.action == "Create"
                        ? ZenoTheme.success
                        : (e.action == "Update"
                            ? ZenoTheme.accent
                            : ZenoTheme.warning),
                  ),
                ),
                ZenoTableColumn(
                  label: "Field Modified",
                  width: 150,
                  builder: (e) => Text(e.field,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                ),
                ZenoTableColumn(
                  label: "Old Value",
                  builder: (e) => Text(e.oldValue,
                      style: const TextStyle(
                          fontSize: 12,
                          color: ZenoTheme.textSecondary,
                          decoration: TextDecoration.lineThrough)),
                ),
                ZenoTableColumn(
                  label: "New Value",
                  builder: (e) => Text(e.newValue,
                      style: const TextStyle(
                          fontSize: 12,
                          color: ZenoTheme.neonCyan,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
