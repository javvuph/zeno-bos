import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/governance_controller.dart';
import '../manifests/governance_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/enterprise_user.dart';

class GovernanceHubScreen extends StatefulWidget {
  const GovernanceHubScreen({super.key});

  @override
  State<GovernanceHubScreen> createState() => _GovernanceHubScreenState();
}

class _GovernanceHubScreenState extends State<GovernanceHubScreen> {
  late final GovernanceController controller;
  final manifest = const GovernanceWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = sl<GovernanceController>();
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
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      isLoading: controller.isLoading,
      inspector: ZenoSmartInspector(
        title: controller.selectedUser?.displayName,
        subtitle: controller.selectedUser?.email,
        tabs: manifest.inspectorTabs(context, controller.selectedUser),
        isVisible: controller.selectedUser != null,
        onClose: () => controller.selectUser(null),
      ),
      body: ZenoTable<EnterpriseUser>(
        items: controller.users,
        onRowTap: (u) => controller.selectUser(u),
        selectedItems:
            controller.selectedUser != null ? [controller.selectedUser!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
