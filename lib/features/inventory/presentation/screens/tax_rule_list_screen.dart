import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class TaxRule {
  final String name;
  final double rate;
  final String region;
  final bool isDefault;

  TaxRule(
      {required this.name,
      required this.rate,
      required this.region,
      this.isDefault = false});
}

class TaxRuleListScreen extends StatelessWidget {
  const TaxRuleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TaxRule> items = [
      TaxRule(
          name: "Standard VAT",
          rate: 15.0,
          region: "Global (Default)",
          isDefault: true),
      TaxRule(name: "US Sales Tax", rate: 7.5, region: "North America"),
      TaxRule(name: "EU Digital Tax", rate: 21.0, region: "European Union"),
      TaxRule(name: "Zero Rated", rate: 0.0, region: "Global"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Tax Rules",
          subtitle:
              "Configure regional tax rates and industry-specific tax categories.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Tax Rule"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<TaxRule>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Rule Name",
                  builder: (t) => Row(
                    children: [
                      Text(t.name,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      if (t.isDefault) ...[
                        const SizedBox(width: 8),
                        const ZenoBadge(
                            label: "Default", color: ZenoTheme.success),
                      ],
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "Rate",
                  width: 100,
                  isNumeric: true,
                  builder: (t) => Text("${t.rate}%",
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: ZenoTheme.neonCyan)),
                ),
                ZenoTableColumn(
                  label: "Region",
                  width: 200,
                  builder: (t) => Text(t.region,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
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
