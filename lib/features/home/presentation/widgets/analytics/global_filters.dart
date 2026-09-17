import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class GlobalFilterBar extends StatelessWidget {
  const GlobalFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: ZenoTheme.surface,
        border: Border(bottom: BorderSide(color: ZenoTheme.border)),
      ),
      child: const Row(
        children: [
          Icon(Icons.filter_list, size: 16, color: ZenoTheme.textSecondary),
          SizedBox(width: 16),
          _FilterChip(label: "All Branches"),
          _FilterChip(label: "Last 30 Days"),
          _FilterChip(label: "All Categories"),
          _FilterChip(label: "USD (\$)"),
          Spacer(),
          _ActionButton(icon: Icons.refresh, label: "Refresh"),
          SizedBox(width: 8),
          _ActionButton(icon: Icons.ios_share, label: "Export"),
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
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ZenoTheme.background,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: Row(
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 11, color: ZenoTheme.textPrimary)),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down,
              size: 14, color: ZenoTheme.textSecondary),
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
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14, color: ZenoTheme.neonCyan),
      label: Text(label,
          style: const TextStyle(
              fontSize: 11,
              color: ZenoTheme.neonCyan,
              fontWeight: FontWeight.bold)),
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12)),
    );
  }
}
