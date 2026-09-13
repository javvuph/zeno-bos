import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/unit.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../manifests/units_workspace_manifest.dart';

class UnitCommandCenterScreen extends StatefulWidget {
  const UnitCommandCenterScreen({super.key});

  @override
  State<UnitCommandCenterScreen> createState() =>
      _UnitCommandCenterScreenState();
}

class _UnitCommandCenterScreenState extends State<UnitCommandCenterScreen> {
  late final ProductController controller;
  Unit? _selectedUnit;
  final manifest = const UnitsWorkspaceManifest();

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
    final List<Unit> items = List<Unit>.from(controller.units);

    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedUnit),
        isVisible: _selectedUnit != null,
        onClose: () => setState(() => _selectedUnit = null),
      ),
      body: ZenoTable<Unit>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedUnit != null ? [_selectedUnit!] : [],
        onRowTap: (u) => setState(() => _selectedUnit = u),
      ),
    );
  }
}
