import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/opportunity_controller.dart';
import '../manifests/opportunity_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/opportunity.dart';

class OpportunityPipelineScreen extends StatefulWidget {
  const OpportunityPipelineScreen({super.key});

  @override
  State<OpportunityPipelineScreen> createState() =>
      _OpportunityPipelineScreenState();
}

class _OpportunityPipelineScreenState extends State<OpportunityPipelineScreen> {
  late final OpportunityController controller;
  final manifest = const OpportunityWorkspaceManifest();
  Opportunity? _selectedOpp;

  @override
  void initState() {
    super.initState();
    controller = OpportunityController(sl<ICustomerRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedOpp),
        isVisible: _selectedOpp != null,
        onClose: () => setState(() => _selectedOpp = null),
      ),
      body: ZenoTable<Opportunity>(
        items: controller.opportunities,
        onRowTap: (o) => setState(() => _selectedOpp = o),
        selectedItems: _selectedOpp != null ? [_selectedOpp!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
