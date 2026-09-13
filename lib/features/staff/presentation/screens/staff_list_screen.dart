import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/staff_controller.dart';
import '../manifests/hr_workspace_manifest.dart';
import '../../domain/models/employee.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  late final StaffController controller;
  final manifest = const HRWorkspaceManifest();
  Employee? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    controller = sl<StaffController>();
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
        tabs: manifest.inspectorTabs(context, _selectedEmployee),
        isVisible: _selectedEmployee != null,
        onClose: () => setState(() => _selectedEmployee = null),
      ),
      body: ZenoTable<Employee>(
        items: controller.employees,
        onRowTap: (e) => setState(() => _selectedEmployee = e),
        selectedItems: _selectedEmployee != null ? [_selectedEmployee!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
