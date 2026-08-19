import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/warehouse.dart';
import '../manifests/warehouses_workspace_manifest.dart';

class WarehouseCommandCenterScreen extends StatefulWidget {
  const WarehouseCommandCenterScreen({super.key});

  @override
  State<WarehouseCommandCenterScreen> createState() =>
      _WarehouseCommandCenterScreenState();
}

class _WarehouseCommandCenterScreenState
    extends State<WarehouseCommandCenterScreen> {
  Warehouse? _selectedWarehouse;
  final manifest = const WarehousesWorkspaceManifest();

  // Mock data for initial implementation
  final List<Warehouse> items = [
    const Warehouse(
        id: 'WH-001',
        name: 'Main HQ Depot',
        isActive: true,
        zones: [WarehouseZone(id: 'z1', name: 'Electronics')]),
    const Warehouse(
        id: 'WH-002',
        name: 'North Retail Backroom',
        isActive: true,
        zones: [WarehouseZone(id: 'z2', name: 'Daily Goods')]),
    const Warehouse(
        id: 'WH-003',
        name: 'South Cold Storage',
        isActive: true,
        zones: [
          WarehouseZone(
              id: 'z3', name: 'Perishables', hasTemperatureControl: true)
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedWarehouse),
        isVisible: _selectedWarehouse != null,
        onClose: () => setState(() => _selectedWarehouse = null),
      ),
      body: ZenoTable<Warehouse>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedWarehouse != null ? [_selectedWarehouse!] : [],
        onRowTap: (w) => setState(() => _selectedWarehouse = w),
      ),
    );
  }
}
