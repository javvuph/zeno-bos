import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/inventory_ledger_entry.dart';
import '../manifests/inventory_intelligence_workspace_manifest.dart';

class InventoryIntelligenceCommandCenterScreen extends StatefulWidget {
  const InventoryIntelligenceCommandCenterScreen({super.key});

  @override
  State<InventoryIntelligenceCommandCenterScreen> createState() =>
      _InventoryIntelligenceCommandCenterScreenState();
}

class _InventoryIntelligenceCommandCenterScreenState
    extends State<InventoryIntelligenceCommandCenterScreen> {
  InventoryLedgerEntry? _selectedEntry;
  final manifest = const InventoryIntelligenceWorkspaceManifest();

  // Mock data utilizing the Inventory Ledger (IL) standard
  final List<InventoryLedgerEntry> items = [
    InventoryLedgerEntry(
      id: 'IL-9921',
      productId: 'iPhone 15 Pro',
      warehouseId: 'WH-MAIN',
      quantityOnHand: 42,
      averageCost: 89000,
      lastMovementDate: DateTime.now(),
      lastTransactionId: 'TX-100',
    ),
    InventoryLedgerEntry(
      id: 'IL-9922',
      productId: 'Logitech MX 3S',
      warehouseId: 'WH-MAIN',
      quantityOnHand: 112,
      averageCost: 8500,
      lastMovementDate: DateTime.now(),
      lastTransactionId: 'TX-101',
    ),
    InventoryLedgerEntry(
      id: 'IL-9923',
      productId: 'MacBook Air M3',
      warehouseId: 'WH-NORTH',
      quantityOnHand: 15,
      averageCost: 115000,
      lastMovementDate: DateTime.now(),
      lastTransactionId: 'TX-102',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedEntry),
        isVisible: _selectedEntry != null,
        onClose: () => setState(() => _selectedEntry = null),
      ),
      body: ZenoTable<InventoryLedgerEntry>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedEntry != null ? [_selectedEntry!] : [],
        onRowTap: (e) => setState(() => _selectedEntry = e),
      ),
    );
  }
}
