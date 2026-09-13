import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class CustomAttribute {
  final String name;
  final String type;
  final bool isRequired;

  CustomAttribute(
      {required this.name, required this.type, this.isRequired = false});
}

class CustomAttributeListScreen extends StatelessWidget {
  const CustomAttributeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CustomAttribute> items = [
      CustomAttribute(name: "Internal Notes", type: "Rich Text"),
      CustomAttribute(name: "Warranty Period", type: "Numeric (Months)"),
      CustomAttribute(
          name: "Is Eco-Friendly", type: "Boolean", isRequired: true),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Custom Attributes",
          subtitle:
              "Extend the product data model with industry-specific fields.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Create Attribute"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<CustomAttribute>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Attribute Name",
                  builder: (a) => Text(a.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Data Type",
                  width: 150,
                  builder: (a) =>
                      ZenoBadge(label: a.type, color: ZenoTheme.accent),
                ),
                ZenoTableColumn(
                  label: "Required",
                  width: 120,
                  builder: (a) => Icon(
                      a.isRequired
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 16,
                      color: a.isRequired
                          ? ZenoTheme.success
                          : ZenoTheme.textSecondary),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (a) => Row(
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
