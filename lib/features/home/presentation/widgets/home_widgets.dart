import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class CommandCenterWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final Color? accentColor;

  const CommandCenterWidget({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return ZenoCard(
      title: title.toUpperCase(),
      trailing: trailing,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (accentColor != null)
            Container(
              height: 2,
              width: 32,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: accentColor,
                boxShadow: [
                  BoxShadow(
                      color: accentColor!.withValues(alpha: 0.5),
                      blurRadius: 4),
                ],
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class HomeStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? trend;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const HomeStatCard({
    super.key,
    required this.label,
    required this.value,
    this.trend,
    this.isPositive = true,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: ZenoTheme.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: ZenoTheme.textPrimary,
                      ),
                    ),
                    if (trend != null) ...[
                      const SizedBox(width: 8),
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        size: 12,
                        color:
                            isPositive ? ZenoTheme.success : ZenoTheme.danger,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color:
                              isPositive ? ZenoTheme.success : ZenoTheme.danger,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeQuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeQuickAction({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: ZenoTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeNotificationItem extends StatelessWidget {
  final String title;
  final String time;
  final String type;
  final Color color;
  final bool isAI;

  const HomeNotificationItem({
    super.key,
    required this.title,
    required this.time,
    required this.type,
    required this.color,
    this.isAI = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4)
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      type.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: color,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (isAI) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: ZenoTheme.neonCyan.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "AI",
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: ZenoTheme.neonCyan),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      time,
                      style: const TextStyle(
                          fontSize: 9, color: ZenoTheme.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13, color: ZenoTheme.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
