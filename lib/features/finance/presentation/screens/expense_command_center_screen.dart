import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/expense_controller.dart';
import '../manifests/expense_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/expense_entry.dart';

class ExpenseCommandCenterScreen extends StatefulWidget {
  const ExpenseCommandCenterScreen({super.key});

  @override
  State<ExpenseCommandCenterScreen> createState() =>
      _ExpenseCommandCenterScreenState();
}

class _ExpenseCommandCenterScreenState
    extends State<ExpenseCommandCenterScreen> {
  late final ExpenseController controller;
  final manifest = const ExpenseWorkspaceManifest();
  ExpenseEntry? _selectedExpense;

  @override
  void initState() {
    super.initState();
    controller = ExpenseController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedExpense),
        isVisible: _selectedExpense != null,
        onClose: () => setState(() => _selectedExpense = null),
      ),
      body: ZenoTable<ExpenseEntry>(
        items: controller.expenses,
        onRowTap: (e) => setState(() => _selectedExpense = e),
        selectedItems: _selectedExpense != null ? [_selectedExpense!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (e) {
          if (e.aiAnomalyScore > 80) return ZenoTrafficLight.danger;
          if (e.amount > 5000) return ZenoTrafficLight.warning;
          return ZenoTrafficLight.info;
        },
      ),
    );
  }
}
