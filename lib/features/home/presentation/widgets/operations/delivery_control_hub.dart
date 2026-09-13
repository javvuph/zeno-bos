import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class DeliveryControlHub extends StatelessWidget {
  const DeliveryControlHub({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Logistics & Delivery Control",
      accentColor: ZenoTheme.neonCyan,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatusBlock(
                    label: "DISPATCH", count: "12", color: Colors.orange),
                _StatusBlock(
                    label: "TRANSIT", count: "24", color: ZenoTheme.neonCyan),
                _StatusBlock(
                    label: "DELIVERED",
                    count: "145",
                    color: ZenoTheme.neonGreen),
                _StatusBlock(label: "RETURNED", count: "3", color: Colors.red),
              ],
            ),
          ),
          const Divider(height: 1, color: ZenoTheme.border),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 3,
              separatorBuilder: (_, __) =>
                  const Divider(color: ZenoTheme.border, height: 1),
              itemBuilder: (context, index) {
                final events = [
                  {
                    "id": "DEL-881",
                    "loc": "Downtown",
                    "driver": "Mark",
                    "v": "TRK-01",
                    "status": "Delayed",
                    "color": Colors.red
                  },
                  {
                    "id": "DEL-892",
                    "loc": "East Side",
                    "driver": "Sarah",
                    "v": "VAN-04",
                    "status": "In Transit",
                    "color": ZenoTheme.neonCyan
                  },
                  {
                    "id": "DEL-901",
                    "loc": "HQ Region",
                    "driver": "John",
                    "v": "BIK-12",
                    "status": "Returned",
                    "color": Colors.orange
                  },
                ];
                final item = events[index];
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color:
                                (item['color'] as Color).withValues(alpha: 0.1),
                            shape: BoxShape.circle),
                        child: Icon(Icons.local_shipping_outlined,
                            size: 14, color: item['color'] as Color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['id'] as String,
                                style: const TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.bold)),
                            Text("${item['loc']} • ${item['v']}",
                                style: const TextStyle(
                                    fontSize: 9,
                                    color: ZenoTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item['status'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: item['color'] as Color,
                                  fontWeight: FontWeight.bold)),
                          Text(item['driver'] as String,
                              style: const TextStyle(
                                  fontSize: 8, color: ZenoTheme.textSecondary)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      _miniAction(Icons.gps_fixed, "Track"),
                      const SizedBox(width: 6),
                      _miniAction(Icons.print_outlined, "Label"),
                      const SizedBox(width: 6),
                      _miniAction(Icons.phone_outlined, "Customer"),
                    ],
                  ),
                );
              },
            ),
          ),
          _fleetSummary(),
        ],
      ),
    );
  }

  Widget _fleetSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ZenoTheme.surface.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _miniStat("Active Drivers", "8/10", ZenoTheme.neonGreen),
          _miniStat("Avg Delivery", "1.2h", ZenoTheme.neonCyan),
          _miniStat("Fuel Efficiency", "92%", Colors.orange),
          _miniStat("Fleet Status", "Optimal", ZenoTheme.textPrimary),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String val, Color color) {
    return Column(
      children: [
        Text(val,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w900, color: color)),
        Text(label,
            style: const TextStyle(
                fontSize: 8,
                color: ZenoTheme.textSecondary,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _StatusBlock(
      {required String label, required String count, required Color color}) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900, color: color)),
        Text(label,
            style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: ZenoTheme.textSecondary,
                letterSpacing: 0.5)),
      ],
    );
  }

  Widget _miniAction(IconData icon, String tip) {
    return Tooltip(
      message: tip,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: ZenoTheme.border, borderRadius: BorderRadius.circular(4)),
          child: Icon(icon, size: 12, color: ZenoTheme.textPrimary),
        ),
      ),
    );
  }
}
