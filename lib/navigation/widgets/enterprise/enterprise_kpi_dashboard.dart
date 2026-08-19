import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class EnterpriseKPIDashboard extends StatelessWidget {
  final List<KPICardData> items;

  const EnterpriseKPIDashboard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ZenoTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ZenoTheme.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: const TextStyle(
                          fontSize: 12,
                          color: ZenoTheme.textSecondary,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(item.icon,
                        size: 16, color: item.color ?? ZenoTheme.primary),
                  ],
                ),
                const Spacer(),
                Text(
                  item.value,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ZenoTheme.textPrimary),
                ),
                if (item.change != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        item.isPositive
                            ? Icons.trending_up
                            : Icons.trending_down,
                        size: 12,
                        color: item.isPositive
                            ? ZenoTheme.success
                            : ZenoTheme.danger,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.change!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: item.isPositive
                              ? ZenoTheme.success
                              : ZenoTheme.danger,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text("from last month",
                          style: TextStyle(
                              fontSize: 10, color: ZenoTheme.textSecondary)),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class KPICardData {
  final String label;
  final String value;
  final String? change;
  final bool isPositive;
  final IconData icon;
  final Color? color;

  const KPICardData({
    required this.label,
    required this.value,
    this.change,
    this.isPositive = true,
    required this.icon,
    this.color,
  });
}
