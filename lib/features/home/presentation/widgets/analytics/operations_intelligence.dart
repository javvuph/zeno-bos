import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';

class OperationsIntelligence extends StatelessWidget {
  const OperationsIntelligence({super.key});

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title: "Operations Intelligence",
      accentColor: ZenoTheme.neonGreen,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 180,
                    endAngle: 0,
                    radiusFactor: 0.9,
                    canScaleToFit: true,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 0.15,
                      color: ZenoTheme.border,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: const <GaugePointer>[
                      RangePointer(
                        value: 84,
                        width: 0.15,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: ZenoTheme.neonGreen,
                        cornerStyle: CornerStyle.bothCurve,
                      )
                    ],
                    annotations: const <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("EFFICIENCY",
                                style: TextStyle(
                                    fontSize: 8,
                                    color: ZenoTheme.textSecondary,
                                    fontWeight: FontWeight.bold)),
                            Text("84%",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: ZenoTheme.neonGreen)),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.1,
                      )
                    ],
                  )
                ],
              ),
            ),
            const Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _OpMetric(
                        label: "Process Velocity",
                        value: "1.2h",
                        target: "1.5h"),
                    Divider(color: ZenoTheme.border),
                    _OpMetric(
                        label: "Resource Util.", value: "92%", target: "85%"),
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

class _OpMetric extends StatelessWidget {
  final String label;
  final String value;
  final String target;

  const _OpMetric(
      {required this.label, required this.value, required this.target});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: ZenoTheme.textSecondary)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Text("Target: $target",
                style: const TextStyle(
                    fontSize: 8, color: ZenoTheme.textSecondary)),
          ],
        ),
      ],
    );
  }
}
