import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';

/// ZenoWorkspaceManifest v1.0
/// The definitive infrastructure layer for ZENO BOS.
/// Every module defines its personality through this configuration manifest.
class ZenoWorkspaceManifest<T> {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  // COMPONENT PROVIDERS
  final List<Widget> Function(BuildContext) toolbarActions;
  final List<Widget> Function(BuildContext) filterActions;
  final List<ZenoKpiData> Function(BuildContext) kpiMetrics;
  final List<ZenoTableColumn<T>> Function(BuildContext) tableColumns;
  final List<ZenoInspectorTab> Function(BuildContext, T?) inspectorTabs;
  final Widget Function(BuildContext) commandVessel;

  // HUD INDICATORS (Status Bar)
  final List<Widget> Function(BuildContext) statusBarIndicators;

  // INTERACTION LOGIC
  final Function(BuildContext, T)? onRowTap;
  final Function(BuildContext, List<T>)? onSelectionChanged;

  const ZenoWorkspaceManifest({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.toolbarActions,
    required this.filterActions,
    required this.kpiMetrics,
    required this.tableColumns,
    required this.inspectorTabs,
    required this.commandVessel,
    required this.statusBarIndicators,
    this.onRowTap,
    this.onSelectionChanged,
  });
}
