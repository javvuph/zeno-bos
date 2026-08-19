import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/governance_controller.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/governance_enums.dart';

class IntegrationGovernanceScreen extends StatefulWidget {
  const IntegrationGovernanceScreen({super.key});

  @override
  State<IntegrationGovernanceScreen> createState() =>
      _IntegrationGovernanceScreenState();
}

class _IntegrationGovernanceScreenState extends State<IntegrationGovernanceScreen> {
  late final GovernanceController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<GovernanceController>();
    controller.addListener(_onUpdate);
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
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoWorkspace.fromManifest(
      manifest: ZenoWorkspaceManifest(
        id: 'integration_governance',
        title: 'Integration Control Tower',
        subtitle:
            'GOVERNING EXTERNAL CONNECTIVITY AND API DATA RECONCILIATION.',
        icon: Icons.cable_rounded,
        toolbarActions: (context) => [
          const ZenoButton(
              label: "New Connection",
              icon: Icons.add_link_rounded,
              size: ZenoButtonSize.sm),
          const ZenoButton(
              label: "API Webhooks",
              icon: Icons.webhook_rounded,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm),
        ],
        filterActions: (context) => [
          const ZenoChip(label: "All APIs", isSelected: true),
          const ZenoChip(label: "Payments"),
          const ZenoChip(label: "Messaging"),
        ],
        kpiMetrics: (context) => [
          ZenoKpiData(
              label: "Active Connectors",
              value: "${controller.integrations.length}",
              icon: Icons.hub_outlined),
          ZenoKpiData(
              label: "Critical Failures",
              value:
                  "${controller.integrations.where((i) => i.status == HealthStatus.critical).length}",
              icon: Icons.report_problem_rounded,
              color: Colors.red),
        ],
        tableColumns: (context) => [],
        inspectorTabs: (context, i) => [],
        commandVessel: (context) => const Text("INTEGRATION COMMANDS..."),
        statusBarIndicators: (context) => [],
      ),
      context: context,
      isLoading: controller.isLoading,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZenoCard(
              title: "EXTERNAL API CONNECTORS",
              child: Column(
                children: controller.integrations
                    .map((i) => _IntegrationTile(i: i, colors: colors))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntegrationTile extends StatelessWidget {
  final dynamic i;
  final ZenoSemanticColors colors;
  const _IntegrationTile({required this.i, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: colors.bgTier4, shape: BoxShape.circle),
            child: Icon(_getIcon(i.type), size: 18, color: colors.accentPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(i.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
                Text("Last Sync: ${i.lastSync.toString().substring(0, 16)}",
                    style: const TextStyle(fontSize: 10, color: Colors.white24)),
              ],
            ),
          ),
          if (i.errorCount24h > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
              child: Text("${i.errorCount24h} ERRORS", style: const TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(width: 16),
          Icon(Icons.circle, size: 10, color: i.status == HealthStatus.healthy ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  IconData _getIcon(IntegrationType t) {
    switch (t) {
      case IntegrationType.payment: return Icons.payments_outlined;
      case IntegrationType.banking: return Icons.account_balance_rounded;
      case IntegrationType.messaging: return Icons.chat_bubble_outline_rounded;
      case IntegrationType.email: return Icons.email_outlined;
      case IntegrationType.ai: return Icons.auto_awesome;
      case IntegrationType.tax_service: return Icons.gavel_rounded;
      case IntegrationType.api_external: return Icons.api_rounded;
    }
  }
}
