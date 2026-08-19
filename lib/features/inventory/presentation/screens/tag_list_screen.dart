import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class InventoryTag {
  final String name;
  final Color color;
  final int usageCount;

  InventoryTag(
      {required this.name, required this.color, required this.usageCount});
}

class TagListScreen extends StatelessWidget {
  const TagListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InventoryTag> items = [
      InventoryTag(
          name: "Best Seller", color: ZenoTheme.accent, usageCount: 150),
      InventoryTag(name: "Fragile", color: ZenoTheme.danger, usageCount: 45),
      InventoryTag(
          name: "New Arrival", color: ZenoTheme.success, usageCount: 88),
      InventoryTag(
          name: "Refurbished", color: ZenoTheme.warning, usageCount: 23),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Inventory Tags",
          subtitle:
              "Label your products with custom metadata for easy filtering.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Create Tag"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<InventoryTag>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Tag",
                  builder: (t) => ZenoBadge(label: t.name, color: t.color),
                ),
                ZenoTableColumn(
                  label: "Usage Count",
                  width: 150,
                  isNumeric: true,
                  builder: (t) => Text("${t.usageCount} products",
                      style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (t) => Row(
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
