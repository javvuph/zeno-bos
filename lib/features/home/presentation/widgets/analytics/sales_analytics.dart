import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/widgets/analytics/bi_charts_factory.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class SalesAnalyticsSection extends StatelessWidget {
  const SalesAnalyticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Enterprise Sales & Profit Intelligence",
      accentColor: ZenoTheme.neonCyan,
      trailing: _buildControls(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: BIChartsFactory.buildSalesTrendChart(BIMockData.getSalesTrend()),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      children: [
        _miniActionIcon(Icons.fullscreen),
        const SizedBox(width: 8),
        _miniActionIcon(Icons.download),
        const SizedBox(width: 12),
        _filterTab("DAILY", false),
        _filterTab("WEEKLY", true),
        _filterTab("MONTHLY", false),
      ],
    );
  }

  Widget _miniActionIcon(IconData icon) {
    return Icon(icon, size: 14, color: ZenoTheme.textSecondary);
  }

  Widget _filterTab(String label, bool active) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: active
            ? ZenoTheme.neonCyan.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border:
            Border.all(color: active ? ZenoTheme.neonCyan : Colors.transparent),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: active ? ZenoTheme.neonCyan : ZenoTheme.textSecondary),
      ),
    );
  }
}
