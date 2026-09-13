import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/tax_controller.dart';
import '../manifests/tax_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/tax_rule.dart';

class TaxManagementHubScreen extends StatefulWidget {
  const TaxManagementHubScreen({super.key});

  @override
  State<TaxManagementHubScreen> createState() => _TaxManagementHubScreenState();
}

class _TaxManagementHubScreenState extends State<TaxManagementHubScreen> {
  late final TaxController controller;
  final manifest = const TaxWorkspaceManifest();
  TaxRule? _selectedRule;

  @override
  void initState() {
    super.initState();
    controller = TaxController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedRule),
        isVisible: _selectedRule != null,
        onClose: () => setState(() => _selectedRule = null),
      ),
      body: ZenoTable<TaxRule>(
        items: controller.taxRules,
        onRowTap: (r) => setState(() => _selectedRule = r),
        selectedItems: _selectedRule != null ? [_selectedRule!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
