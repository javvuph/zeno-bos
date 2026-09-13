import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class EnterpriseBottomStatusBar extends StatelessWidget {
  const EnterpriseBottomStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 22,
      decoration: BoxDecoration(
        color: colors.bgTier1, // Same as Tier 1 for consistency
        border: Border(top: BorderSide(color: colors.borderSubtle)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _StatusIndicator(
              icon: Icons.link,
              label: "Connected",
              color: colors.statusSuccess),
          const _StatusDivider(),

          const Spacer(),

          _StatusIndicator(
              icon: Icons.circle,
              label: "AI Status: Ready",
              color: colors.statusSuccess),
          const _StatusDivider(),
          Icon(Icons.cast, size: 12, color: colors.textSecondary),
          const SizedBox(width: 10),
          Icon(Icons.wb_sunny_outlined, size: 12, color: colors.textSecondary),
          const SizedBox(width: 10),
          Icon(Icons.dark_mode_outlined, size: 12, color: colors.textSecondary),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _StatusIndicator({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Row(
      children: [
        Icon(icon, size: 12, color: color ?? colors.textSecondary),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(fontSize: 9.5, color: colors.textSecondary)),
      ],
    );
  }
}

class _StatusDivider extends StatelessWidget {
  const _StatusDivider();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: 1,
      height: 12,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
