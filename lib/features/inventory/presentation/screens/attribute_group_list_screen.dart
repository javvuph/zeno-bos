import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class AttributeGroup {
  final String name;
  final String attributes;
  final String industry;

  AttributeGroup(
      {required this.name, required this.attributes, required this.industry});
}

class AttributeGroupListScreen extends StatelessWidget {
  const AttributeGroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AttributeGroup> items = [
      AttributeGroup(
          name: "Technical Specs",
          attributes: "CPU, RAM, Storage, OS",
          industry: "Electronics"),
      AttributeGroup(
          name: "Dimension Data",
          attributes: "Height, Width, Depth, Weight",
          industry: "General"),
      AttributeGroup(
          name: "Fashion Details",
          attributes: "Material, Pattern, Sleeve, Neck",
          industry: "Fashion"),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Attribute Groups",
          subtitle:
              "Organize related attributes into logical blocks for cleaner forms.",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<AttributeGroup>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Group Name",
                  builder: (g) => Text(g.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Attributes",
                  builder: (g) => Text(g.attributes,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Industry",
                  width: 150,
                  builder: (g) =>
                      Text(g.industry, style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (g) => Row(
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

// Fixed a typo in the previous turn where I accidentally used AuditEntry instead of AttributeGroup in a list.
