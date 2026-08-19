import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/product_variant.dart';
import '../../domain/models/sku.dart';
import '../manifests/variants_workspace_manifest.dart';

class VariantsCommandCenterScreen extends StatefulWidget {
  const VariantsCommandCenterScreen({super.key});

  @override
  State<VariantsCommandCenterScreen> createState() =>
      _VariantsCommandCenterScreenState();
}

class _VariantsCommandCenterScreenState
    extends State<VariantsCommandCenterScreen> {
  ProductVariant? _selectedVariant;
  final manifest = const VariantsWorkspaceManifest();

  // Mock data for initial implementation
  final List<ProductVariant> items = [
    const ProductVariant(
        id: 'v1',
        productId: 'p1',
        sku: SKU('TSHIRT-XL-BLU'),
        attributes: {'Size': 'XL', 'Color': 'Blue'},
        stockLevel: 45),
    const ProductVariant(
        id: 'v2',
        productId: 'p1',
        sku: SKU('TSHIRT-L-RED'),
        attributes: {'Size': 'L', 'Color': 'Red'},
        stockLevel: 12),
    const ProductVariant(
        id: 'v3',
        productId: 'p2',
        sku: SKU('IPHN-256-IND'),
        attributes: {'Storage': '256GB', 'Color': 'Indigo'},
        stockLevel: 8),
  ];

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedVariant),
        isVisible: _selectedVariant != null,
        onClose: () => setState(() => _selectedVariant = null),
      ),
      body: ZenoTable<ProductVariant>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedVariant != null ? [_selectedVariant!] : [],
        onRowTap: (v) => setState(() => _selectedVariant = v),
      ),
    );
  }
}
