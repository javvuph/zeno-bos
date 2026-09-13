import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class HeaderButton extends StatelessWidget {
  final String label; final IconData icon; final bool isPrimary;
  const HeaderButton({super.key, required this.label, required this.icon, this.isPrimary = false});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: () {}, icon: Icon(icon, size: 16), label: Text(label), style: ElevatedButton.styleFrom(backgroundColor: isPrimary ? ZenoTheme.accent : ZenoTheme.surface, foregroundColor: Colors.white, side: isPrimary ? null : const BorderSide(color: ZenoTheme.border), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)));
  }
}

class HealthMetric extends StatelessWidget {
  final String label; final double value; final Color color;
  const HealthMetric({super.key, required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(fontSize: 12, color: ZenoTheme.textSecondary)), Text("${(value * 100).toInt()}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color))]),
      const SizedBox(height: 8),
      ClipRRect(borderRadius: BorderRadius.circular(2), child: LinearProgressIndicator(value: value, backgroundColor: color.withValues(alpha: 0.1), valueColor: AlwaysStoppedAnimation<Color>(color), minHeight: 4)),
    ]);
  }
}

class ActivityItem extends StatelessWidget {
  final String title; final String subtitle; final String time; final IconData icon; final Color color;
  const ActivityItem({super.key, required this.title, required this.subtitle, required this.time, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 20), child: Row(children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(icon, size: 14, color: color)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(fontSize: 11, color: ZenoTheme.textSecondary))])),
      Text(time, style: const TextStyle(fontSize: 10, color: ZenoTheme.textSecondary)),
    ]));
  }
}

class BarChartItem extends StatelessWidget {
  final String label; final double value; final Color color;
  const BarChartItem({super.key, required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(width: 40, height: 140 * value, decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color, color.withValues(alpha: 0.3)]), borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))),
      const SizedBox(height: 12),
      Text(label, style: const TextStyle(fontSize: 10, color: ZenoTheme.textSecondary)),
    ]);
  }
}
