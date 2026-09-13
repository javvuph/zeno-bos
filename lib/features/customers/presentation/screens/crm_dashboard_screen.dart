import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/crm_controller.dart';
import '../manifests/crm_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/lead.dart';

class CRMDashboardScreen extends StatefulWidget {
  const CRMDashboardScreen({super.key});

  @override
  State<CRMDashboardScreen> createState() => _CRMDashboardScreenState();
}

class _CRMDashboardScreenState extends State<CRMDashboardScreen> {
  late final CRMController controller;
  final manifest = const CRMWorkspaceManifest();
  Lead? _selectedLead;

  @override
  void initState() {
    super.initState();
    controller = CRMController(sl<ICustomerRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedLead),
        isVisible: _selectedLead != null,
        onClose: () => setState(() => _selectedLead = null),
      ),
      body: ZenoTable<Lead>(
        items: controller.leads,
        onRowTap: (l) => setState(() => _selectedLead = l),
        selectedItems: _selectedLead != null ? [_selectedLead!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
