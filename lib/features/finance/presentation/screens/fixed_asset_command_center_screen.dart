import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/asset_controller.dart';
import '../manifests/asset_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/fixed_asset.dart';

class FixedAssetCommandCenterScreen extends StatefulWidget {
  const FixedAssetCommandCenterScreen({super.key});

  @override
  State<FixedAssetCommandCenterScreen> createState() =>
      _FixedAssetCommandCenterScreenState();
}

class _FixedAssetCommandCenterScreenState
    extends State<FixedAssetCommandCenterScreen> {
  late final AssetController controller;
  final manifest = const AssetWorkspaceManifest();
  FixedAsset? _selectedAsset;

  @override
  void initState() {
    super.initState();
    controller = AssetController(sl<IFinanceRepository>());
    controller.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

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
        tabs: manifest.inspectorTabs(context, _selectedAsset),
        isVisible: _selectedAsset != null,
        onClose: () => setState(() => _selectedAsset = null),
      ),
      body: ZenoTable<FixedAsset>(
        items: controller.assets,
        onRowTap: (a) => setState(() => _selectedAsset = a),
        selectedItems: _selectedAsset != null ? [_selectedAsset!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
