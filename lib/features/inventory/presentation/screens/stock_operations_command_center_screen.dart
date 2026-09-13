import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/inventory_transaction.dart';
import '../manifests/stock_operations_workspace_manifest.dart';

class StockOperationsCommandCenterScreen extends StatefulWidget {
  const StockOperationsCommandCenterScreen({super.key});

  @override
  State<StockOperationsCommandCenterScreen> createState() =>
      _StockOperationsCommandCenterScreenState();
}

class _StockOperationsCommandCenterScreenState
    extends State<StockOperationsCommandCenterScreen> {
  InventoryTransaction? _selectedTx;
  final manifest = const StockOperationsWorkspaceManifest();

  // Mock data utilizing the new ITE Standard Transaction Model
  final List<InventoryTransaction> items = [
    InventoryTransaction(
      id: 'TXN-8812A',
      type: InventoryTransactionType.purchaseReceipt,
      timestamp: DateTime.now(),
      productId: 'p1',
      warehouseId: 'WH-MAIN',
      quantity: 500,
      unitId: 'u_pc',
      userId: 'USER-01',
      branchId: 'B-NORTH',
      referenceDocument: 'PO-99210',
    ),
    InventoryTransaction(
      id: 'TXN-9912B',
      type: InventoryTransactionType.stockTransfer,
      timestamp: DateTime.now(),
      productId: 'p2',
      warehouseId: 'WH-RETAIL',
      quantity: -50,
      unitId: 'u_pc',
      userId: 'USER-01',
      branchId: 'B-NORTH',
      referenceDocument: 'TRS-4412',
    ),
    InventoryTransaction(
      id: 'TXN-1123C',
      type: InventoryTransactionType.damagedStock,
      timestamp: DateTime.now(),
      productId: 'p1',
      warehouseId: 'WH-MAIN',
      quantity: -5,
      unitId: 'u_pc',
      userId: 'MANAGER-A',
      branchId: 'B-NORTH',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedTx),
        isVisible: _selectedTx != null,
        onClose: () => setState(() => _selectedTx = null),
      ),
      body: ZenoTable<InventoryTransaction>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedTx != null ? [_selectedTx!] : [],
        onRowTap: (tx) => setState(() => _selectedTx = tx),
      ),
    );
  }
}
