import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../manifests/barcode_studio_workspace_manifest.dart';

class BarcodeStudioCommandCenterScreen extends StatefulWidget {
  const BarcodeStudioCommandCenterScreen({super.key});

  @override
  State<BarcodeStudioCommandCenterScreen> createState() =>
      _BarcodeStudioCommandCenterScreenState();
}

class _BarcodeStudioCommandCenterScreenState
    extends State<BarcodeStudioCommandCenterScreen> {
  late final ProductController controller;
  Product? _selectedItem;
  final manifest = const BarcodeStudioWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = ProductController(sl<IProductRepository>());
    controller.addListener(_onUpdate);
    controller.refreshProducts();
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
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      isLoading: controller.isLoading,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedItem),
        isVisible: _selectedItem != null,
        onClose: () => setState(() => _selectedItem = null),
      ),
      body: ZenoTable<Product>(
        items: controller.allProducts,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedItem != null ? [_selectedItem!] : [],
        onRowTap: (p) => setState(() => _selectedItem = p),
      ),
    );
  }
}
