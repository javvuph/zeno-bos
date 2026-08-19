import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class Brand {
  final String name;
  final String country;
  final int productCount;

  Brand(
      {required this.name, required this.country, required this.productCount});
}

class BrandListScreen extends StatelessWidget {
  const BrandListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Brand> items = [
      Brand(name: "Apple", country: "USA", productCount: 150),
      Brand(name: "Samsung", country: "South Korea", productCount: 280),
      Brand(name: "Sony", country: "Japan", productCount: 120),
      Brand(name: "Nike", country: "USA", productCount: 450),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Brands",
          subtitle: "Manage brand identities associated with your products.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Brand"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Brand>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Brand Name",
                  builder: (b) => Row(
                    children: [
                      Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              color: ZenoTheme.card,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(Icons.branding_watermark,
                              size: 12, color: ZenoTheme.textSecondary)),
                      const SizedBox(width: 12),
                      Text(b.name,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "Origin",
                  width: 150,
                  builder: (b) => Text(b.country,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Products",
                  width: 120,
                  isNumeric: true,
                  builder: (b) => Text(b.productCount.toString(),
                      style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (b) => Row(
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
