import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

class UnitOfMeasure {
  final String name;
  final String symbol;
  final String baseUnit;

  UnitOfMeasure(
      {required this.name, required this.symbol, required this.baseUnit});
}

class UnitListScreen extends StatelessWidget {
  const UnitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UnitOfMeasure> items = [
      UnitOfMeasure(name: "Kilogram", symbol: "kg", baseUnit: "Weight"),
      UnitOfMeasure(name: "Gram", symbol: "g", baseUnit: "Weight"),
      UnitOfMeasure(name: "Liter", symbol: "L", baseUnit: "Volume"),
      UnitOfMeasure(name: "Piece", symbol: "pc", baseUnit: "Count"),
      UnitOfMeasure(name: "Box (12pcs)", symbol: "box-12", baseUnit: "Count"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Units of Measure",
          subtitle:
              "Define how your products are weighed, measured, or counted.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Unit"),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<UnitOfMeasure>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Unit Name",
                  builder: (u) => Text(u.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Symbol",
                  width: 100,
                  builder: (u) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: ZenoTheme.card,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ZenoTheme.border)),
                    child: Text(u.symbol,
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            color: ZenoTheme.neonCyan)),
                  ),
                ),
                ZenoTableColumn(
                  label: "Measurement Type",
                  width: 150,
                  builder: (u) => Text(u.baseUnit,
                      style: const TextStyle(
                          fontSize: 13, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (u) => Row(
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
