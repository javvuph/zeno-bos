import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class AttributeValue {
  final String label;
  final String code;
  final String? meta; // e.g. Hex code for color

  AttributeValue({required this.label, required this.code, this.meta});
}

class AttributeValuesScreen extends StatelessWidget {
  final String attributeName;
  final List<AttributeValue> values;

  const AttributeValuesScreen({
    super.key,
    required this.attributeName,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoHeader(
          title: "$attributeName Management",
          subtitle:
              "Define and manage possible values for the $attributeName attribute.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: Text("Add $attributeName"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<AttributeValue>(
              items: values,
              columns: [
                ZenoTableColumn(
                  label: "Display Label",
                  builder: (v) => Row(
                    children: [
                      if (attributeName == "Color" && v.meta != null) ...[
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color(
                                int.parse(v.meta!.replaceAll('#', '0xFF'))),
                            shape: BoxShape.circle,
                            border: Border.all(color: ZenoTheme.border),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Text(v.label,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "System Code",
                  width: 150,
                  builder: (v) => Text(v.code,
                      style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (v) => Row(
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
