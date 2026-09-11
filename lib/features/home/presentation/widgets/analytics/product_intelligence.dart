import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class ProductIntelligence extends StatelessWidget {
  const ProductIntelligence({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Product Intelligence",
      accentColor: ZenoTheme.neonCyan,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: SelectionContainer.disabled(
                child: RepaintBoundary(
                  key: const ValueKey('product_intelligence_repaint_boundary'),
                  child: SfCircularChart(
                  key: const ValueKey('product_intelligence_circular_chart'),
                  margin: EdgeInsets.zero,
                  series: <CircularSeries>[
                    DoughnutSeries<_ChartData, String>(
                      dataSource: [
                        _ChartData('Electronics', 45, ZenoTheme.neonCyan),
                        _ChartData('Appliances', 25, ZenoTheme.neonGreen),
                        _ChartData('Mobile', 20, Colors.orange),
                        _ChartData('Laptops', 10, Colors.purple),
                      ],
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      pointColorMapper: (_ChartData data, _) => data.color,
                      innerRadius: '70%',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      animationDuration: 0,
                    )
                  ],
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("TOTAL",
                              style: TextStyle(
                                  fontSize: 8,
                                  color: ZenoTheme.textSecondary,
                                  fontWeight: FontWeight.bold)),
                          Text("\$1.2M",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: ZenoTheme.neonCyan)),
                        ],
                      ),
                    )
                  ],
                ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BIAnalyticRow(
                        label: "Electronics",
                        value: "\$540k",
                        percentage: 45,
                        color: ZenoTheme.neonCyan),
                    BIAnalyticRow(
                        label: "Appliances",
                        value: "\$300k",
                        percentage: 25,
                        color: ZenoTheme.neonGreen),
                    BIAnalyticRow(
                        label: "Mobile",
                        value: "\$240k",
                        percentage: 20,
                        color: Colors.orange),
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

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
