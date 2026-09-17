import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/customer_controller.dart';
import '../manifests/sales_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/customer.dart';

class Customer360DashboardScreen extends StatefulWidget {
  const Customer360DashboardScreen({super.key});

  @override
  State<Customer360DashboardScreen> createState() =>
      _Customer360DashboardScreenState();
}

class _Customer360DashboardScreenState
    extends State<Customer360DashboardScreen> {
  late final CustomerController controller;
  final manifest = const SalesWorkspaceManifest();
  Customer? _selectedCustomer;

  @override
  void initState() {
    super.initState();
    controller = CustomerController(sl<ICustomerRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedCustomer),
        isVisible: _selectedCustomer != null,
        onClose: () => setState(() => _selectedCustomer = null),
      ),
      body: ZenoTable<Customer>(
        items: controller.customers,
        onRowTap: (c) => setState(() => _selectedCustomer = c),
        selectedItems: _selectedCustomer != null ? [_selectedCustomer!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (c) {
          if (c.tier == CustomerTier.vip) return ZenoTrafficLight.success;
          if (c.outstandingBalance > c.credit.creditLimit) {
            return ZenoTrafficLight.danger;
          }
          if (c.aiHealthScore < 50) return ZenoTrafficLight.warning;
          return ZenoTrafficLight.info;
        },
      ),
    );
  }
}
