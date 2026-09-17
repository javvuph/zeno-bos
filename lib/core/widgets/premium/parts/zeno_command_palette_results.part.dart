part of '../zeno_command_palette.dart';

class _ResultItem extends StatelessWidget {
  final ZenoSearchResult result;
  final ZenoSemanticColors colors;
  const _ResultItem({required this.result, required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        NavigationController().navigateTo(result.route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(result.icon,
                size: 20, color: result.color ?? colors.textSecondary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.title.toUpperCase(),
                      style: ZenoTypography.bodyLG(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(result.subtitle,
                      style: ZenoTypography.micro(colors.textDisabled)),
                ],
              ),
            ),
            _TypeBadge(type: result.type, colors: colors),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final SearchResultType type;
  final ZenoSemanticColors colors;
  const _TypeBadge({required this.type, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(4)),
      child: Text(type.name.toUpperCase(),
          style: ZenoTypography.micro(colors.textDisabled)),
    );
  }
}

class _QuickCommand extends StatelessWidget {
  final String label;
  final IconData icon;
  final ZenoSemanticColors colors;
  final String route;
  const _QuickCommand(
      {required this.label,
      required this.icon,
      required this.colors,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        NavigationController().navigateTo(route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 16, color: colors.textSecondary),
            const SizedBox(width: 12),
            Text(label, style: ZenoTypography.bodyMD(colors.textPrimary)),
          ],
        ),
      ),
    );
  }
}

class _CommandKBadge extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _CommandKBadge({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Text("ESC", style: ZenoTypography.micro(colors.amberGold)),
    );
  }
}

class _PaletteFooter extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _PaletteFooter({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12))),
      child: Row(
        children: [
          _Hint(label: "ENTER", action: "to select", colors: colors),
          const SizedBox(width: 16),
          _Hint(label: "↑↓", action: "to navigate", colors: colors),
          const Spacer(),
          Text("ZENO NEURAL SEARCH v1.0",
              style: ZenoTypography.micro(colors.textDisabled)),
        ],
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  final String label;
  final String action;
  final ZenoSemanticColors colors;
  const _Hint(
      {required this.label, required this.action, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
              color: colors.bgTier3, borderRadius: BorderRadius.circular(2)),
          child: Text(label, style: ZenoTypography.micro(colors.textPrimary)),
        ),
        const SizedBox(width: 6),
        Text(action, style: ZenoTypography.micro(colors.textDisabled)),
      ],
    );
  }
}
