import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class CountSession {
  final String id;
  final String warehouse;
  final String status;
  final String date;

  CountSession(
      {required this.id,
      required this.warehouse,
      required this.status,
      required this.date});
}

class PhysicalCountScreen extends StatelessWidget {
  const PhysicalCountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final List<CountSession> items = [
      CountSession(
          id: "CNT-2024-001",
          warehouse: "Main Warehouse",
          status: "IN PROGRESS",
          date: "Aug 05, 2026"),
      CountSession(
          id: "CNT-2024-002",
          warehouse: "Secondary WH",
          status: "COMPLETED",
          date: "Jul 28, 2026"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Physical Stock Count".toUpperCase(),
          subtitle:
              "INITIATE AND MANAGE INVENTORY AUDITS TO RECONCILE PHYSICAL STOCK WITH SYSTEM RECORDS.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text("START NEW COUNT"),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accentPrimary,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<CountSession>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Session ID",
                  builder: (s) => Text(s.id,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Warehouse",
                  width: 250,
                  builder: (s) => Text(s.warehouse,
                      style: TextStyle(color: colors.textPrimary)),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 180,
                  builder: (s) => ZenoBadge(
                    label: s.status,
                    color: s.status == "COMPLETED"
                        ? colors.statusSuccess
                        : colors.statusWarning,
                  ),
                ),
                ZenoTableColumn(
                  label: "Date",
                  width: 150,
                  builder: (s) => Text(s.date,
                      style: TextStyle(color: colors.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 140,
                  builder: (s) => TextButton(
                      onPressed: () {},
                      child: Text(
                        s.status == "COMPLETED"
                            ? "VIEW REPORT"
                            : "RESUME COUNT",
                        style: TextStyle(
                            color: colors.accentPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
