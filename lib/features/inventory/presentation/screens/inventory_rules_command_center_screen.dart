import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/inventory_rule.dart';
import '../manifests/inventory_rules_workspace_manifest.dart';

class InventoryRulesCommandCenterScreen extends StatefulWidget {
  const InventoryRulesCommandCenterScreen({super.key});

  @override
  State<InventoryRulesCommandCenterScreen> createState() =>
      _InventoryRulesCommandCenterScreenState();
}

class _InventoryRulesCommandCenterScreenState
    extends State<InventoryRulesCommandCenterScreen> {
  InventoryRule? _selectedRule;
  final manifest = const InventoryRulesWorkspaceManifest();

  // Mock data for initial implementation
  final List<InventoryRule> items = [
    const InventoryRule(
      id: 'RULE-001',
      name: 'Strict Expiry Control',
      type: InventoryRuleType.tracking,
      requiresBatch: true,
      requiresExpiry: true,
      stockPolicy: StockPolicy.fefo,
      description:
          "Mandatory batch and expiry tracking for all medical supplies.",
    ),
    const InventoryRule(
      id: 'RULE-002',
      name: 'Electronic Serial Mapping',
      type: InventoryRuleType.tracking,
      requiresSerial: true,
      requiresWarranty: true,
      description: "Unique serial number required for every high-value unit.",
    ),
    const InventoryRule(
      id: 'RULE-003',
      name: 'Boutique Flex Policy',
      type: InventoryRuleType.logic,
      isGlobal: true,
      allowNegativeStock: true,
      description:
          "Allowing counter-service sales even if stock is pending sync.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedRule),
        isVisible: _selectedRule != null,
        onClose: () => setState(() => _selectedRule = null),
      ),
      body: ZenoTable<InventoryRule>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedRule != null ? [_selectedRule!] : [],
        onRowTap: (r) => setState(() => _selectedRule = r),
      ),
    );
  }
}
