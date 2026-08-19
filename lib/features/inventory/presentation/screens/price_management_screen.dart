import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class PriceEntry {
  final String sku;
  final String name;
  final double cost;
  final double retail;
  final double wholesale;

  PriceEntry(
      {required this.sku,
      required this.name,
      required this.cost,
      required this.retail,
      required this.wholesale});
}

class PriceManagementScreen extends StatelessWidget {
  final String focusType; // Cost, Retail, Wholesale

  const PriceManagementScreen({super.key, required this.focusType});

  @override
  Widget build(BuildContext context) {
    final List<PriceEntry> items = [
      PriceEntry(
          sku: "PHN-15-PRO",
          name: "iPhone 15 Pro",
          cost: 899.00,
          retail: 1199.00,
          wholesale: 1050.00),
      PriceEntry(
          sku: "LOG-MX-3S",
          name: "Logitech MX 3S",
          cost: 65.00,
          retail: 99.00,
          wholesale: 85.00),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "$focusType Price Management",
          subtitle:
              "Review and update $focusType prices for the entire catalog.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text("Bulk Edit")),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<PriceEntry>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Product",
                  builder: (p) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(p.sku,
                          style: const TextStyle(
                              fontSize: 11,
                              color: ZenoTheme.textSecondary,
                              fontFamily: 'monospace')),
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "Current Cost",
                  isNumeric: true,
                  builder: (p) => Text("\$${p.cost.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: focusType == "Cost"
                              ? ZenoTheme.accent
                              : ZenoTheme.textPrimary)),
                ),
                ZenoTableColumn(
                  label: "Retail Price",
                  isNumeric: true,
                  builder: (p) => Text("\$${p.retail.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: focusType == "Retail"
                              ? ZenoTheme.accent
                              : ZenoTheme.textPrimary)),
                ),
                ZenoTableColumn(
                  label: "Wholesale Price",
                  isNumeric: true,
                  builder: (p) => Text("\$${p.wholesale.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: focusType == "Wholesale"
                              ? ZenoTheme.accent
                              : ZenoTheme.textPrimary)),
                ),
                ZenoTableColumn(
                  label: "Margin %",
                  isNumeric: true,
                  builder: (p) => Text(
                      "${((p.retail - p.cost) / p.retail * 100).toStringAsFixed(1)}%",
                      style: const TextStyle(
                          color: ZenoTheme.success,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
