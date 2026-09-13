import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/safe_chart_container.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class AIForecastingHub extends StatelessWidget {
  const AIForecastingHub({super.key});

  @override
  Widget build(BuildContext context) {
    final data = BIMockData.getForecastData();

    return BISectionContainer(
      title: "Business Forecasting Engine",
      accentColor: ZenoTheme.accent,
      trailing: _buildLegend(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SelectionContainer.disabled(
          child: RepaintBoundary(
            key: const ValueKey('ai_forecasting_repaint_boundary'),
            child: SafeChartContainer(
              child: charts.SfCartesianChart(
                key: const ValueKey('ai_forecasting_cartesian_chart'),
                plotAreaBorderWidth: 0,
                margin: EdgeInsets.zero,
                primaryXAxis: charts.DateTimeAxis(
                  majorGridLines: const charts.MajorGridLines(width: 0),
                  labelStyle:
                      const TextStyle(fontSize: 9, color: ZenoTheme.textSecondary),
                ),
                primaryYAxis: charts.NumericAxis(
                  majorGridLines: const charts.MajorGridLines(
                      color: ZenoTheme.border, dashArray: [5, 5]),
                  axisLine: const charts.AxisLine(width: 0),
                  labelStyle:
                      const TextStyle(fontSize: 9, color: ZenoTheme.textSecondary),
                ),
                tooltipBehavior:
                    charts.TooltipBehavior(enable: true, header: "Forecast", animationDuration: 0),
                series: <charts.CartesianSeries<ForecastPoint, DateTime>>[
                  charts.RangeAreaSeries<ForecastPoint, DateTime>(
                    dataSource: data,
                    xValueMapper: (ForecastPoint p, _) => p.date,
                    lowValueMapper: (ForecastPoint p, _) => p.lower ?? p.predicted,
                    highValueMapper: (ForecastPoint p, _) => p.upper ?? p.predicted,
                    color: ZenoTheme.accent.withValues(alpha: 0.1),
                    name: 'Confidence Range',
                    animationDuration: 0,
                  ),
                  charts.LineSeries<ForecastPoint, DateTime>(
                    dataSource: data,
                    xValueMapper: (ForecastPoint p, _) => p.date,
                    yValueMapper: (ForecastPoint p, _) => p.predicted,
                    color: ZenoTheme.neonCyan,
                    width: 2,
                    dashArray: const [5, 5],
                    name: 'Predicted',
                    markerSettings: const charts.MarkerSettings(
                        isVisible: true, width: 4, height: 4),
                    animationDuration: 0,
                  ),
                  charts.LineSeries<ForecastPoint, DateTime>(
                    dataSource: data,
                    xValueMapper: (ForecastPoint p, _) => p.date,
                    yValueMapper: (ForecastPoint p, _) => p.actual,
                    color: ZenoTheme.neonGreen,
                    width: 3,
                    name: 'Actual',
                    markerSettings: const charts.MarkerSettings(
                        isVisible: true, shape: charts.DataMarkerType.circle),
                    animationDuration: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _legendItem("Actual", ZenoTheme.neonGreen, false),
        const SizedBox(width: 12),
        _legendItem("Predicted", ZenoTheme.neonCyan, true),
      ],
    );
  }

  Widget _legendItem(String label, Color color, bool dashed) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                color: ZenoTheme.textSecondary,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
