part of '../admin_dashboard_screen.dart';

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
