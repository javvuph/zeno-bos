import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/architecture/zeno_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import 'package:zeno/core/widgets/zeno_toolbar.dart';
import 'package:zeno/core/widgets/zeno_filter_bar.dart';
import 'package:zeno/core/widgets/zeno_status_bar.dart';

/// ZenoWorkspace v2.1
/// Standardized enterprise workspace orchestrator.
class ZenoWorkspace extends StatelessWidget {
  final Widget header;
  final Widget? kpiHud;
  final Widget? toolbar;
  final Widget? filterBar;
  final Widget body;
  final Widget? inspector;
  final Widget? statusBar;
  final bool isLoading;
  final Widget? loadingOverlay;

  const ZenoWorkspace({
    super.key,
    required this.header,
    this.kpiHud,
    this.toolbar,
    this.filterBar,
    required this.body,
    this.inspector,
    this.statusBar,
    this.isLoading = false,
    this.loadingOverlay,
  });

  /// Manifest-driven factory constructor
  factory ZenoWorkspace.fromManifest({
    required ZenoWorkspaceManifest manifest,
    required BuildContext context,
    required Widget body,
    Widget? inspector,
    bool isLoading = false,
    List<Widget>? extraActions,
  }) {
    return ZenoWorkspace(
      isLoading: isLoading,
      header: ZenoHeader(
        title: manifest.title,
        subtitle: manifest.subtitle,
        actions: extraActions ?? manifest.toolbarActions(context),
      ),
      kpiHud: ZenoKpiHud(metrics: manifest.kpiMetrics(context)),
      toolbar: ZenoToolbar(
        center: manifest.commandVessel(context),
      ),
      filterBar: ZenoFilterBar(filters: manifest.filterActions(context)),
      body: body,
      inspector: inspector,
      statusBar: ZenoStatusBar(
        leftActions: manifest.statusBarIndicators(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Stack(
      children: [
        Column(
          children: [
            header,
            if (kpiHud != null) kpiHud!,
            if (toolbar != null || filterBar != null)
              _buildOperationalDock(colors),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      color: colors.bgTier1,
                      child: body,
                    ),
                  ),
                  if (inspector != null) inspector!,
                ],
              ),
            ),
            if (statusBar != null) statusBar!,
          ],
        ),
        if (isLoading) loadingOverlay ?? _buildDefaultLoading(colors),
      ],
    );
  }

  Widget _buildOperationalDock(ZenoSemanticColors colors) {
    return Container(
      height: 44, // Reduced from 48 for tighter density
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: ZenoBorderWidth.hairline,
          ),
        ),
      ),
      child: Row(
        children: [
          if (filterBar != null) Expanded(child: filterBar!),
          if (toolbar != null) ...[
            if (filterBar != null) 
              Container(width: 1, height: 20, color: colors.borderSubtle.withValues(alpha: 0.5)),
            Expanded(child: toolbar!),
          ],
        ],
      ),
    );
  }

  Widget _buildDefaultLoading(ZenoSemanticColors colors) {
    return Container(
      color: colors.bgTier1.withValues(alpha: 0.7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: colors.accentPrimary,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              "UPDATING WORKSPACE...",
              style: ZenoTypography.micro(colors.accentPrimary)
                  .copyWith(letterSpacing: 2, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
