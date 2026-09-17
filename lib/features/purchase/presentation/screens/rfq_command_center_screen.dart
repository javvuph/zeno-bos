import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/rfq.dart';
import '../controllers/rfq_controller.dart';
import '../manifests/rfq_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import '../widgets/comparison_matrix.dart';

class RFQCommandCenterScreen extends StatefulWidget {
  const RFQCommandCenterScreen({super.key});

  @override
  State<RFQCommandCenterScreen> createState() => _RFQCommandCenterScreenState();
}

class _RFQCommandCenterScreenState extends State<RFQCommandCenterScreen> {
  late final RFQController controller;
  bool _isComparing = false;

  @override
  void initState() {
    super.initState();
    controller = RFQController(sl<IPurchaseRepository>());
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
      manifest: const RFQWorkspaceManifest(),
      context: context,
      isLoading: controller.isLoading,
      extraActions: [
        if (_isComparing)
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => setState(() => _isComparing = false),
            tooltip: "Back to List",
          ),
      ],
      body: _isComparing ? _buildComparisonView() : _buildRFQList(),
    );
  }

  Widget _buildRFQList() {
    return ZenoTable<RFQ>(
      items: controller.rfqs,
      onRowTap: (rfq) {
        controller.selectRFQ(rfq);
        setState(() => _isComparing = true);
      },
      columns: const RFQWorkspaceManifest().tableColumns(context),
    );
  }

  Widget _buildComparisonView() {
    if (controller.selectedRFQ == null) {
      return const Center(child: Text("Select an RFQ"));
    }

    return Column(
      children: [
        // Comparison Context Header
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).extension<ZenoSemanticColors>()!.bgTier2,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("COMPARING QUOTATIONS FOR:",
                      style: ZenoTypography.micro(Colors.grey)),
                  Text(controller.selectedRFQ!.title.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14)),
                ],
              ),
              const Spacer(),
              _AIAdviceCard(rfq: controller.selectedRFQ!),
            ],
          ),
        ),
        Expanded(
          child: SupplierComparisonMatrix(
            rfq: controller.selectedRFQ!,
            quotations: controller.quotations,
          ),
        ),
      ],
    );
  }
}

class _AIAdviceCard extends StatelessWidget {
  final dynamic rfq;
  const _AIAdviceCard({required this.rfq});

  @override
  Widget build(BuildContext context) {
    if (rfq.aiRecommendation == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF00F0FF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: const Color(0xFF00F0FF).withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 16, color: Color(0xFF00F0FF)),
          const SizedBox(width: 12),
          Text(rfq.aiRecommendation!.toUpperCase(),
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00F0FF))),
        ],
      ),
    );
  }
}
