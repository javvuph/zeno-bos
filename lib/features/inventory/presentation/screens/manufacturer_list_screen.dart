import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class Manufacturer {
  final String name;
  final String location;
  final String contact;

  Manufacturer(
      {required this.name, required this.location, required this.contact});
}

class ManufacturerListScreen extends StatelessWidget {
  const ManufacturerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Manufacturer> items = [
      Manufacturer(
          name: "Foxconn", location: "Taiwan", contact: "contact@foxconn.com"),
      Manufacturer(name: "TSMC", location: "Taiwan", contact: "info@tsmc.com"),
      Manufacturer(
          name: "Intel", location: "USA", contact: "support@intel.com"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Manufacturers",
          subtitle: "Directory of entities that produce your inventory.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Manufacturer"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Manufacturer>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Manufacturer",
                  builder: (m) => Text(m.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Location",
                  width: 150,
                  builder: (m) => Text(m.location,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Contact",
                  builder: (m) => Text(m.contact,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.accent)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (m) => Row(
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
