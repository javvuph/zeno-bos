import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/context_menu.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class BISparklineCard extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final bool isPositive;
  final Color color;
  final double targetProgress;
  final double width;
  final VoidCallback? onTap;

  const BISparklineCard({
    super.key,
    required this.label,
    required this.value,
    required this.trend,
    this.isPositive = true,
    required this.color,
    this.targetProgress = 0.75,
    this.width = 180,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZenoContextMenu(
      items: [
        ZenoContextMenuItem(
            label: 'Open Details',
            icon: Icons.open_in_new,
            onTap: onTap ?? () {}),
        ZenoContextMenuItem(
            label: 'Open in New Tab',
            icon: Icons.tab,
            onTap: () => NavigationController()
                .openTab('home/ana/revenue', title: label)),
        ZenoContextMenuItem(
            label: 'Export Data', icon: Icons.download, onTap: () {}),
        ZenoContextMenuItem(
            label: 'Pin to Workspace',
            icon: Icons.push_pin_outlined,
            onTap: () {}),
      ],
      child: InkWell(
        onTap: onTap ??
            () => NavigationController().navigateTo('home/ana/revenue'),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ZenoTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ZenoTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      label.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: ZenoTheme.textSecondary,
                          letterSpacing: 0.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: isPositive ? ZenoTheme.neonGreen : Colors.red),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: ZenoTheme.textPrimary)),
                  const SizedBox(width: 8),
                  Text(trend,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color:
                              isPositive ? ZenoTheme.neonGreen : Colors.red)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Target Actual",
                          style: TextStyle(
                              fontSize: 8, color: ZenoTheme.textSecondary)),
                      Text("${(targetProgress * 100).toInt()}%",
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: color)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: targetProgress,
                      minHeight: 3,
                      backgroundColor: ZenoTheme.border,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
