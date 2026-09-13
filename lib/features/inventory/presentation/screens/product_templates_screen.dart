import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class ProductTemplate {
  final String name;
  final String industry;
  final int attributeCount;
  final String lastUsed;

  ProductTemplate({
    required this.name,
    required this.industry,
    required this.attributeCount,
    required this.lastUsed,
  });
}

class ProductTemplatesScreen extends StatelessWidget {
  const ProductTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductTemplate> templates = [
      ProductTemplate(
          name: "Standard Smartphone",
          industry: "Electronics",
          attributeCount: 12,
          lastUsed: "2 hours ago"),
      ProductTemplate(
          name: "Gaming Laptop",
          industry: "Electronics",
          attributeCount: 18,
          lastUsed: "1 day ago"),
      ProductTemplate(
          name: "Basic T-Shirt",
          industry: "Fashion",
          attributeCount: 8,
          lastUsed: "3 days ago"),
      ProductTemplate(
          name: "Premium Watch",
          industry: "Luxury",
          attributeCount: 15,
          lastUsed: "1 week ago"),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Product Templates",
          subtitle:
              "Standardized blueprints for creating products with predefined attributes.",
          actions: [
            _HeaderButton(
                label: "Create Template", icon: Icons.add, isPrimary: true),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<ProductTemplate>(
              items: templates,
              columns: [
                ZenoTableColumn(
                  label: "Template Name",
                  builder: (t) => Text(t.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Industry",
                  width: 150,
                  builder: (t) =>
                      ZenoBadge(label: t.industry, color: ZenoTheme.accent),
                ),
                ZenoTableColumn(
                  label: "Attributes",
                  width: 120,
                  isNumeric: true,
                  builder: (t) => Text("${t.attributeCount} fields",
                      style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Last Used",
                  width: 150,
                  builder: (t) => Text(t.lastUsed,
                      style: const TextStyle(
                          fontSize: 12, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 120,
                  builder: (t) => Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text("Use",
                              style: TextStyle(fontSize: 12))),
                      IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 16),
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

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;

  const _HeaderButton(
      {required this.label, required this.icon, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? ZenoTheme.accent : ZenoTheme.surface,
        foregroundColor: Colors.white,
        side: isPrimary ? null : const BorderSide(color: ZenoTheme.border),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
