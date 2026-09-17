part of '../admin_dashboard_screen.dart';

extension _AdminDashboardScreenKpiState on _AdminDashboardScreenState {
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
