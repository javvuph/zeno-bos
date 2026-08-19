import 'package:flutter/material.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import 'package:zeno/core/widgets/zeno_status.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/enterprise_user.dart';
import '../../domain/models/governance_enums.dart';

class GovernanceWorkspaceManifest extends ZenoWorkspaceManifest<EnterpriseUser> {
  const GovernanceWorkspaceManifest()
      : super(
          id: 'governance_center',
          title: 'Enterprise Governance Hub',
          subtitle:
              'CENTRAL COMMAND FOR IDENTITY, SECURITY, AND SYSTEM RECONCILIATION.',
          icon: Icons.gavel_rounded,
          toolbarActions: _getToolbarActions,
          filterActions: _getFilterActions,
          kpiMetrics: _getKpiMetrics,
          tableColumns: _getTableColumns,
          inspectorTabs: _getInspectorTabs,
          commandVessel: _getCommandVessel,
          statusBarIndicators: _getStatusBarIndicators,
        );

  static List<Widget> _getToolbarActions(BuildContext context) => [
        const ZenoButton(
            label: "Add User",
            icon: Icons.person_add_rounded,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Create Role",
            icon: Icons.shield_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
        const ZenoButton(
            label: "Security Center",
            icon: Icons.lock_outline_rounded,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm),
      ];

  static List<Widget> _getFilterActions(BuildContext context) => [
        const ZenoChip(label: "Active Users", isSelected: true),
        const ZenoChip(label: "Restricted"),
        const ZenoChip(label: "Administrators"),
        const ZenoChip(label: "Audit Logs"),
      ];

  static List<ZenoKpiData> _getKpiMetrics(BuildContext context) => [
        const ZenoKpiData(
            label: "Security Score",
            value: "88/100",
            icon: Icons.verified_user_outlined,
            color: Colors.green),
        const ZenoKpiData(
            label: "Active Sessions",
            value: "24",
            icon: Icons.devices_rounded,
            color: Colors.blue),
        const ZenoKpiData(
            label: "System Health",
            value: "94%",
            icon: Icons.monitor_heart_outlined,
            color: Colors.green),
        const ZenoKpiData(
            label: "Failed Logins (24h)",
            value: "12",
            icon: Icons.report_problem_outlined,
            color: Colors.red),
      ];

  static List<ZenoTableColumn<EnterpriseUser>> _getTableColumns(
          BuildContext context) =>
      [
        ZenoTableColumn(
          label: "IDENTITY",
          width: 220,
          builder: (u) => Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.blue.withValues(alpha: 0.1),
                child: Text(u.displayName[0],
                    style: const TextStyle(fontSize: 10, color: Colors.blue)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(u.displayName.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
                  Text(u.email,
                      style: const TextStyle(fontSize: 8, color: Colors.white54)),
                ],
              ),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "STATUS",
          width: 120,
          builder: (u) => ZenoBadge(
            label: u.status.name.toUpperCase(),
            color: _getStatusColor(u.status),
          ),
        ),
        ZenoTableColumn(
          label: "PRIMARY BRANCH",
          width: 150,
          builder: (u) => Text(u.primaryBranchId ?? "GLOBAL",
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "LAST LOGIN",
          width: 140,
          builder: (u) => Text(
            u.lastLogin?.toString().substring(0, 16) ?? "NEVER",
            style: const TextStyle(fontSize: 10, fontFamily: 'Inter'),
          ),
        ),
        ZenoTableColumn(
          label: "MFA",
          width: 80,
          builder: (u) => Icon(
              u.mfaEnabled ? Icons.verified_rounded : Icons.pending_outlined,
              size: 14,
              color: u.mfaEnabled ? Colors.green : Colors.grey),
        ),
        ZenoTableColumn(
          label: "AUTH RISK",
          builder: (u) => Text(
            u.failedLoginAttempts > 0 ? "FAILED ATTEMPTS: ${u.failedLoginAttempts}" : "STABLE",
            style: TextStyle(
                fontSize: 9,
                color: u.failedLoginAttempts > 3 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold),
          ),
        ),
      ];

  static List<ZenoInspectorTab> _getInspectorTabs(
          BuildContext context, EnterpriseUser? u) =>
      [
        const ZenoInspectorTab(
            label: "Identity",
            icon: Icons.person_outline_rounded,
            child: Center(child: Text("Detailed User Profile"))),
        const ZenoInspectorTab(
            label: "Permissions",
            icon: Icons.shield_outlined,
            child: Center(child: Text("Role & Scope Assignment"))),
        const ZenoInspectorTab(
            label: "Audit Trail",
            icon: Icons.history_rounded,
            child: Center(child: Text("User Action History"))),
        const ZenoInspectorTab(
            label: "Sessions",
            icon: Icons.devices_rounded,
            child: Center(child: Text("Connected Devices"))),
      ];

  static Widget _getCommandVessel(BuildContext context) =>
      const Text("GOVERNANCE: /suspend, /reset, /backup, /audit...");

  static List<Widget> _getStatusBarIndicators(BuildContext context) => [
        const ZenoStatusDot(label: "AUTH SERVICE: ACTIVE", isActive: true),
        const ZenoStatusDot(label: "ENCRYPTION: AES-256", isActive: true),
      ];

  static Color _getStatusColor(GovernanceStatus s) {
    switch (s) {
      case GovernanceStatus.active:
        return Colors.green;
      case GovernanceStatus.inactive:
        return Colors.grey;
      case GovernanceStatus.restricted:
        return Colors.red;
      case GovernanceStatus.pending_approval:
        return Colors.orange;
    }
  }
}
