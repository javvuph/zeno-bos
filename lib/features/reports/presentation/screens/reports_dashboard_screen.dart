import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/reports_controller.dart';
import '../manifests/reports_workspace_manifest.dart';
import '../../domain/models/report_definition.dart';

class ReportsDashboardScreen extends StatefulWidget {
  const ReportsDashboardScreen({super.key});

  @override
  State<ReportsDashboardScreen> createState() => _ReportsDashboardScreenState();
}

class _ReportsDashboardScreenState extends State<ReportsDashboardScreen> {
  late final ReportsController controller;
  final manifest = const ReportsWorkspaceManifest();
  ReportDefinition? _selectedReport;

  @override
  void initState() {
    super.initState();
    controller = sl<ReportsController>();
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
        tabs: manifest.inspectorTabs(context, _selectedReport),
        isVisible: _selectedReport != null,
        onClose: () => setState(() => _selectedReport = null),
      ),
      body: ZenoTable<ReportDefinition>(
        items: controller.customReports,
        onRowTap: (r) => setState(() => _selectedReport = r),
        selectedItems: _selectedReport != null ? [_selectedReport!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
