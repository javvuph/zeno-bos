import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class BranchPerformance extends StatelessWidget {
  const BranchPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Branch Performance",
      accentColor: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SelectionContainer.disabled(
          child: RepaintBoundary(
            key: const ValueKey('branch_performance_repaint_boundary'),
            child: SfCartesianChart(
              key: const ValueKey('branch_performance_cartesian_chart'),
              margin: EdgeInsets.zero,
              plotAreaBorderWidth: 0,
              primaryXAxis: const CategoryAxis(
                labelStyle:
                    TextStyle(fontSize: 9, color: ZenoTheme.textSecondary),
                majorGridLines: MajorGridLines(width: 0),
              ),
              primaryYAxis: const NumericAxis(
                isVisible: false,
              ),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: TextStyle(fontSize: 9, color: ZenoTheme.textSecondary),
              ),
              series: <CartesianSeries>[
                StackedColumnSeries<_BranchData, String>(
                  name: 'Revenue',
                  dataSource: [
                    _BranchData('North', 450, 120),
                    _BranchData('South', 380, 95),
                    _BranchData('East', 310, 80),
                    _BranchData('West', 290, 75),
                  ],
                  xValueMapper: (_BranchData data, _) => data.branch,
                  yValueMapper: (_BranchData data, _) => data.revenue,
                  color: ZenoTheme.neonCyan,
                  animationDuration: 0,
                ),
                StackedColumnSeries<_BranchData, String>(
                  name: 'Profit',
                  dataSource: [
                    _BranchData('North', 450, 120),
                    _BranchData('South', 380, 95),
                    _BranchData('East', 310, 80),
                    _BranchData('West', 290, 75),
                  ],
                  xValueMapper: (_BranchData data, _) => data.branch,
                  yValueMapper: (_BranchData data, _) => data.profit,
                  color: ZenoTheme.neonGreen,
                  animationDuration: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BranchData {
  _BranchData(this.branch, this.revenue, this.profit);
  final String branch;
  final double revenue;
  final double profit;
}
