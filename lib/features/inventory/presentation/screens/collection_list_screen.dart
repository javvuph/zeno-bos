import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class Collection {
  final String name;
  final String season;
  final int productCount;

  Collection(
      {required this.name, required this.season, required this.productCount});
}

class CollectionListScreen extends StatelessWidget {
  const CollectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Collection> items = [
      Collection(name: "Summer 2024", season: "Summer", productCount: 45),
      Collection(
          name: "Winter Essentials", season: "Winter", productCount: 120),
      Collection(
          name: "Limited Edition - Red",
          season: "All-Season",
          productCount: 12),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Collections",
          subtitle: "Seasonal or thematic groupings of products.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Create Collection"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Collection>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Collection Name",
                  builder: (c) => Text(c.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Season",
                  width: 150,
                  builder: (c) =>
                      ZenoBadge(label: c.season, color: ZenoTheme.neonCyan),
                ),
                ZenoTableColumn(
                  label: "Products",
                  width: 120,
                  isNumeric: true,
                  builder: (c) => Text(c.productCount.toString(),
                      style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (c) => Row(
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
