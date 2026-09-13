import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';
import 'async_widget_loader.dart';

class DashboardWidgetContainer extends StatelessWidget {
  final DashboardWidgetInstance instance;
  final Widget child;
  final bool isEditMode;
  final VoidCallback? onDelete;
  final Function(WidgetSize)? onResize;
  final VoidCallback? onRefresh;

  const DashboardWidgetContainer({
    super.key,
    required this.instance,
    required this.child,
    this.isEditMode = false,
    this.onDelete,
    this.onResize,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArchitecturalRow = instance.widgetKey.startsWith('exec_');

    if (isArchitecturalRow && !isEditMode) {
      return AsyncWidgetLoader(
        instance: instance,
        onRetry: onRefresh ?? () {},
        child: child,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: ZenoTheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEditMode
              ? ZenoTheme.accent.withValues(alpha: 0.5)
              : ZenoTheme.border,
          width: isEditMode ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              Expanded(
                child: AsyncWidgetLoader(
                  instance: instance,
                  onRetry: onRefresh ?? () {},
                  child: child,
                ),
              ),
            ],
          ),
          if (isEditMode) _buildEditOverlay(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final String timeStr = instance.lastUpdated != null
        ? DateFormat('HH:mm:ss').format(instance.lastUpdated!)
        : '--:--:--';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        border: Border(
            bottom: BorderSide(color: ZenoTheme.border.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          const Icon(Icons.drag_indicator,
              size: 16, color: ZenoTheme.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (instance.title ?? instance.widgetKey).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: ZenoTheme.textPrimary,
                  ),
                ),
                if (instance.status == WidgetLoadStatus.success)
                  Text(
                    "Last updated: $timeStr",
                    style: TextStyle(
                        fontSize: 8,
                        color: ZenoTheme.textSecondary.withValues(alpha: 0.7)),
                  ),
              ],
            ),
          ),
          if (isEditMode) ...[
            _buildResizeMenu(),
            IconButton(
              icon: const Icon(Icons.close, size: 16, color: Colors.redAccent),
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ] else ...[
            if (instance.status == WidgetLoadStatus.loading)
              const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: ZenoTheme.accent))
            else
              IconButton(
                icon: const Icon(Icons.refresh,
                    size: 14, color: ZenoTheme.textSecondary),
                onPressed: onRefresh,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.more_vert,
                size: 16, color: ZenoTheme.textSecondary),
          ],
        ],
      ),
    );
  }

  Widget _buildResizeMenu() {
    return PopupMenuButton<WidgetSize>(
      icon: const Icon(Icons.aspect_ratio, size: 16, color: ZenoTheme.accent),
      padding: EdgeInsets.zero,
      onSelected: onResize,
      itemBuilder: (context) => [
        const PopupMenuItem(value: WidgetSize.small, child: Text("Small")),
        const PopupMenuItem(value: WidgetSize.medium, child: Text("Medium")),
        const PopupMenuItem(value: WidgetSize.large, child: Text("Large")),
        const PopupMenuItem(value: WidgetSize.wide, child: Text("Wide")),
        const PopupMenuItem(value: WidgetSize.full, child: Text("Full")),
      ],
    );
  }

  Widget _buildEditOverlay() {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // Prevent taps reaching child in edit mode if desired
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: ZenoTheme.accent.withValues(alpha: 0.3), width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
