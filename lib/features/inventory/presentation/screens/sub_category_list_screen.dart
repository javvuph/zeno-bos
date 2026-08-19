import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class SubCategory {
  final String name;
  final String parentCategory;
  final int productCount;

  SubCategory(
      {required this.name,
      required this.parentCategory,
      required this.productCount});
}

class SubCategoryListScreen extends StatelessWidget {
  const SubCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SubCategory> items = [
      SubCategory(
          name: "Smartphones",
          parentCategory: "Electronics",
          productCount: 450),
      SubCategory(
          name: "Laptops", parentCategory: "Electronics", productCount: 320),
      SubCategory(
          name: "T-Shirts", parentCategory: "Fashion", productCount: 1200),
      SubCategory(
          name: "Dresses", parentCategory: "Fashion", productCount: 850),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Sub Categories",
          subtitle: "Granular classification of your product catalog.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Sub Category"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<SubCategory>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Sub Category",
                  builder: (s) => Text(s.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Parent Category",
                  builder: (s) => ZenoBadge(
                      label: s.parentCategory, color: ZenoTheme.accent),
                ),
                ZenoTableColumn(
                  label: "Products",
                  width: 120,
                  isNumeric: true,
                  builder: (s) => Text(s.productCount.toString(),
                      style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (s) => Row(
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
