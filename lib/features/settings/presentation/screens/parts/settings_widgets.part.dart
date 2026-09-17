part of '../settings_main_screen.dart';

class _SettingRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ZenoSemanticColors colors;
  final VoidCallback? onTap;
  const _SettingRow(
      {required this.label,
      required this.value,
      required this.icon,
      required this.colors,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: colors.borderSubtle.withValues(alpha: 0.5)))),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colors.textDisabled),
            const SizedBox(width: 16),
            Expanded(
                child: Text(label,
                    style: ZenoTypography.caption(colors.textSecondary)
                        .copyWith(fontWeight: FontWeight.bold))),
            Text(value,
                style: ZenoTypography.bodyMD(colors.accentPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, size: 16, color: colors.textDisabled),
          ],
        ),
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ZenoSemanticColors colors;
  const _SettingToggle(
      {required this.label, required this.value, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: colors.borderSubtle.withValues(alpha: 0.5)))),
      child: Row(
        children: [
          Expanded(
              child: Text(label,
                  style: ZenoTypography.caption(colors.textSecondary)
                      .copyWith(fontWeight: FontWeight.bold))),
          Switch(
              value: value,
              onChanged: (v) {},
              activeTrackColor: colors.accentPrimary),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ZenoSemanticColors colors;
  const _ModuleCard(
      {required this.title, required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: colors.accentPrimary),
          const SizedBox(height: 16),
          Text(title,
              style: ZenoTypography.caption(colors.textPrimary)
                  .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class _PlaceholderForm extends StatelessWidget {
  final String label;
  const _PlaceholderForm({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _RepositoryLinkCard extends StatelessWidget {
  const _RepositoryLinkCard();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.link, size: 18, color: ZenoTheme.accent),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'https://github.com/javvuph/zeno-bos',
              style: TextStyle(
                fontSize: 12,
                color: ZenoTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _openRepository() async {
  final uri = Uri.parse('https://github.com/javvuph/zeno-bos');
  if (!await canLaunchUrl(uri)) {
    return;
  }
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class _SettingsAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  const _SettingsAction(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
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
