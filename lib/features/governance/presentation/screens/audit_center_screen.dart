import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/governance_controller.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import '../../domain/models/audit_entry.dart';
import '../../domain/models/governance_enums.dart';

class AuditCenterScreen extends StatefulWidget {
  const AuditCenterScreen({super.key});

  @override
  State<AuditCenterScreen> createState() => _AuditCenterScreenState();
}

class _AuditCenterScreenState extends State<AuditCenterScreen> {
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
    final manifest = ZenoWorkspaceManifest<AuditEntry>(
        id: 'audit_center',
        title: 'Enterprise Audit Center',
        subtitle: 'IMMUTABLE RECORD OF SYSTEM ACTIONS AND DATA MUTATIONS.',
        icon: Icons.history_edu_rounded,
        toolbarActions: (context) => [
          const ZenoButton(
              label: "Export Audit",
              icon: Icons.download_rounded,
              size: ZenoButtonSize.sm),
          const ZenoButton(
              label: "Refresh",
              icon: Icons.refresh_rounded,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm),
        ],
        filterActions: (context) => [
          const ZenoChip(label: "All Events", isSelected: true),
          const ZenoChip(label: "Security"),
          const ZenoChip(label: "Finance"),
          const ZenoChip(label: "Critical"),
        ],
        kpiMetrics: (context) => [
          ZenoKpiData(
              label: "Events Today",
              value: "${controller.auditLogs.length}",
              icon: Icons.history_rounded),
          const ZenoKpiData(
              label: "Critical Risks",
              value: "0",
              icon: Icons.gavel_rounded,
              color: Colors.green),
        ],
        tableColumns: (context) => [
          ZenoTableColumn(
            label: "TIMESTAMP",
            width: 160,
            builder: (e) => Text(e.timestamp.toString().substring(0, 19),
                style: const TextStyle(fontSize: 10, fontFamily: 'Inter')),
          ),
          ZenoTableColumn(
            label: "ACTOR",
            width: 150,
            builder: (e) => Text(e.userName.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
          ),
          ZenoTableColumn(
            label: "ACTION",
            width: 140,
            builder: (e) => Text(e.action,
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 10)),
          ),
          ZenoTableColumn(
            label: "ENTITY",
            width: 150,
            builder: (e) => Text(
                "${e.entityType.name.toUpperCase()} (${e.entityId})",
                style: const TextStyle(fontSize: 9)),
          ),
          ZenoTableColumn(
            label: "SEVERITY",
            width: 100,
            builder: (e) => ZenoBadge(
              label: e.severity.name.toUpperCase(),
              color: _getSeverityColor(e.severity),
            ),
          ),
          ZenoTableColumn(
            label: "IP ADDRESS",
            builder: (e) => Text(e.ipAddress,
                style: const TextStyle(fontSize: 9, color: Colors.white54)),
          ),
        ],
        inspectorTabs: (context, e) => [],
        commandVessel: (context) => const Text("SEARCH AUDIT..."),
        statusBarIndicators: (context) => [],
      );

    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      isLoading: controller.isLoading,
      body: ZenoTable<AuditEntry>(
        items: controller.auditLogs,
        columns: manifest.tableColumns(context),
      ),
    );
  }

  Color _getSeverityColor(AuditSeverity s) {
    switch (s) {
      case AuditSeverity.low:
        return Colors.blue;
      case AuditSeverity.medium:
        return Colors.orange;
      case AuditSeverity.high:
        return Colors.red;
      case AuditSeverity.critical:
        return Colors.purple;
    }
  }
}
