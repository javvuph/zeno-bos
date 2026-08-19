import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/fixed_asset.dart';
import '../../domain/models/asset_maintenance.dart';

class AssetMaintenancePanel extends StatelessWidget {
  final FixedAsset asset;
  final List<AssetMaintenance> history;
  const AssetMaintenancePanel(
      {super.key, required this.asset, required this.history});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.build_circle_outlined,
                  size: 20, color: Colors.orange),
              const SizedBox(width: 12),
              const Text("SERVICE HISTORY",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          if (history.isEmpty)
            const Center(
                child: Text("NO SERVICE RECORDS FOUND",
                    style: TextStyle(fontSize: 10, color: Colors.grey)))
          else
            ...history.map((m) => _buildMaintenanceRow(m)),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.auto_awesome, size: 14, color: Color(0xFF00F0FF)),
              SizedBox(width: 8),
              Text("AI PREDICTION: NEXT SERVICE DUE SEP 2026",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF00F0FF))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceRow(AssetMaintenance m) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 32,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.description.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold)),
                Text(
                    "${m.maintenanceDate.toString().substring(0, 10)} | ${m.vendorName ?? 'INTERNAL'}",
                    style: const TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Text("₹${m.cost.toStringAsFixed(0)}",
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
