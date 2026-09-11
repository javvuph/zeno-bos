import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class FinancialOverview extends StatelessWidget {
  const FinancialOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Financial Overview",
      accentColor: ZenoTheme.neonGreen,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SelectionContainer.disabled(
                child: RepaintBoundary(
                  key: const ValueKey('financial_overview_repaint_boundary'),
                  child: SfCartesianChart(
                    key: const ValueKey('financial_overview_cartesian_chart'),
                    margin: EdgeInsets.zero,
                    plotAreaBorderWidth: 0,
                    primaryXAxis: const CategoryAxis(isVisible: false),
                    primaryYAxis: const NumericAxis(isVisible: false),
                    series: <CartesianSeries>[
                      AreaSeries<_FinanceData, String>(
                        dataSource: [
                          _FinanceData('Jan', 120),
                          _FinanceData('Feb', 150),
                          _FinanceData('Mar', 140),
                          _FinanceData('Apr', 180),
                          _FinanceData('May', 210),
                        ],
                        xValueMapper: (_FinanceData data, _) => data.month,
                        yValueMapper: (_FinanceData data, _) => data.value,
                        color: ZenoTheme.neonGreen.withValues(alpha: 0.2),
                        borderColor: ZenoTheme.neonGreen,
                        borderWidth: 2,
                        animationDuration: 0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _FinanceCard(
                        label: "Cash Flow", value: "\$840k", isPositive: true),
                    _FinanceCard(
                        label: "Net Profit", value: "\$124k", isPositive: true),
                    _FinanceCard(
                        label: "Payables", value: "\$45k", isPositive: false),
                    _FinanceCard(
                        label: "Receivables", value: "\$92k", isPositive: true),
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

class _FinanceCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isPositive;

  const _FinanceCard(
      {required this.label, required this.value, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ZenoTheme.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 9,
                  color: ZenoTheme.textSecondary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: isPositive ? ZenoTheme.neonGreen : Colors.red)),
        ],
      ),
    );
  }
}

class _FinanceData {
  _FinanceData(this.month, this.value);
  final String month;
  final double value;
}
