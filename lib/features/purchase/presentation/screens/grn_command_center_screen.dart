import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/grn.dart';
import '../controllers/grn_controller.dart';
import '../manifests/grn_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';

class GRNCommandCenterScreen extends StatefulWidget {
  const GRNCommandCenterScreen({super.key});

  @override
  State<GRNCommandCenterScreen> createState() => _GRNCommandCenterScreenState();
}

class _GRNCommandCenterScreenState extends State<GRNCommandCenterScreen> {
  late final GRNController controller;
  final manifest = const GRNWorkspaceManifest();

  @override
  void initState() {
    super.initState();
    controller = GRNController(sl<IPurchaseRepository>());
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
        tabs: manifest.inspectorTabs(context, controller.selectedGRN),
        isVisible: controller.selectedGRN != null,
        onClose: () => controller
            .selectGRN(controller.grns.first), // Just for demo, keep selection
      ),
      body: ZenoTable<GRN>(
        items: controller.grns,
        onRowTap: (grn) => controller.selectGRN(grn),
        selectedItems:
            controller.selectedGRN != null ? [controller.selectedGRN!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (g) {
          if (g.status == GRNStatus.completed) return ZenoTrafficLight.success;
          if (g.status == GRNStatus.rejected) return ZenoTrafficLight.danger;
          if (g.status == GRNStatus.partial) return ZenoTrafficLight.warning;
          return ZenoTrafficLight.neutral;
        },
      ),
    );
  }
}
