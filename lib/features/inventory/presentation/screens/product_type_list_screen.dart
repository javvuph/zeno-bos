import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class ProductType {
  final String name;
  final String taxCategory;
  final bool isPhysical;

  ProductType(
      {required this.name, required this.taxCategory, this.isPhysical = true});
}

class ProductTypeListScreen extends StatelessWidget {
  const ProductTypeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductType> items = [
      ProductType(name: "Finished Good", taxCategory: "Standard"),
      ProductType(name: "Raw Material", taxCategory: "Industrial"),
      ProductType(
          name: "Service / Labor", taxCategory: "Services", isPhysical: false),
      ProductType(
          name: "Digital Asset", taxCategory: "Digital", isPhysical: false),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Product Types",
          subtitle:
              "Define high-level classifications for tax and fulfillment logic.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Type"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<ProductType>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Type Name",
                  builder: (t) => Text(t.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Tax Category",
                  width: 150,
                  builder: (t) => Text(t.taxCategory,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Fulfillment",
                  width: 150,
                  builder: (t) => Text(t.isPhysical ? "Physical" : "Virtual",
                      style: TextStyle(
                          fontSize: 12,
                          color: t.isPhysical
                              ? ZenoTheme.success
                              : ZenoTheme.accent)),
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
