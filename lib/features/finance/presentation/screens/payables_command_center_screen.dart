import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/payables_controller.dart';
import '../manifests/payables_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/accounts_payable.dart';
import '../../domain/models/payment_status.dart';

class PayablesCommandCenterScreen extends StatefulWidget {
  const PayablesCommandCenterScreen({super.key});

  @override
  State<PayablesCommandCenterScreen> createState() =>
      _PayablesCommandCenterScreenState();
}

class _PayablesCommandCenterScreenState
    extends State<PayablesCommandCenterScreen> {
  late final PayablesController controller;
  final manifest = const PayablesWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = PayablesController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, controller.selectedPayable),
        isVisible: controller.selectedPayable != null,
        onClose: () => controller.selectPayable(controller.payables.first),
      ),
      body: ZenoTable<AccountsPayable>(
        items: controller.payables,
        onRowTap: (p) => controller.selectPayable(p),
        selectedItems: controller.selectedPayable != null
            ? [controller.selectedPayable!]
            : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (p) {
          if (p.status == PaymentStatus.paid) return ZenoTrafficLight.success;
          if (p.status == PaymentStatus.overdue) return ZenoTrafficLight.danger;
          if (p.priority == PayablePriority.urgent) {
            return ZenoTrafficLight.warning;
          }
          return ZenoTrafficLight.info;
        },
      ),
    );
  }
}
