import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

import 'package:intl/intl.dart';

class BIChartsFactory {
  // --- ROW 1: LARGE SALES TREND (COMPOSED AREA + LINE + BAR CHART) ---
  static Widget buildSalesTrendChart(List<SalesPoint> data) {
    return charts.SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.all(0),
      primaryXAxis: charts.DateTimeAxis(
        majorGridLines: const charts.MajorGridLines(width: 0),
        axisLine: const charts.AxisLine(width: 0),
        labelStyle: const TextStyle(
            color: Color(0xFF8A92A6), fontSize: 10, fontFamily: 'Inter'),
        dateFormat: DateFormat('MMM dd'), // Spec: MMM DD format
      ),
      primaryYAxis: charts.NumericAxis(
        majorGridLines: const charts.MajorGridLines(
            color: Color(0xFFE2E8F0), dashArray: [5, 5]),
        axisLine: const charts.AxisLine(width: 0),
        labelStyle: const TextStyle(
            color: Color(0xFF64748B), fontSize: 10, fontFamily: 'Inter'),
        numberFormat: NumberFormat.compactSimpleCurrency(
            decimalDigits: 0), // Spec: $300K format
      ),
      tooltipBehavior: charts.TooltipBehavior(
        enable: true,
        header: "",
        canShowMarker: true,
        color: const Color(0xFF1E293B),
        textStyle: const TextStyle(color: Colors.white),
      ),
      series: <charts.CartesianSeries>[
        // Dataset 3: Order Volume (Baseline vertical bars)
        charts.ColumnSeries<SalesPoint, DateTime>(
          dataSource: data,
          xValueMapper: (SalesPoint s, _) => s.date,
          yValueMapper: (SalesPoint s, _) =>
              s.revenue * 0.4, // Mock scaling for volume
          name: 'Order Volume',
          color: const Color(0xFF64748B).withValues(alpha: 0.1),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          animationDuration: 1000,
        ),
        // Dataset 1: Gross Sales (Area Spline with gradient)
        charts.SplineAreaSeries<SalesPoint, DateTime>(
          dataSource: data,
          xValueMapper: (SalesPoint s, _) => s.date,
          yValueMapper: (SalesPoint s, _) => s.revenue,
          name: 'Gross Sales',
          gradient: LinearGradient(
            colors: [
              const Color(0xFF3366FF).withValues(alpha: 0.25),
              const Color(0xFF3366FF).withValues(alpha: 0.0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderColor: const Color(0xFF3366FF),
          borderWidth: 3,
          animationDuration: 1500,
        ),
        // INJECTED Dataset: Total Expenses (Coral Red Spline Area)
        charts.SplineAreaSeries<SalesPoint, DateTime>(
          dataSource: data,
          xValueMapper: (SalesPoint s, _) => s.date,
          yValueMapper: (SalesPoint s, _) => s.expenses,
          name: 'Total Expenses',
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF1744).withValues(alpha: 0.15),
              const Color(0xFFFF1744).withValues(alpha: 0.0)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderColor: const Color(0xFFFF1744),
          borderWidth: 1.5,
          dashArray: const [4, 4],
          animationDuration: 1800,
        ),
        // Dataset 2: Net Profit (Emerald Green line)
        charts.SplineSeries<SalesPoint, DateTime>(
          dataSource: data,
          xValueMapper: (SalesPoint s, _) => s.date,
          yValueMapper: (SalesPoint s, _) => s.profit,
          name: 'Net Profit',
          color: const Color(0xFF00C853),
          width: 2.5,
          markerSettings: const charts.MarkerSettings(
            isVisible: true,
            height: 4,
            width: 4,
            shape: charts.DataMarkerType.circle,
            color: Color(0xFF00C853),
          ),
          animationDuration: 2000,
        ),
      ],
      legend: const charts.Legend(
        isVisible: false, // Custom legend in footer
      ),
    );
  }

  // --- ROW 2: DONUT CHART FOR CATEGORY PERFORMANCE ---
  static Widget buildDonutChart(List<ProductMetric> data) {
    return charts.SfCircularChart(
      margin: const EdgeInsets.all(0),
      series: <charts.CircularSeries>[
        charts.DoughnutSeries<ProductMetric, String>(
          dataSource: data,
          xValueMapper: (ProductMetric d, _) => d.name,
          yValueMapper: (ProductMetric d, _) => d.revenue,
          pointColorMapper: (ProductMetric d, _) => d.color,
          dataLabelSettings: const charts.DataLabelSettings(
            isVisible: true,
            labelPosition: charts.ChartDataLabelPosition.outside,
            textStyle: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B)),
          ),
          innerRadius: '65%',
          animationDuration: 1200,
        )
      ],
      legend: const charts.Legend(
        isVisible: true,
        position: charts.LegendPosition.right,
        textStyle: TextStyle(color: Color(0xFF64748B), fontSize: 9),
      ),
    );
  }

  // --- ROW 3: GAUGE CHART FOR FINANCIAL TARGETS ---
  static Widget buildTargetGauge(double value, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: gauges.SfRadialGauge(
            axes: <gauges.RadialAxis>[
              gauges.RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 180,
                endAngle: 0,
                radiusFactor: 1,
                axisLineStyle: const gauges.AxisLineStyle(
                  thickness: 8,
                  cornerStyle: gauges.CornerStyle.bothCurve,
                  color: Color(0xFFF1F5F9),
                ),
                pointers: <gauges.GaugePointer>[
                  gauges.RangePointer(
                    value: value,
                    width: 8,
                    pointerOffset: 0,
                    cornerStyle: gauges.CornerStyle.bothCurve,
                    color: color,
                    gradient: SweepGradient(
                      colors: [color.withValues(alpha: 0.7), color],
                      stops: const [0.2, 1.0],
                    ),
                  ),
                ],
                annotations: <gauges.GaugeAnnotation>[
                  gauges.GaugeAnnotation(
                    widget: Text(
                      '${value.toInt()}%',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    angle: 90,
                    positionFactor: 0.1,
                  )
                ],
              )
            ],
          ),
        ),
        Text(label.toUpperCase(),
            style: const TextStyle(
                fontSize: 8,
                color: ZenoTheme.textSecondary,
                letterSpacing: 0.5)),
      ],
    );
  }
}
