import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/app/theme_colors.dart';

class GlobalFilterBar extends StatelessWidget {
  const GlobalFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final surface = colors?.bgSurface ?? ZenoTheme.surface;
    final border = colors?.borderSubtle ?? ZenoTheme.border;
    final textPrimary = colors?.textPrimary ?? ZenoTheme.textPrimary;
    final textSecondary = colors?.textSecondary ?? ZenoTheme.textSecondary;
    final accent = colors?.accentPrimary ?? ZenoTheme.neonCyan;

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.78),
        border: Border(bottom: BorderSide(color: border.withValues(alpha: 0.85))),
      ),
      child: Row(
        children: [
          Icon(Icons.tune_rounded, size: 16, color: textSecondary),
          SizedBox(width: 16),
          _FilterChip(label: "All Branches"),
          _FilterChip(label: "Last 30 Days"),
          _FilterChip(label: "All Categories"),
          _FilterChip(label: "USD (\$)"),
          Spacer(),
          _ActionButton(icon: Icons.refresh_rounded, label: "Refresh"),
          SizedBox(width: 8),
          _ActionButton(icon: Icons.file_download_outlined, label: "Export"),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final border = colors?.borderSubtle ?? ZenoTheme.border;
    final textPrimary = colors?.textPrimary ?? ZenoTheme.textPrimary;
    final textSecondary = colors?.textSecondary ?? ZenoTheme.textSecondary;
    final accent = colors?.accentPrimary ?? ZenoTheme.neonCyan;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.70),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(fontSize: 11, color: textPrimary, fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Icon(Icons.keyboard_arrow_down_rounded,
              size: 14, color: textSecondary),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final accent = colors?.accentPrimary ?? ZenoTheme.neonCyan;
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14, color: accent),
      label: Text(label,
          style: TextStyle(
              fontSize: 11,
              color: accent,
              fontWeight: FontWeight.w700)),
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12)),
    );
  }
}
