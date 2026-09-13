import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/safe_chart_container.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class InventoryIntelligence extends StatelessWidget {
  const InventoryIntelligence({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Inventory Intelligence",
      accentColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SelectionContainer.disabled(
                child: RepaintBoundary(
                  key: const ValueKey('inventory_intelligence_repaint_boundary'),
                  child: SafeChartContainer(
                    child: SfCartesianChart(
                      enableAxisAnimation: false,
                      key: const ValueKey('inventory_intelligence_cartesian_chart'),
                      margin: EdgeInsets.zero,
                      plotAreaBorderWidth: 0,
                      primaryXAxis: const CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        labelStyle: TextStyle(
                            fontSize: 8, color: ZenoTheme.textSecondary),
                      ),
                      primaryYAxis: const NumericAxis(
                        isVisible: false,
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      series: <CartesianSeries>[
                        ColumnSeries<_InventoryData, String>(
                          dataSource: [
                            _InventoryData('0-30d', 450, ZenoTheme.neonGreen),
                            _InventoryData('31-60d', 280, Colors.orange),
                            _InventoryData('61-90d', 150, Colors.red),
                            _InventoryData('90d+', 80, Colors.red.shade900),
                          ],
                          xValueMapper: (_InventoryData data, _) => data.x,
                          yValueMapper: (_InventoryData data, _) => data.y,
                          pointColorMapper: (_InventoryData data, _) => data.color,
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(4)),
                          animationDuration: 0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    _InventoryMetric(
                        label: "Inventory Turnover",
                        value: "8.4x",
                        trend: "+0.5",
                        color: ZenoTheme.neonCyan),
                    Divider(color: ZenoTheme.border, height: 16),
                    _InventoryMetric(
                        label: "Stock Accuracy",
                        value: "98.2%",
                        trend: "+1.2%",
                        color: ZenoTheme.neonGreen),
                    Divider(color: ZenoTheme.border, height: 16),
                    _InventoryMetric(
                        label: "Out of Stock Rate",
                        value: "2.4%",
                        trend: "-0.8%",
                        color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryMetric extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final Color color;

  const _InventoryMetric(
      {required this.label,
      required this.value,
      required this.trend,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: ZenoTheme.textSecondary)),
        Row(
          children: [
            Text(value,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            Text(trend,
                style: TextStyle(
                    fontSize: 9, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ],
    );
  }
}

class _InventoryData {
  _InventoryData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
