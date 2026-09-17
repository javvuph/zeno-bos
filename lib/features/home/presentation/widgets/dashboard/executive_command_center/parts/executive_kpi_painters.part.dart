part of '../executive_kpi_row.dart';

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
