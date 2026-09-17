part of '../top_command_bar.dart';

class _UserProfileChip extends StatelessWidget {
  const _UserProfileChip();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.only(left: 4, right: 12, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: colors.borderSubtle,
              child: Icon(Icons.person_rounded,
                  size: 18, color: colors.textPrimary),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "",
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 10,
                      fontFamily: 'Inter',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCenter extends StatelessWidget {
  const _NotificationCenter();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.notifications_none_rounded,
              size: 22, color: Color(0xFF8A92A6)),
          visualDensity: VisualDensity.compact,
        ),
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: colors.statusDanger,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: colors.statusDanger.withValues(alpha: 0.4),
                    blurRadius: 4),
              ],
            ),
            constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
            child: const Text(
              "0",
              style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickSettings extends StatelessWidget {
  const _QuickSettings();

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.settings_outlined, size: 20, color: Color(0xFF8A92A6)),
      visualDensity: VisualDensity.compact,
    );
  }
}
