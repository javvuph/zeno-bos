import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';
import 'widget_container.dart';
import 'widget_registry.dart';

class PersonalizedDashboardGrid extends StatelessWidget {
  final DashboardLayout layout;
  final List<DashboardWidgetInstance> authorizedWidgets;
  final bool isEditMode;
  final Function(String) onRemove;
  final Function(String, WidgetSize) onResize;
  final Function(String) onRefresh;

  const PersonalizedDashboardGrid({
    super.key,
    required this.layout,
    required this.authorizedWidgets,
    required this.isEditMode,
    required this.onRemove,
    required this.onResize,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: StaggeredGrid.count(
        crossAxisCount: 12,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: authorizedWidgets.map((instance) {
          final bool isArchitectural = instance.widgetKey.startsWith('exec_');

          if (isArchitectural && !isEditMode) {
            double height = 96;
            if (instance.widgetKey == 'exec_analytical_core') {
              height = 340; // Spec: 340px
            }
            if (instance.widgetKey == 'exec_performance_matrix') height = 360;

            return StaggeredGridTile.extent(
              crossAxisCellCount: 12,
              mainAxisExtent: height,
              child: DashboardWidgetContainer(
                instance: instance,
                isEditMode: isEditMode,
                onDelete: () => onRemove(instance.id),
                onResize: (newSize) => onResize(instance.id, newSize),
                onRefresh: () => onRefresh(instance.id),
                child: WidgetRegistry.build(instance.widgetKey),
              ),
            );
          }

          final size = _getGridSize(instance.size);
          return StaggeredGridTile.count(
            crossAxisCellCount: size.width,
            mainAxisCellCount: size.height,
            child: DashboardWidgetContainer(
              instance: instance,
              isEditMode: isEditMode,
              onDelete: () => onRemove(instance.id),
              onResize: (newSize) => onResize(instance.id, newSize),
              onRefresh: () => onRefresh(instance.id),
              child: WidgetRegistry.build(instance.widgetKey),
            ),
          );
        }).toList(),
      ),
    );
  }

  ({int width, double height}) _getGridSize(WidgetSize size) {
    switch (size) {
      case WidgetSize.small:
        return (width: 3, height: 2.5);
      case WidgetSize.medium:
        return (width: 6, height: 5.0);
      case WidgetSize.large:
        return (width: 12, height: 7.0);
      case WidgetSize.wide:
        return (width: 12, height: 3.5);
      case WidgetSize.full:
        return (width: 12, height: 10.0);
    }
  }
}
