import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';
import '../../controllers/personalized_dashboard_cubit.dart';

class PerformanceMonitorOverlay extends StatelessWidget {
  const PerformanceMonitorOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (!state.isMonitorOpen) return const SizedBox.shrink();

        final widgets = state.authorizedWidgets;
        final avgLoad =
            widgets.map((w) => w.loadDurationMs).fold(0, (a, b) => a + b) /
                (widgets.isEmpty ? 1 : widgets.length);

        return Positioned(
          bottom: 100,
          right: 24,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: ZenoTheme.accent.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 20)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.speed,
                          color: ZenoTheme.neonCyan, size: 18),
                      const SizedBox(width: 12),
                      const Text("PERFORMANCE MONITOR",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close,
                            size: 16, color: Colors.white54),
                        onPressed: () =>
                            context.read<DashboardCubit>().toggleMonitor(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: Colors.white12),
                  _metric("Avg. Load Duration", "${avgLoad.toInt()} ms",
                      avgLoad > 2000 ? Colors.orange : ZenoTheme.neonGreen),
                  _metric("Total Widgets", "${widgets.length}", Colors.white),
                  _metric("Status", state.isOffline ? "OFFLINE" : "HEALTHY",
                      state.isOffline ? Colors.redAccent : ZenoTheme.neonGreen),
                  const SizedBox(height: 16),
                  const Text("WIDGET HEALTH",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54)),
                  const SizedBox(height: 8),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widgets.length,
                      itemBuilder: (context, index) {
                        final w = widgets[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: _getStatusColor(w.status),
                                      shape: BoxShape.circle)),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Text(w.widgetKey,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white70))),
                              Text("${w.loadDurationMs}ms",
                                  style: const TextStyle(
                                      fontSize: 9, color: Colors.white38)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const LinearProgressIndicator(
                      value: 0.12,
                      backgroundColor: Colors.white10,
                      color: ZenoTheme.neonCyan,
                      minHeight: 2),
                  const SizedBox(height: 4),
                  const Text("Memory: 412 MB / 4 GB (Simulated)",
                      style: TextStyle(fontSize: 8, color: Colors.white38)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _metric(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: Colors.white54)),
          Text(value,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Color _getStatusColor(WidgetLoadStatus status) {
    switch (status) {
      case WidgetLoadStatus.success:
        return ZenoTheme.neonGreen;
      case WidgetLoadStatus.loading:
        return Colors.orange;
      case WidgetLoadStatus.error:
        return Colors.red;
      case WidgetLoadStatus.offline:
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
