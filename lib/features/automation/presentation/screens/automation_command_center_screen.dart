import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/automation_controller.dart';
import '../manifests/automation_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/automation.dart';

class AutomationCommandCenterScreen extends StatefulWidget {
  const AutomationCommandCenterScreen({super.key});

  @override
  State<AutomationCommandCenterScreen> createState() =>
      _AutomationCommandCenterScreenState();
}

class _AutomationCommandCenterScreenState
    extends State<AutomationCommandCenterScreen> {
  late final AutomationController controller;
  final manifest = const AutomationWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = sl<AutomationController>();
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
        tabs: manifest.inspectorTabs(context, controller.selectedAutomation),
        isVisible: controller.selectedAutomation != null,
        onClose: () => controller.selectAutomation(null),
      ),
      body: ZenoTable<Automation>(
        items: controller.automations,
        onRowTap: (a) => controller.selectAutomation(a),
        selectedItems: controller.selectedAutomation != null
            ? [controller.selectedAutomation!]
            : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
