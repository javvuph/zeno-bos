import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class LowStockCentre extends StatelessWidget {
  const LowStockCentre({super.key});

  @override
  Widget build(BuildContext context) {
    final items = BIMockData.getLowStockItems();

    return BISectionContainer(
      title: "Low Stock Command Centre",
      accentColor: Colors.red,
      trailing: Row(
        children: [
          _headerAction(Icons.swap_horiz, "Transfer"),
          const SizedBox(width: 8),
          _headerAction(Icons.shopping_cart_outlined, "Restock All"),
        ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const Divider(color: ZenoTheme.border, height: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          final color = item['priority'] == 'Critical'
              ? Colors.red
              : (item['priority'] == 'High' ? Colors.orange : Colors.yellow);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['name'] as String,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                            _priorityBadge(item['priority'] as String, color),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                            "Current: ${item['stock']} | Min: ${item['min']} | Reorder: ${item['reorder']}",
                            style: const TextStyle(
                                fontSize: 10, color: ZenoTheme.textSecondary)),
                        Text(
                            "Warehouse: ${item['warehouse']} | Supplier: ${item['supplier']}",
                            style: const TextStyle(
                                fontSize: 10, color: ZenoTheme.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _stockOutIndicator(item['daysRemaining'] as int,
                      item['expectedOut'] as String),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _actionButton("VIEW", Icons.visibility_outlined,
                          ZenoTheme.textSecondary, () {}),
                      const SizedBox(width: 8),
                      _actionButton("CONTACT", Icons.phone_outlined,
                          ZenoTheme.neonCyan, () {}),
                      const SizedBox(width: 8),
                      _actionButton("CREATE PO", Icons.add_shopping_cart,
                          ZenoTheme.accent, () {}),
                    ],
                  ),
                ],
              ),
              if (item['priority'] == 'Critical') ...[
                const SizedBox(height: 10),
                _aiSuggestion(
                    "Recommend increasing stock by 20% due to upcoming seasonal surge."),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _headerAction(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: ZenoTheme.border, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Icon(icon, size: 12, color: ZenoTheme.textPrimary),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _priorityBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.2))),
      child: Text(label.toUpperCase(),
          style: TextStyle(
              fontSize: 8, fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _stockOutIndicator(int days, String date) {
    return Row(
      children: [
        Icon(Icons.timer_outlined,
            size: 12, color: days <= 3 ? Colors.red : Colors.orange),
        const SizedBox(width: 6),
        Text("Stock out in $days days ($date)",
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: days <= 3 ? Colors.red : Colors.orange)),
      ],
    );
  }

  Widget _actionButton(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Icon(icon, size: 10, color: color),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 8, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _aiSuggestion(String msg) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ZenoTheme.neonCyan.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: ZenoTheme.neonCyan.withValues(alpha: 0.1))),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 12, color: ZenoTheme.neonCyan),
          const SizedBox(width: 8),
          Expanded(
              child: Text(msg,
                  style: const TextStyle(
                      fontSize: 9, color: ZenoTheme.textPrimary))),
        ],
      ),
    );
  }
}
