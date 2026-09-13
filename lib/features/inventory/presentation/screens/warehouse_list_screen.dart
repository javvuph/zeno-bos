import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/inventory_controller.dart';
import '../../domain/models/warehouse.dart' as domain;

class WarehouseListScreen extends StatefulWidget {
  const WarehouseListScreen({super.key});

  @override
  State<WarehouseListScreen> createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  late final InventoryController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<InventoryController>();
    controller.addListener(_onUpdate);
    controller.refreshAll();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final warehouses = controller.warehouses;

    return Column(
      children: [
        ZenoHeader(
          title: "Warehouse Management",
          subtitle: "Define and organize your physical storage locations.",
          onSearch: (v) {},
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add Warehouse"),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accentPrimary,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<domain.Warehouse>(
              items: warehouses,
              columns: [
                ZenoTableColumn(
                  label: "Warehouse Name",
                  builder: (w) => Text(w.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Location",
                  builder: (w) => Text(w.address ?? "GLOBAL",
                      style:
                          TextStyle(fontSize: 13, color: colors.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Type",
                  width: 180,
                  builder: (w) =>
                      ZenoBadge(label: "Standard", color: colors.accentPrimary),
                ),
                ZenoTableColumn(
                  label: "Code",
                  width: 120,
                  builder: (w) => Text(w.id.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 13, fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (w) => Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.settings_outlined,
                              size: 16, color: colors.textSecondary),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.edit_outlined,
                              size: 16, color: colors.textSecondary),
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
