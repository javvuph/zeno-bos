import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class PriceList {
  final String name;
  final String currency;
  final String target;
  final bool isActive;

  PriceList(
      {required this.name,
      required this.currency,
      required this.target,
      this.isActive = true});
}

class PriceListManagementScreen extends StatelessWidget {
  const PriceListManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PriceList> items = [
      PriceList(
          name: "Standard Retail", currency: "USD", target: "B2C Customers"),
      PriceList(
          name: "Gold Wholesale", currency: "USD", target: "VIP Distributors"),
      PriceList(
          name: "Holiday Sale 2024",
          currency: "USD",
          target: "Flash Sale",
          isActive: false),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Price Lists",
          subtitle:
              "Manage multiple pricing tiers for different customer segments and channels.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Create Price List"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<PriceList>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Price List Name",
                  builder: (p) => Text(p.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Currency",
                  width: 100,
                  builder: (p) =>
                      Text(p.currency, style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Target Segment",
                  builder: (p) => Text(p.target,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 120,
                  builder: (p) => ZenoBadge(
                      label: p.isActive ? "Active" : "Inactive",
                      color: p.isActive
                          ? ZenoTheme.success
                          : ZenoTheme.textSecondary),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 120,
                  builder: (p) => Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 16),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.copy_outlined, size: 16),
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
