import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';
import 'widget_skeleton_loader.dart';

class AsyncWidgetLoader extends StatefulWidget {
  final DashboardWidgetInstance instance;
  final Widget child;
  final VoidCallback onRetry;

  const AsyncWidgetLoader({
    super.key,
    required this.instance,
    required this.child,
    required this.onRetry,
  });

  @override
  State<AsyncWidgetLoader> createState() => _AsyncWidgetLoaderState();
}

class _AsyncWidgetLoaderState extends State<AsyncWidgetLoader> {
  @override
  Widget build(BuildContext context) {
    switch (widget.instance.status) {
      case WidgetLoadStatus.loading:
      case WidgetLoadStatus.idle:
        return WidgetSkeletonLoader(size: widget.instance.size);
      case WidgetLoadStatus.error:
        return _buildErrorState();
      case WidgetLoadStatus.offline:
        return Stack(
          children: [
            widget.child,
            _buildStatusBadge("OFFLINE", Colors.orange),
          ],
        );
      case WidgetLoadStatus.success:
        return widget.child;
    }
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 32),
            const SizedBox(height: 12),
            const Text(
              "Unable to load data",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Widget: ${widget.instance.widgetKey}",
              style:
                  const TextStyle(fontSize: 10, color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ZenoTheme.accent,
                foregroundColor: Colors.black,
                textStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text("RETRY"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
