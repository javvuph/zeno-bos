import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class HomeWidgetData {
  final String id;
  final String title;
  final Widget widget;
  final int flex;

  HomeWidgetData(
      {required this.id,
      required this.title,
      required this.widget,
      this.flex = 1});
}

class HomeDataService {
  static List<HomeWidgetData> getDashboardWidgets() {
    return [
      HomeWidgetData(
        id: 'kpi_overview',
        title: 'KPI Overview',
        widget: const _KPIOverview(),
        flex: 2,
      ),
      HomeWidgetData(
        id: 'quick_actions',
        title: 'Quick Actions',
        widget: const _QuickActionsGrid(),
      ),
      HomeWidgetData(
        id: 'ai_insights',
        title: 'AI Insights',
        widget: const _AIInsightsList(),
      ),
      HomeWidgetData(
        id: 'recent_notifications',
        title: 'Recent Notifications',
        widget: const _NotificationsList(),
      ),
      HomeWidgetData(
        id: 'business_health',
        title: 'Business Health',
        widget: const _BusinessHealthMini(),
      ),
    ];
  }
}

// Internal Widget Implementation for the Service (Mocked)
class _KPIOverview extends StatelessWidget {
  const _KPIOverview();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _MiniStat(label: "Sales", value: "\$12k", color: ZenoTheme.neonGreen),
        SizedBox(width: 12),
        _MiniStat(label: "Orders", value: "42", color: Colors.orange),
        SizedBox(width: 12),
        _MiniStat(label: "Profit", value: "\$3.2k", color: ZenoTheme.neonCyan),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MiniStat(
      {required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.textSecondary)),
            Text(value,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w900, color: color)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _ActionIcon(icon: Icons.add_box, color: ZenoTheme.neonCyan),
        _ActionIcon(icon: Icons.shopping_cart, color: Colors.orange),
        _ActionIcon(icon: Icons.person_add, color: Colors.purple),
        _ActionIcon(icon: Icons.receipt, color: ZenoTheme.neonGreen),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _ActionIcon({required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
      child: Icon(icon, size: 16, color: color),
    );
  }
}

class _AIInsightsList extends StatelessWidget {
  const _AIInsightsList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SmallInsight(text: "Reorder iPhone 15 Pro.", icon: Icons.auto_awesome),
        _SmallInsight(
            text: "High demand expected in North.", icon: Icons.trending_up),
      ],
    );
  }
}

class _SmallInsight extends StatelessWidget {
  final String text;
  final IconData icon;
  const _SmallInsight({required this.text, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 12, color: ZenoTheme.neonCyan),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SmallNotify(title: "New order received", color: ZenoTheme.neonGreen),
        _SmallNotify(title: "Low stock alert", color: Colors.orange),
      ],
    );
  }
}

class _SmallNotify extends StatelessWidget {
  final String title;
  final Color color;
  const _SmallNotify({required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class _BusinessHealthMini extends StatelessWidget {
  const _BusinessHealthMini();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("88",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: ZenoTheme.neonGreen)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("HEALTHY",
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
              SizedBox(height: 4),
              LinearProgressIndicator(
                  value: 0.88,
                  minHeight: 2,
                  color: ZenoTheme.neonGreen,
                  backgroundColor: ZenoTheme.border),
            ],
          ),
        ),
      ],
    );
  }
}
