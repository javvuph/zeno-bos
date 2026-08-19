import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/services/global_context_manager.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../controllers/administration_controller.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late final AdministrationController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<AdministrationController>();
    controller.addListener(_onUpdate);
    controller.refreshDashboard();
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final health = controller.health;

    return Column(
      children: [
        ZenoHeader(
          title: "System Control Panel".toUpperCase(),
          subtitle:
              "MASTER ADMINISTRATIVE OVERVIEW OF SYSTEM HEALTH, SECURITY AUDITS, AND GLOBAL CONFIGURATION.",
          actions: [
            _AdminHeaderBtn(
              label: "BACKUP NOW",
              icon: Icons.backup_outlined,
              colors: colors,
              onPressed: () => controller.triggerBackup(),
            ),
            const SizedBox(width: ZenoSpacing.md),
            _AdminHeaderBtn(
              label: "SETUP WIZARD",
              icon: Icons.auto_fix_high_outlined,
              isPrimary: true,
              colors: colors,
              onPressed: () =>
                  NavigationController().navigateTo('admin/setup/store_modal'),
            ),
          ],
        ),
        // STICKY KPI SUMMARY
        _buildStickyKPI(colors, health, controller.syncStats),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // System Logs & Monitoring
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ZenoCard(
                            title: "CRITICAL SYSTEM AUDIT",
                            trailing: Icon(Icons.security_outlined,
                                size: 16, color: colors.statusDanger),
                            child: controller.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Column(
                                    children: [
                                      ...controller.auditLogs
                                          .map((log) => _LogItem(
                                                label: log.details,
                                                time:
                                                    "${DateTime.now().difference(log.timestamp).inMinutes}M AGO",
                                                color: log.action == 'DELETE'
                                                    ? colors.statusDanger
                                                    : colors.accentPrimary,
                                                colors: colors,
                                              )),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "INFRASTRUCTURE MONITORING",
                            child: Row(
                              children: [
                                Expanded(
                                    child: _MonitorStat(
                                        label: "CPU",
                                        value: "${health.cpuUsage}%",
                                        color: health.cpuUsage > 80
                                            ? colors.statusDanger
                                            : colors.statusSuccess,
                                        colors: colors)),
                                _vDivider(colors),
                                Expanded(
                                    child: _MonitorStat(
                                        label: "MEMORY",
                                        value: "${health.memoryUsage}%",
                                        color: colors.accentPrimary,
                                        colors: colors)),
                                _vDivider(colors),
                                Expanded(
                                    child: _MonitorStat(
                                        label: "DB SIZE",
                                        value: "${health.databaseSize}MB",
                                        color: colors.statusWarning,
                                        colors: colors)),
                                _vDivider(colors),
                                Expanded(
                                    child: _MonitorStat(
                                        label: "ERRORS (24H)",
                                        value: "${health.errorCount24h}",
                                        color: health.errorCount24h > 10
                                            ? colors.statusDanger
                                            : colors.statusSuccess,
                                        colors: colors)),
                              ],
                            ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "BACKGROUND PROCESSING",
                            child: Column(
                              children: [
                                ...controller.jobs.map((job) =>
                                    _JobProgressTile(job: job, colors: colors)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: ZenoSpacing.lg),

                    // Branch Context & Sessions
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ZenoCard(
                            title: "MAINTENANCE & GOVERNANCE",
                            child: Column(
                              children: [
                                _GovernanceAction(
                                  label: "SYSTEM SECURITY POLICY",
                                  icon: Icons.policy_outlined,
                                  color: colors.statusInfo,
                                  onTap: () => NavigationController()
                                      .openTab('admin/sec/policy'),
                                ),
                                _GovernanceAction(
                                  label: "RUN SYSTEM DIAGNOSTICS",
                                  icon: Icons.biotech_outlined,
                                  color: colors.accentPrimary,
                                  onTap: () => controller.runDiagnostics(),
                                ),
                                _GovernanceAction(
                                  label: "DATABASE INTEGRITY CHECK",
                                  icon: Icons.table_chart_outlined,
                                  color: colors.statusSuccess,
                                  onTap: () {},
                                ),
                                _GovernanceAction(
                                  label: "MAINTENANCE MODE",
                                  icon: Icons.construction_outlined,
                                  color: colors.statusWarning,
                                  isToggle: true,
                                  value: controller.settings.maintenanceMode,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "BRANCH TOPOLOGY",
                            child: Column(
                              children: [
                                ...controller.branches.map((b) => _BranchNode(
                                      branch: b,
                                      isSelected: sl<GlobalContextManager>()
                                              .current
                                              .branch
                                              ?.id ==
                                          b.id,
                                      onTap: () =>
                                          controller.switchBranchContext(b),
                                      colors: colors,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "ADMINISTRATIVE SESSIONS",
                            child: Column(
                              children: [
                                _SessionItem(
                                    user: "ALEX RIVERA",
                                    role: "GLOBAL DIRECTOR",
                                    status: "ACTIVE NOW",
                                    color: colors.accentPrimary,
                                    colors: colors),
                                _SessionItem(
                                    user: "MARIA SANTOS",
                                    role: "IT MANAGER",
                                    status: "ACTIVE NOW",
                                    color: colors.statusSuccess,
                                    colors: colors),
                                const SizedBox(height: ZenoSpacing.md),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text("TERMINATE ALL SESSIONS",
                                        style: ZenoTypography.caption(
                                                colors.statusDanger)
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ZenoSpacing.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyKPI(
      ZenoSemanticColors colors, dynamic health, dynamic sync) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _KPIItem(
              label: "SYSTEM READINESS",
              value: "${(controller.systemReadyScore * 100).toInt()}%",
              icon: Icons.rocket_launch_outlined,
              color: colors.statusSuccess,
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "ACTIVE USERS",
              value: health.activeUsers.toString(),
              icon: Icons.people_outline,
              color: colors.accentPrimary,
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "SYNC LATENCY",
              value:
                  "${DateTime.now().difference(sync.lastSyncTime).inMinutes}M",
              icon: Icons.sync_outlined,
              color: colors.statusWarning,
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "API UPTIME",
              value: health.uptime,
              icon: Icons.cloud_done_outlined,
              color: colors.accentPrimary,
              colors: colors),
        ],
      ),
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 32,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl));
}

class _GovernanceAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isToggle;
  final bool value;
  final VoidCallback onTap;
  const _GovernanceAction(
      {required this.label,
      required this.icon,
      required this.color,
      this.isToggle = false,
      this.value = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(ZenoRadius.md),
            border: Border.all(color: color.withValues(alpha: 0.1))),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 12),
            Expanded(
                child: Text(label,
                    style: ZenoTypography.micro(color)
                        .copyWith(fontWeight: FontWeight.bold))),
            if (isToggle)
              Switch(
                  value: value,
                  onChanged: (v) => onTap(),
                  activeTrackColor: color)
            else
              Icon(Icons.chevron_right, size: 14, color: color),
          ],
        ),
      ),
    );
  }
}

class _JobProgressTile extends StatelessWidget {
  final dynamic job;
  final ZenoSemanticColors colors;
  const _JobProgressTile({required this.job, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(job.name.toUpperCase(),
                  style: ZenoTypography.micro(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text("${(job.progress * 100).toInt()}%",
                  style: ZenoTypography.micro(colors.textDisabled)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: job.progress,
              backgroundColor: colors.bgTier3,
              valueColor: AlwaysStoppedAnimation<Color>(colors.accentPrimary),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonitorStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;
  const _MonitorStat(
      {required this.label,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: ZenoTypography.micro(colors.textDisabled)),
        const SizedBox(height: 4),
        Text(value,
            style: ZenoTypography.caption(color).copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: ZenoTypography.monoFamily)),
      ],
    );
  }
}

class _BranchNode extends StatelessWidget {
  final dynamic branch;
  final bool isSelected;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  const _BranchNode(
      {required this.branch,
      this.isSelected = false,
      required this.onTap,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.accentPrimary.withValues(alpha: 0.1)
              : colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(
              color: isSelected
                  ? colors.accentPrimary.withValues(alpha: 0.3)
                  : colors.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(Icons.storefront_outlined,
                size: 16,
                color: isSelected ? colors.accentPrimary : colors.textDisabled),
            const SizedBox(width: 12),
            Expanded(
                child: Text(branch.name.toUpperCase(),
                    style: ZenoTypography.micro(isSelected
                            ? colors.accentPrimary
                            : colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold))),
            if (isSelected)
              Icon(Icons.check_circle, size: 14, color: colors.statusSuccess),
          ],
        ),
      ),
    );
  }
}

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final ZenoSemanticColors colors;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: ZenoSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ZenoTypography.micro(colors.textDisabled)),
            const SizedBox(height: 2),
            Text(value,
                style: ZenoTypography.headlineMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
          ],
        ),
      ],
    );
  }
}

class _AdminHeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _AdminHeaderBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
    );
  }
}

class _LogItem extends StatelessWidget {
  final String label;
  final String time;
  final Color color;
  final ZenoSemanticColors colors;
  const _LogItem(
      {required this.label,
      required this.time,
      required this.color,
      required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md)),
      child: Row(
        children: [
          Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
              child: Text(label,
                  style: ZenoTypography.caption(colors.textPrimary))),
          Text(time, style: ZenoTypography.micro(colors.textDisabled)),
        ],
      ),
    );
  }
}

class _SessionItem extends StatelessWidget {
  final String user;
  final String role;
  final String status;
  final Color color;
  final ZenoSemanticColors colors;
  const _SessionItem(
      {required this.user,
      required this.role,
      required this.status,
      required this.color,
      required this.colors});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.lg),
      child: Row(
        children: [
          Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user,
                    style: ZenoTypography.bodyMD(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w900)),
                Text(role, style: ZenoTypography.micro(colors.textDisabled)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4)),
            child: Text(status,
                style: ZenoTypography.micro(color)
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
