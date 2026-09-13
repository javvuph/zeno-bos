import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/category.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../manifests/categories_workspace_manifest.dart';

class CategoryCommandCenterScreen extends StatefulWidget {
  const CategoryCommandCenterScreen({super.key});

  @override
  State<CategoryCommandCenterScreen> createState() =>
      _CategoryCommandCenterScreenState();
}

class _CategoryCommandCenterScreenState
    extends State<CategoryCommandCenterScreen> {
  late final ProductController controller;
  Category? _selectedCategory;
  final manifest = const CategoriesWorkspaceManifest();

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
    // Reusing ProductController.categories which returns List<Category> from MasterDataService
    final List<Category> items = List<Category>.from(controller.categories);

    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedCategory),
        isVisible: _selectedCategory != null,
        onClose: () => setState(() => _selectedCategory = null),
      ),
      body: ZenoTable<Category>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedCategory != null ? [_selectedCategory!] : [],
        onRowTap: (c) => setState(() => _selectedCategory = c),
      ),
    );
  }
}
