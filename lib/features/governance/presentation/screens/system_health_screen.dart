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

class SystemHealthScreen extends StatefulWidget {
  const SystemHealthScreen({super.key});

  @override
  State<SystemHealthScreen> createState() => _SystemHealthScreenState();
}

class _SystemHealthScreenState extends State<SystemHealthScreen> {
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
        id: 'system_health',
        title: 'Platform Integrity Hub',
        subtitle:
            'REAL-TIME PERFORMANCE MONITORING AND DIAGNOSTIC ORCHESTRATION.',
        icon: Icons.monitor_heart_rounded,
        toolbarActions: (context) => [
          const ZenoButton(
              label: "Run Diagnostics",
              icon: Icons.biotech_rounded,
              size: ZenoButtonSize.sm),
          const ZenoButton(
              label: "Clear Cache",
              icon: Icons.cleaning_services_rounded,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm),
        ],
        filterActions: (context) => [
          const ZenoChip(label: "All Nodes", isSelected: true),
          const ZenoChip(label: "Critical"),
          const ZenoChip(label: "Storage"),
        ],
        kpiMetrics: (context) => [
          ZenoKpiData(
              label: "Health Score",
              value: "${controller.healthScore}%",
              icon: Icons.speed_rounded,
              color: Colors.green),
          const ZenoKpiData(
              label: "API Status",
              value: "ONLINE",
              icon: Icons.cloud_done_rounded,
              color: Colors.green),
        ],
        tableColumns: (context) => [],
        inspectorTabs: (context, h) => [],
        commandVessel: (context) => const Text("SYSTEM DIAGNOSTICS..."),
        statusBarIndicators: (context) => [],
      ),
      context: context,
      isLoading: controller.isLoading,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZenoCard(
              title: "COMPONENT REGISTRY",
              child: Column(
                children: controller.health
                    .map((h) => _HealthTile(h: h, colors: colors))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthTile extends StatelessWidget {
  final dynamic h;
  final ZenoSemanticColors colors;
  const _HealthTile({required this.h, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: _getStatusColor(h.status)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(h.component.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
                Text(h.message,
                    style: const TextStyle(fontSize: 9, color: Colors.white54)),
              ],
            ),
          ),
          if (h.latencyMs > 0)
            Text("${h.latencyMs.toInt()}ms",
                style: const TextStyle(
                    fontFamily: 'Inter', fontSize: 10, color: Colors.white24)),
        ],
      ),
    );
  }

  Color _getStatusColor(HealthStatus s) {
    switch (s) {
      case HealthStatus.healthy:
        return Colors.green;
      case HealthStatus.degraded:
        return Colors.orange;
      case HealthStatus.critical:
        return Colors.red;
      case HealthStatus.offline:
        return Colors.grey;
    }
  }
}
