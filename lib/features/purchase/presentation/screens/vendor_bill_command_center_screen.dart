import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../controllers/vendor_bill_controller.dart';
import '../manifests/vendor_bill_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/vendor_bill.dart';
import '../../domain/models/vendor_bill_status.dart';

class VendorBillCommandCenterScreen extends StatefulWidget {
  const VendorBillCommandCenterScreen({super.key});

  @override
  State<VendorBillCommandCenterScreen> createState() =>
      _VendorBillCommandCenterScreenState();
}

class _VendorBillCommandCenterScreenState
    extends State<VendorBillCommandCenterScreen> {
  late final VendorBillController controller;
  final manifest = const VendorBillWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = VendorBillController(sl<IPurchaseRepository>());
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
        tabs: manifest.inspectorTabs(context, controller.selectedBill),
        isVisible: controller.selectedBill != null,
        onClose: () => controller
            .selectBill(controller.bills.first), // Demo persistent selection
      ),
      body: ZenoTable<VendorBill>(
        items: controller.bills,
        onRowTap: (bill) => controller.selectBill(bill),
        selectedItems:
            controller.selectedBill != null ? [controller.selectedBill!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (b) {
          if (b.status == VendorBillStatus.verified) {
            return ZenoTrafficLight.success;
          }
          if (b.status == VendorBillStatus.mismatch) {
            return ZenoTrafficLight.danger;
          }
          if (b.status == VendorBillStatus.overdue) {
            return ZenoTrafficLight.warning;
          }
          return ZenoTrafficLight.neutral; // Safer fallback
        },
      ),
    );
  }
}
