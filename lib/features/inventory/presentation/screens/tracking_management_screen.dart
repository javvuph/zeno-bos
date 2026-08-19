import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class TrackingEntry {
  final String code;
  final String product;
  final String date;
  final String expiry;
  final int stock;

  TrackingEntry(
      {required this.code,
      required this.product,
      required this.date,
      required this.expiry,
      required this.stock});
}

class TrackingManagementScreen extends StatelessWidget {
  final String trackingType; // Batch, Serial

  const TrackingManagementScreen({super.key, required this.trackingType});

  @override
  Widget build(BuildContext context) {
    final List<TrackingEntry> items = [
      TrackingEntry(
          code: "BCH-2024-001",
          product: "Organic Milk 1L",
          date: "Oct 20, 2024",
          expiry: "Oct 30, 2024",
          stock: 500),
      TrackingEntry(
          code: "BCH-2024-002",
          product: "Greek Yogurt 500g",
          date: "Oct 22, 2024",
          expiry: "Nov 05, 2024",
          stock: 250),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "$trackingType Management",
          subtitle:
              "Track inventory by $trackingType numbers for quality control and compliance.",
          onSearch: (v) {},
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<TrackingEntry>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "$trackingType Number",
                  builder: (t) => Text(t.code,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Product",
                  builder: (t) =>
                      Text(t.product, style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "MFG Date",
                  width: 150,
                  builder: (t) => Text(t.date,
                      style: const TextStyle(
                          fontSize: 12, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Expiry Date",
                  width: 150,
                  builder: (t) => Text(t.expiry,
                      style: const TextStyle(
                          fontSize: 12,
                          color: ZenoTheme.danger,
                          fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "In Stock",
                  width: 100,
                  isNumeric: true,
                  builder: (t) => Text(t.stock.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 80,
                  builder: (t) => IconButton(
                      icon: const Icon(Icons.history_outlined, size: 18),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
