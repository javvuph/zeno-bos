import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class EnterpriseRightPanel extends StatelessWidget {
  const EnterpriseRightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: ZenoTheme.workspaceBackground,
        border: Border(left: BorderSide(color: ZenoTheme.border)),
      ),
      child: Column(
        children: [
          // HEADER
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ZenoTheme.border)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome,
                    size: 18, color: ZenoTheme.primary),
                const SizedBox(width: 12),
                const Text(
                  "AI Copilot",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.open_in_full, size: 16),
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _PanelSection(
                  title: "Business Insights",
                  child: Column(
                    children: [
                      _InsightCard(
                        text: "230 products are running low on stock.",
                        type: "warning",
                      ),
                      SizedBox(height: 12),
                      _InsightCard(
                        text: "45 products are out of stock.",
                        type: "danger",
                      ),
                      SizedBox(height: 12),
                      _InsightCard(
                        text: "Inventory value increased by 12.5% this month.",
                        type: "success",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                _PanelSection(
                  title: "Recent Activity",
                  child: Column(
                    children: [
                      _ActivityItem(
                        icon: Icons.laptop,
                        title: "Laptop Z-Book Pro 15",
                        desc: "Updated by John Perera",
                        time: "2 min ago",
                      ),
                      _ActivityItem(
                        icon: Icons.smartphone,
                        title: "Smartphone Z-10",
                        desc: "Price updated",
                        time: "15 min ago",
                      ),
                      _ActivityItem(
                        icon: Icons.chair,
                        title: "Office Chair Ergonomic",
                        desc: "Stock updated",
                        time: "1 hour ago",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                _PanelSection(
                  title: "Quick Actions",
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _SmallActionButton(icon: Icons.add, label: "New Product"),
                      _SmallActionButton(
                          icon: Icons.upload, label: "Import Products"),
                      _SmallActionButton(
                          icon: Icons.edit, label: "Adjust Stock"),
                      _SmallActionButton(
                          icon: Icons.qr_code, label: "Generate Barcode"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _PanelSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: ZenoTheme.textSecondary,
              letterSpacing: 1),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String text;
  final String type;

  const _InsightCard({required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    Color color = ZenoTheme.primary;
    if (type == "warning") color = ZenoTheme.warning;
    if (type == "danger") color = ZenoTheme.danger;
    if (type == "success") color = ZenoTheme.success;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, height: 1.4),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final String time;

  const _ActivityItem(
      {required this.icon,
      required this.title,
      required this.desc,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ZenoTheme.background,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 14, color: ZenoTheme.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11, color: ZenoTheme.textSecondary)),
              ],
            ),
          ),
          Text(time,
              style: const TextStyle(
                  fontSize: 10, color: ZenoTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SmallActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: ZenoTheme.primary),
          const SizedBox(width: 6),
          Text(label,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
