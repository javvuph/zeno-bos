import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/context_menu.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/bi_widgets_cards.part.dart';

class BISectionContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final Color? accentColor;
  final VoidCallback? onTap;

  const BISectionContainer({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZenoContextMenu(
      items: [
        ZenoContextMenuItem(
            label: 'Full Screen', icon: Icons.fullscreen, onTap: () {}),
        ZenoContextMenuItem(
            label: 'Refresh Data', icon: Icons.refresh, onTap: () {}),
        ZenoContextMenuItem(
            label: 'Export PDF',
            icon: Icons.picture_as_pdf_outlined,
            onTap: () {}),
        ZenoContextMenuItem(
            label: 'AI Analysis', icon: Icons.auto_awesome, onTap: () {}),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: ZenoTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ZenoTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (accentColor != null)
                          Container(
                            width: 3,
                            height: 14,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                        Text(title.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8)),
                      ],
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: ZenoTheme.border),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class BIAnalyticRow extends StatelessWidget {
  final String label;
  final String value;
  final double percentage;
  final Color color;

  const BIAnalyticRow({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: ZenoTheme.textSecondary)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 4,
              backgroundColor: ZenoTheme.border,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class AIRiskBadge extends StatelessWidget {
  final String level;
  final String message;
  final Color color;

  const AIRiskBadge(
      {super.key,
      required this.level,
      required this.message,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.report_problem_outlined, size: 14, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(level.toUpperCase(),
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: color,
                        letterSpacing: 0.5)),
                const SizedBox(height: 2),
                Text(message,
                    style: const TextStyle(
                        fontSize: 11, color: ZenoTheme.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
