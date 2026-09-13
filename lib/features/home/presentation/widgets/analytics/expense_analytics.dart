import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class ExpenseAnalytics extends StatelessWidget {
  const ExpenseAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Expense Analytics",
      accentColor: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SelectionContainer.disabled(
                child: RepaintBoundary(
                  key: const ValueKey('expense_analytics_repaint_boundary'),
                  child: SfCartesianChart(
                    key: const ValueKey('expense_analytics_cartesian_chart'),
                    margin: EdgeInsets.zero,
                    plotAreaBorderWidth: 0,
                    primaryXAxis: const CategoryAxis(isVisible: false),
                    primaryYAxis: const NumericAxis(isVisible: false),
                    series: <CartesianSeries>[
                      StackedBarSeries<_ExpenseData, String>(
                        dataSource: [
                          _ExpenseData('Logistics', 45, Colors.blue),
                          _ExpenseData('Rent', 30, Colors.purple),
                          _ExpenseData('Salaries', 60, Colors.orange),
                          _ExpenseData('Marketing', 25, Colors.pink),
                        ],
                        xValueMapper: (_ExpenseData data, _) => "Expenses",
                        yValueMapper: (_ExpenseData data, _) => data.value,
                        pointColorMapper: (_ExpenseData data, _) => data.color,
                        animationDuration: 0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 5,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  _ExpenseItem(
                      label: "Salaries", value: "\$60k", color: Colors.orange),
                  _ExpenseItem(
                      label: "Logistics", value: "\$45k", color: Colors.blue),
                  _ExpenseItem(
                      label: "Rent", value: "\$30k", color: Colors.purple),
                  _ExpenseItem(
                      label: "Marketing", value: "\$25k", color: Colors.pink),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _ExpenseItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 8,
                  height: 8,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: ZenoTheme.textSecondary)),
            ],
          ),
          Text(value,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ExpenseData {
  _ExpenseData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}
