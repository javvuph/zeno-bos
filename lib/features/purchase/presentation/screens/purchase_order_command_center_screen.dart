import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../controllers/purchase_controller.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../manifests/purchase_order_workspace_manifest.dart';

class PurchaseOrderCommandCenterScreen extends StatefulWidget {
  const PurchaseOrderCommandCenterScreen({super.key});

  @override
  State<PurchaseOrderCommandCenterScreen> createState() =>
      _PurchaseOrderCommandCenterScreenState();
}

class _PurchaseOrderCommandCenterScreenState
    extends State<PurchaseOrderCommandCenterScreen> {
  late final PurchaseController controller;
  PurchaseOrder? _selectedPO;
  final manifest = const PurchaseOrderWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = PurchaseController(sl<IPurchaseRepository>());
    controller.addListener(_onUpdate);
    controller.loadPurchaseOrders();
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
        tabs: manifest.inspectorTabs(context, _selectedPO),
        isVisible: _selectedPO != null,
        onClose: () => setState(() => _selectedPO = null),
      ),
      body: ZenoTable<PurchaseOrder>(
        items: controller.purchaseOrders,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedPO != null ? [_selectedPO!] : [],
        onRowTap: (po) => setState(() => _selectedPO = po),
        trafficLightSelector: (po) => _getTrafficLight(po),
      ),
    );
  }

  ZenoTrafficLight _getTrafficLight(PurchaseOrder po) {
    if (po.status == POStatus.cancelled) return ZenoTrafficLight.danger;
    if (po.status == POStatus.received) return ZenoTrafficLight.success;
    if (po.expectedDeliveryDate.isBefore(DateTime.now()) &&
        po.status != POStatus.received) {
      return ZenoTrafficLight.danger;
    }
    if (po.status == POStatus.partiallyReceived)
      return ZenoTrafficLight.warning;
    return ZenoTrafficLight.neutral;
  }
}
