import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class StorageLocation {
  final String code;
  final String parent;
  final String status;

  StorageLocation(
      {required this.code, required this.parent, required this.status});
}

class LocationManagementScreen extends StatelessWidget {
  final String locationType; // Shelves, Bins, Zones

  const LocationManagementScreen({super.key, required this.locationType});

  @override
  Widget build(BuildContext context) {
    final List<StorageLocation> items = [
      StorageLocation(code: "ZONE-A", parent: "Main WH", status: "Active"),
      StorageLocation(code: "SHELF-01", parent: "ZONE-A", status: "Active"),
      StorageLocation(code: "BIN-A101", parent: "SHELF-01", status: "Full"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "$locationType Management",
          subtitle:
              "Define hierarchy and physical addresses for inventory within warehouses.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: Text("Add $locationType")),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<StorageLocation>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "$locationType Code",
                  builder: (l) => Text(l.code,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Parent Location",
                  width: 200,
                  builder: (l) => Text(l.parent,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (l) => Text(l.status,
                      style: TextStyle(
                          fontSize: 12,
                          color: l.status == "Active"
                              ? ZenoTheme.success
                              : ZenoTheme.warning,
                          fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (l) => Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 16),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.delete_outline, size: 16),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
