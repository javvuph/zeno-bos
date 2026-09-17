import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/closing_controller.dart';
import '../manifests/closing_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/closing_task.dart';

class FinancialClosingCommandCenterScreen extends StatefulWidget {
  const FinancialClosingCommandCenterScreen({super.key});

  @override
  State<FinancialClosingCommandCenterScreen> createState() =>
      _FinancialClosingCommandCenterScreenState();
}

class _FinancialClosingCommandCenterScreenState
    extends State<FinancialClosingCommandCenterScreen> {
  late final ClosingController controller;
  final manifest = const ClosingWorkspaceManifest();
  ClosingTask? _selectedTask;

  @override
  void initState() {
    super.initState();
    controller = ClosingController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedTask),
        isVisible: _selectedTask != null,
        onClose: () => setState(() => _selectedTask = null),
      ),
      body: ZenoTable<ClosingTask>(
        items: controller.tasks,
        onRowTap: (t) => setState(() => _selectedTask = t),
        selectedItems: _selectedTask != null ? [_selectedTask!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (t) {
          if (t.status == ClosingTaskStatus.completed) {
            return ZenoTrafficLight.success;
          }
          if (t.isMandatory && t.status == ClosingTaskStatus.pending) {
            return ZenoTrafficLight.danger;
          }
          return ZenoTrafficLight.info;
        },
      ),
    );
  }
}
