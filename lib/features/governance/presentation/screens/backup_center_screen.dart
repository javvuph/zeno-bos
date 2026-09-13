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

class BackupCenterScreen extends StatefulWidget {
  const BackupCenterScreen({super.key});

  @override
  State<BackupCenterScreen> createState() => _BackupCenterScreenState();
}

class _BackupCenterScreenState extends State<BackupCenterScreen> {
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
        id: 'backup_center',
        title: 'Disaster Recovery Hub',
        subtitle:
            'ORCHESTRATING AUTOMATED BACKUPS AND DATA ARCHIVAL POLICIES.',
        icon: Icons.cloud_upload_rounded,
        toolbarActions: (context) => [
          const ZenoButton(
              label: "Schedule",
              icon: Icons.schedule_rounded,
              size: ZenoButtonSize.sm),
          const ZenoButton(
              label: "Storage Quota",
              icon: Icons.storage_rounded,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm),
        ],
        filterActions: (context) => [
          const ZenoChip(label: "Success", isSelected: true),
          const ZenoChip(label: "Failed"),
          const ZenoChip(label: "Cloud"),
        ],
        kpiMetrics: (context) => [
          const ZenoKpiData(
              label: "Last Backup",
              value: "24h ago",
              icon: Icons.history_rounded),
          const ZenoKpiData(
              label: "Retention",
              value: "90 DAYS",
              icon: Icons.timer_outlined,
              color: Colors.blue),
        ],
        tableColumns: (context) => [],
        inspectorTabs: (context, b) => [],
        commandVessel: (context) => const Text("BACKUP COMMANDS..."),
        statusBarIndicators: (context) => [],
      ),
      context: context,
      isLoading: controller.isLoading,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZenoCard(
              title: "BACKUP ARCHIVE",
              trailing: ElevatedButton.icon(
                onPressed: () => controller.triggerBackup(),
                icon: const Icon(Icons.backup_outlined, size: 14),
                label: const Text("BACKUP NOW", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              child: Column(
                children: controller.backups
                    .map((b) => _BackupTile(b: b, colors: colors))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackupTile extends StatelessWidget {
  final dynamic b;
  final ZenoSemanticColors colors;
  const _BackupTile({required this.b, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.folder_zip_outlined, size: 16, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(b.id.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                Text("${b.location} • ${b.sizeMB.toStringAsFixed(1)} MB", style: const TextStyle(fontSize: 9, color: Colors.white54)),
              ],
            ),
          ),
          if (b.isVerified)
            const Icon(Icons.verified_rounded, size: 14, color: Colors.green),
          const SizedBox(width: 12),
          Text(b.timestamp.toString().substring(0, 10), style: const TextStyle(fontSize: 10, fontFamily: 'Inter')),
        ],
      ),
    );
  }
}
