part of '../side_info_panel.dart';

extension _ZenoSideInfoPanelHelpersState on _ZenoSideInfoPanelState {
  Widget _taskItem(String title, String sub, bool isOverdue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank,
              size: 18,
              color: isOverdue ? Colors.redAccent : ZenoTheme.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: isOverdue ? TextDecoration.none : null)),
                Text(sub,
                    style: TextStyle(
                        fontSize: 10,
                        color: isOverdue
                            ? Colors.redAccent.withValues(alpha: 0.8)
                            : ZenoTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarItem(String time, String title, String loc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
                color: ZenoTheme.accent,
                borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time,
                    style: const TextStyle(
                        fontSize: 10,
                        color: ZenoTheme.accent,
                        fontWeight: FontWeight.bold)),
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(loc,
                    style: const TextStyle(
                        fontSize: 9, color: ZenoTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamMember(String name, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontSize: 11)),
          const Spacer(),
          Text(status,
              style:
                  TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: ZenoTheme.textSecondary,
              letterSpacing: 1)),
    );
  }

  Widget _relatedItem(IconData icon, String label, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ZenoTheme.background,
                borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, size: 16, color: ZenoTheme.textSecondary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text(sub,
                  style: const TextStyle(
                      fontSize: 10, color: ZenoTheme.textSecondary)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,
              size: 10, color: ZenoTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _timelineItem(String time, String msg, {String? user}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (user != null)
                CircleAvatar(
                    radius: 10,
                    backgroundColor: ZenoTheme.accent.withValues(alpha: 0.2),
                    child: Text(user,
                        style: const TextStyle(
                            fontSize: 8,
                            color: ZenoTheme.accent,
                            fontWeight: FontWeight.bold)))
              else
                Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: ZenoTheme.accent, shape: BoxShape.circle)),
              Container(width: 1, height: 40, color: ZenoTheme.border),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time,
                    style: const TextStyle(
                        fontSize: 10, color: ZenoTheme.textSecondary)),
                const SizedBox(height: 4),
                Text(msg, style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fileItem(String name, String size, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: ZenoTheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ZenoTheme.border)),
      child: Row(
        children: [
          Icon(
              type == "IMAGE"
                  ? Icons.image_outlined
                  : Icons.description_outlined,
              size: 18,
              color: ZenoTheme.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text(size,
                  style: const TextStyle(
                      fontSize: 10, color: ZenoTheme.textSecondary)),
            ]),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download,
                  size: 16, color: ZenoTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _commentItem(String name, String msg, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(time,
                  style: const TextStyle(
                      fontSize: 9, color: ZenoTheme.textSecondary)),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: ZenoTheme.background,
                borderRadius: BorderRadius.circular(8)),
            child: Text(msg, style: const TextStyle(fontSize: 11, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget _aiInsight(String title, String msg, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14, color: color),
              const SizedBox(width: 8),
              Text(title.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          Text(msg,
              style:
                  const TextStyle(fontSize: 11, color: ZenoTheme.textPrimary)),
        ],
      ),
    );
  }

  Widget _miniActionIcon(IconData icon) {
    return Icon(icon, size: 14, color: ZenoTheme.textSecondary);
  }
}
