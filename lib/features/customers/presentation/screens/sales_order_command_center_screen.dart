import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/sales_order_controller.dart';
import '../manifests/sales_order_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/sales_order.dart';

class SalesOrderCommandCenterScreen extends StatefulWidget {
  const SalesOrderCommandCenterScreen({super.key});

  @override
  State<SalesOrderCommandCenterScreen> createState() =>
      _SalesOrderCommandCenterScreenState();
}

class _SalesOrderCommandCenterScreenState
    extends State<SalesOrderCommandCenterScreen> {
  late final SalesOrderController controller;
  final manifest = const SalesOrderWorkspaceManifest();
  SalesOrder? _selectedOrder;

  @override
  void initState() {
    super.initState();
    controller = SalesOrderController(sl<ICustomerRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedOrder),
        isVisible: _selectedOrder != null,
        onClose: () => setState(() => _selectedOrder = null),
      ),
      body: ZenoTable<SalesOrder>(
        items: controller.orders,
        onRowTap: (o) => setState(() => _selectedOrder = o),
        selectedItems: _selectedOrder != null ? [_selectedOrder!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
