import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class PurchaseMonitor extends StatelessWidget {
  const PurchaseMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Purchase & Vendor Monitor",
      accentColor: Colors.blue,
      child: Column(
        children: [
          // --- Custom Header ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: ZenoTheme.background.withValues(alpha: 0.5),
            child: const Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text("PO ID",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textSecondary))),
                Expanded(
                    flex: 3,
                    child: Text("VENDOR",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textSecondary))),
                Expanded(
                    flex: 2,
                    child: Text("STATUS",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textSecondary))),
                Expanded(
                    flex: 1,
                    child: Text("RATE",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textSecondary))),
                Expanded(
                    flex: 3,
                    child: Text("ACTIONS",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textSecondary),
                        textAlign: TextAlign.right)),
              ],
            ),
          ),
          const Divider(height: 1, color: ZenoTheme.border),
          // --- Data Rows ---
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildRow("PO-9912", "Intel Corp", "Delayed", Colors.red, 4.2),
                _buildRow(
                    "PO-9913", "Apple Inc", "In Transit", Colors.blue, 4.9),
                _buildRow("PO-9914", "Logitech", "Waiting", Colors.orange, 3.8),
                _buildRow(
                    "PO-9915", "Samsung", "Overdue", Colors.red.shade900, 4.5),
                _buildRow("PO-9916", "Dell Inc", "Approved",
                    ZenoTheme.neonGreen, 4.1),
              ],
            ),
          ),
          // --- Footer Metrics ---
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: ZenoTheme.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _miniMetric("Returns", "2", Colors.purple),
                _miniMetric("Conf. Pending", "5", Colors.orange),
                _miniMetric("On-Time", "94%", ZenoTheme.neonGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
      String id, String vendor, String status, Color color, double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ZenoTheme.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(id,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text(vendor,
                  style: const TextStyle(
                      fontSize: 11, overflow: TextOverflow.ellipsis))),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4)),
              child: Text(status.toUpperCase(),
                  style: TextStyle(
                      fontSize: 8, color: color, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Icon(Icons.star, size: 10, color: Colors.amber),
                const SizedBox(width: 4),
                Text(rating.toString(),
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _actionIcon(
                    Icons.local_shipping_outlined, ZenoTheme.neonCyan, "Track"),
                const SizedBox(width: 6),
                _actionIcon(
                    Icons.inventory_2_outlined, ZenoTheme.neonGreen, "Receive"),
                const SizedBox(width: 6),
                _actionIcon(
                    Icons.phone_outlined, ZenoTheme.textSecondary, "Contact"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4)),
        child: Icon(icon, size: 13, color: color),
      ),
    );
  }

  Widget _miniMetric(String label, String val, Color color) {
    return Row(
      children: [
        Text("$label: ",
            style:
                const TextStyle(fontSize: 9, color: ZenoTheme.textSecondary)),
        Text(val,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
