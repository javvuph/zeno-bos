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

class SecurityCenterScreen extends StatefulWidget {
  const SecurityCenterScreen({super.key});

  @override
  State<SecurityCenterScreen> createState() => _SecurityCenterScreenState();
}

class _SecurityCenterScreenState extends State<SecurityCenterScreen> {
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
        id: 'security_center',
        title: 'Security Command Center',
        subtitle:
            'MONITORING AUTHENTICATION INTEGRITY AND AUTHORIZATION RISKS.',
        icon: Icons.security_rounded,
        toolbarActions: (context) => [
          const ZenoButton(
              label: "Update Policy",
              icon: Icons.policy_rounded,
              size: ZenoButtonSize.sm),
          const ZenoButton(
              label: "Scan Risks",
              icon: Icons.biotech_rounded,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm),
        ],
        filterActions: (context) => [
          const ZenoChip(label: "Overview", isSelected: true),
          const ZenoChip(label: "Sessions"),
          const ZenoChip(label: "Threats"),
        ],
        kpiMetrics: (context) => [
          ZenoKpiData(
              label: "Security Score",
              value: "${controller.securityScore}%",
              icon: Icons.verified_user_rounded,
              color: Colors.green),
          ZenoKpiData(
              label: "Active Sessions",
              value: "${controller.sessionCount}",
              icon: Icons.devices_rounded),
        ],
        tableColumns: (context) => [],
        inspectorTabs: (context, s) => [],
        commandVessel: (context) => const Text("SECURITY COMMANDS..."),
        statusBarIndicators: (context) => [],
      ),
      context: context,
      isLoading: controller.isLoading,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ZenoCard(
                    title: "ACTIVE SESSIONS",
                    child: Column(
                      children: controller.sessions
                          .map((s) => _SessionTile(s: s, colors: colors, onRevoke: () => controller.revokeSession(s.id)))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ZenoCard(
                    title: "AUTH ANOMALIES (AI)",
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("NO SUSPICIOUS ACTIVITY DETECTED.",
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  final dynamic s;
  final ZenoSemanticColors colors;
  final VoidCallback onRevoke;
  const _SessionTile({required this.s, required this.colors, required this.onRevoke});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.laptop_chromebook_rounded, size: 16, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text("${s.device} • ${s.ipAddress}", style: const TextStyle(fontSize: 9, color: Colors.white54)),
              ],
            ),
          ),
          TextButton(
            onPressed: onRevoke,
            child: const Text("REVOKE", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
