part of '../zeno_data_grid_template.dart';

class _ToolbarIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final ZenoSemanticColors colors;
  final VoidCallback? onTap;

  const _ToolbarIcon(
      {required this.icon,
      required this.tooltip,
      required this.colors,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onTap ?? () {},
        icon: Icon(icon, size: 18, color: colors.textSecondary),
        visualDensity: VisualDensity.compact,
        hoverColor: colors.bgHover,
      ),
    );
  }
}

class _PageNumber extends StatelessWidget {
  final String label;
  final bool isActive;
  final ZenoSemanticColors colors;

  const _PageNumber(
      {required this.label, required this.colors, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? colors.accentPrimary : colors.textSecondary,
        ),
      ),
    );
  }
}

class _PageArrow extends StatelessWidget {
  final IconData icon;
  final ZenoSemanticColors colors;
  const _PageArrow({required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 18, color: colors.textSecondary);
  }
}

class _VerticalDivider extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _VerticalDivider({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 16, color: colors.borderSubtle);
  }
}
