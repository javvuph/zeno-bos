import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/services/global_context_manager.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import '../controllers/administration_controller.dart';

part 'parts/admin_dashboard_widgets.part.dart';
part 'parts/admin_dashboard_kpi.part.dart';
part 'parts/admin_dashboard_session_job.part.dart';

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
}
