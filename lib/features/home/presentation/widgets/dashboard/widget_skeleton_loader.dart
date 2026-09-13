import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';

class WidgetSkeletonLoader extends StatelessWidget {
  final WidgetSize size;
  const WidgetSkeletonLoader({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double h = constraints.maxHeight;
      final bool isCompact = h < 120;

      return Container(
        padding: EdgeInsets.all(isCompact ? 12 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _bone(
                    width: isCompact ? 24 : 40,
                    height: isCompact ? 24 : 40,
                    radius: 8),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bone(width: 120, height: 10),
                    if (!isCompact) ...[
                      const SizedBox(height: 8),
                      _bone(width: 80, height: 8),
                    ],
                  ],
                ),
              ],
            ),
            if (!isCompact) ...[
              const SizedBox(height: 32),
              if (size == WidgetSize.medium ||
                  size == WidgetSize.large ||
                  size == WidgetSize.full) ...[
                Expanded(
                    child:
                        _bone(width: double.infinity, height: double.infinity)),
                const SizedBox(height: 16),
                _bone(width: double.infinity, height: 10),
                const SizedBox(height: 8),
                _bone(width: 200, height: 10),
              ] else ...[
                Expanded(
                    child:
                        _bone(width: double.infinity, height: double.infinity)),
              ],
            ] else if (h > 60) ...[
              const SizedBox(height: 12),
              Expanded(
                  child:
                      _bone(width: double.infinity, height: double.infinity)),
            ],
          ],
        ),
      ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: 1500.ms, color: ZenoTheme.accent.withValues(alpha: 0.05));
    });
  }

  Widget _bone(
      {required double width, required double height, double radius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ZenoTheme.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
