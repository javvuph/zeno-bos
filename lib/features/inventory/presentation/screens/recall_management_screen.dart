import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class RecallCase {
  final String id;
  final String reason;
  final String severity;
  final String status;

  RecallCase(
      {required this.id,
      required this.reason,
      required this.severity,
      required this.status});
}

class RecallManagementScreen extends StatelessWidget {
  const RecallManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RecallCase> items = [
      RecallCase(
          id: "REC-001",
          reason: "Labeling Error",
          severity: "Low",
          status: "Active"),
      RecallCase(
          id: "REC-002",
          reason: "Contamination Risk",
          severity: "High",
          status: "Urgent"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Recall Management",
          subtitle:
              "Emergency protocols for identifying and isolating defective batches.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.warning_amber),
              label: const Text("Initiate Recall"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: ZenoTheme.danger),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<RecallCase>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Recall ID",
                  builder: (r) => Text(r.id,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Reason",
                  builder: (r) => Text(r.reason),
                ),
                ZenoTableColumn(
                  label: "Severity",
                  width: 120,
                  builder: (r) => ZenoBadge(
                      label: r.severity,
                      color: r.severity == "High"
                          ? ZenoTheme.danger
                          : ZenoTheme.warning),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (r) => Text(r.status,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: r.status == "Urgent"
                              ? ZenoTheme.danger
                              : ZenoTheme.accent)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (r) => TextButton(
                      onPressed: () {}, child: const Text("Isolate")),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
