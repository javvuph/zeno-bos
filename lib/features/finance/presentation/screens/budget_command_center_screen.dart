import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/budget_controller.dart';
import '../manifests/budget_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/budget.dart';

class BudgetCommandCenterScreen extends StatefulWidget {
  const BudgetCommandCenterScreen({super.key});

  @override
  State<BudgetCommandCenterScreen> createState() =>
      _BudgetCommandCenterScreenState();
}

class _BudgetCommandCenterScreenState extends State<BudgetCommandCenterScreen> {
  late final BudgetController controller;
  final manifest = const BudgetWorkspaceManifest();
  Budget? _selectedBudget;

  @override
  void initState() {
    super.initState();
    controller = BudgetController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedBudget),
        isVisible: _selectedBudget != null,
        onClose: () => setState(() => _selectedBudget = null),
      ),
      body: ZenoTable<Budget>(
        items: controller.budgets,
        onRowTap: (b) => setState(() => _selectedBudget = b),
        selectedItems: _selectedBudget != null ? [_selectedBudget!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (b) {
          if (b.isOverBudget) return ZenoTrafficLight.danger;
          if (b.variancePercentage > 85) return ZenoTrafficLight.warning;
          if (b.status == BudgetStatus.active) return ZenoTrafficLight.success;
          return ZenoTrafficLight.info;
        },
      ),
    );
  }
}
