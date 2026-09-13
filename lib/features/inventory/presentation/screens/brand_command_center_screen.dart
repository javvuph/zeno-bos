import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/brand.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../manifests/brands_workspace_manifest.dart';

class BrandCommandCenterScreen extends StatefulWidget {
  const BrandCommandCenterScreen({super.key});

  @override
  State<BrandCommandCenterScreen> createState() =>
      _BrandCommandCenterScreenState();
}

class _BrandCommandCenterScreenState extends State<BrandCommandCenterScreen> {
  late final ProductController controller;
  Brand? _selectedBrand;
  final manifest = const BrandsWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = ProductController(sl<IProductRepository>());
    controller.addListener(_onUpdate);
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
    final List<Brand> items = List<Brand>.from(controller.brands);

    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedBrand),
        isVisible: _selectedBrand != null,
        onClose: () => setState(() => _selectedBrand = null),
      ),
      body: ZenoTable<Brand>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedBrand != null ? [_selectedBrand!] : [],
        onRowTap: (b) => setState(() => _selectedBrand = b),
      ),
    );
  }
}
