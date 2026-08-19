import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../manifests/products_workspace_manifest.dart';

class ProductCommandCenterScreen extends StatefulWidget {
  const ProductCommandCenterScreen({super.key});

  @override
  State<ProductCommandCenterScreen> createState() =>
      _ProductCommandCenterScreenState();
}

class _ProductCommandCenterScreenState
    extends State<ProductCommandCenterScreen> {
  late final ProductController controller;
  Product? _selectedProduct;
  final manifest = const ProductsWorkspaceManifest();

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
        title: _selectedProduct?.name,
        subtitle: _selectedProduct?.sku.value,
        tabs: manifest.inspectorTabs(context, _selectedProduct),
        isVisible: _selectedProduct != null,
        onClose: () => setState(() => _selectedProduct = null),
      ),
      body: ZenoTable<Product>(
        items: controller.allProducts,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedProduct != null ? [_selectedProduct!] : [],
        onRowTap: (p) => setState(() => _selectedProduct = p),
        trafficLightSelector: (p) => p.basePrice > 1000
            ? ZenoTrafficLight.danger
            : ZenoTrafficLight.success,
      ),
    );
  }
}
