import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/fixed_asset.dart';

class AssetFinancialPanel extends StatelessWidget {
  final FixedAsset asset;
  const AssetFinancialPanel({super.key, required this.asset});

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
              const Icon(Icons.calculate_outlined,
                  size: 20, color: Colors.blue),
              const SizedBox(width: 12),
              const Text("VALUATION SUMMARY",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 24),
          _buildRow("PURCHASE VALUE",
              "₹${asset.purchaseValue.toStringAsFixed(2)}", false),
          _buildRow("RESIDUAL VALUE",
              "₹${asset.residualValue.toStringAsFixed(2)}", false),
          _buildRow("CURRENT BOOK VALUE",
              "₹${asset.currentBookValue.toStringAsFixed(2)}", true),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          _buildRow("DEPRECIATION METHOD",
              asset.depreciationMethod.name.toUpperCase(), false),
          _buildRow("USEFUL LIFE", "${asset.usefulLifeMonths} MONTHS", false),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, bool isPrimary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: isPrimary ? const Color(0xFF00F0FF) : null)),
        ],
      ),
    );
  }
}
