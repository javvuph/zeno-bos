import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/reports/domain/repositories/i_reports_repository.dart';
import 'package:zeno/features/reports/presentation/controllers/reports_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart' as nav;

class ExecutiveKPIRow extends StatefulWidget {
  const ExecutiveKPIRow({super.key});

  @override
  State<ExecutiveKPIRow> createState() => _ExecutiveKPIRowState();
}

class _ExecutiveKPIRowState extends State<ExecutiveKPIRow> {
  final controller = ReportsController(sl<IReportsRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.refreshDashboard();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardKPIs.isEmpty) {
      return const SizedBox(
        height: 96,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final kpis = controller.dashboardKPIs;

    return SizedBox(
      height: 96,
      child: Row(
        children: kpis.map((kpi) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: kpis.last == kpi ? 0 : 12),
              child: InkWell(
                onTap: () =>
                    nav.NavigationController().openTab('reports/dashboard'),
                borderRadius: BorderRadius.circular(8),
                child: _KPICard(
                  title: kpi.label.toUpperCase(),
                  value: kpi.value,
                  trend:
                      "${kpi.change > 0 ? '▲' : '▼'} ${kpi.change.abs().toStringAsFixed(1)}%",
                  subtext: kpi.change >= 0 ? "Growth Observed" : "Below Target",
                  color: kpi.color,
                  graphic: _getGraphicForId(kpi.id),
                  isWarning: kpi.change < 0,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _getGraphicForId(String id) {
    switch (id) {
      case 'revenue':
        return const _SparklineGraphic();
      case 'profit':
        return const _DonutGraphic(percent: 0.231);
      case 'purchase':
        return const _ExpenseStackedGraphic();
      default:
        return const _CashBarsGraphic();
    }
  }
}

class _KPICard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final String subtext;
  final Color color;
  final Widget graphic;
  final bool isWarning;

  const _KPICard({
    required this.title,
    required this.value,
    required this.trend,
    required this.subtext,
    required this.color,
    required this.graphic,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: colors.textSecondary,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              graphic,
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  subtext,
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        isWarning ? colors.statusDanger : colors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- MICRO-GRAPHIC PAINTERS ---

class _SparklineGraphic extends StatelessWidget {
  const _SparklineGraphic();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(36, 18),
      painter: _SparklinePainter(color: const Color(0xFF3366FF)),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final Color color;
  _SparklinePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(0, size.height * 0.8)
      ..lineTo(size.width * 0.33, size.height * 0.55)
      ..lineTo(size.width * 0.66, size.height * 0.65)
      ..lineTo(size.width, size.height * 0.1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DonutGraphic extends StatelessWidget {
  final double percent;
  const _DonutGraphic({required this.percent});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(18, 18),
      painter: _DonutPainter(percent: percent, color: const Color(0xFF00C853)),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percent;
  final Color color;
  _DonutPainter({required this.percent, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final bgPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, 2 * math.pi * percent, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CashBarsGraphic extends StatelessWidget {
  const _CashBarsGraphic();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _bar(8, 0.6),
        const SizedBox(width: 2),
        _bar(16, 1.0),
        const SizedBox(width: 2),
        _bar(12, 0.85),
      ],
    );
  }

  Widget _bar(double h, double opacity) => Container(
        width: 5,
        height: h,
        decoration: BoxDecoration(
          color: const Color(0xFFF59E0B).withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(1),
        ),
      );
}

class _ExpenseStackedGraphic extends StatelessWidget {
  const _ExpenseStackedGraphic();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _segment(6, 0.4),
        const SizedBox(width: 2),
        _segment(12, 0.7),
        const SizedBox(width: 2),
        _segment(18, 1.0),
      ],
    );
  }

  Widget _segment(double h, double opacity) => Container(
        width: 4,
        height: h,
        decoration: BoxDecoration(
          color: const Color(0xFFFF4D4D).withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(1),
        ),
      );
}
