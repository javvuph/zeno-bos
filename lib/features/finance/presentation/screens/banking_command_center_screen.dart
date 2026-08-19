import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/banking_controller.dart';
import '../manifests/banking_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/bank_transaction.dart';

class BankingCommandCenterScreen extends StatefulWidget {
  const BankingCommandCenterScreen({super.key});

  @override
  State<BankingCommandCenterScreen> createState() =>
      _BankingCommandCenterScreenState();
}

class _BankingCommandCenterScreenState
    extends State<BankingCommandCenterScreen> {
  late final BankingController controller;
  final manifest = const BankingWorkspaceManifest();
  BankTransaction? _selectedTx;

  @override
  void initState() {
    super.initState();
    controller = BankingController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedTx),
        isVisible: _selectedTx != null,
        onClose: () => setState(() => _selectedTx = null),
      ),
      body: ZenoTable<BankTransaction>(
        items: controller.transactions,
        onRowTap: (t) => setState(() => _selectedTx = t),
        selectedItems: _selectedTx != null ? [_selectedTx!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (t) {
          if (t.status == BankTransactionStatus.reconciled)
            return ZenoTrafficLight.success;
          if (t.status == BankTransactionStatus.failed)
            return ZenoTrafficLight.danger;
          if (t.aiFraudScore > 70) return ZenoTrafficLight.warning;
          return ZenoTrafficLight.info;
        },
      ),
    );
  }
}
