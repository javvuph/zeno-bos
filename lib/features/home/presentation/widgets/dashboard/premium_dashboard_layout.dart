import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/home/presentation/controllers/personalized_dashboard_cubit.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/zeno_dashboard_widget.dart';
import 'package:zeno/core/widgets/premium/zeno_section_header.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';

class PremiumDashboardLayout extends StatelessWidget {
  const PremiumDashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final widgets = state.activeLayout.widgets;

            if (constraints.maxWidth > 1400) {
              return _buildThreeColumnLayout(widgets, state.isEditMode);
            } else if (constraints.maxWidth > 1000) {
              return _buildTwoColumnLayout(widgets, state.isEditMode);
            } else {
              return _buildMobileStack(widgets, state.isEditMode);
            }
          },
        );
      },
    );
  }

  Widget _buildThreeColumnLayout(
      List<DashboardWidgetInstance> widgets, bool isEditMode) {
    // For demo, we split widgets into zones by their current index
    // In a real app, you'd use x/y or a zone property
    final leftZone = widgets.where((w) => widgets.indexOf(w) % 3 == 0).toList();
    final centerZone =
        widgets.where((w) => widgets.indexOf(w) % 3 == 1).toList();
    final rightZone =
        widgets.where((w) => widgets.indexOf(w) % 3 == 2).toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ZoneColumn(
            title: "OPERATIONS",
            icon: Icons.settings_input_component_rounded,
            widgets: leftZone,
            flex: 3,
            isEditMode: isEditMode),
        const SizedBox(width: 16),
        _ZoneColumn(
            title: "ANALYTICS",
            icon: Icons.analytics_outlined,
            widgets: centerZone,
            flex: 5,
            isEditMode: isEditMode),
        const SizedBox(width: 16),
        _ZoneColumn(
            title: "AI STRATEGY",
            icon: Icons.auto_awesome,
            widgets: rightZone,
            flex: 2,
            isEditMode: isEditMode),
      ],
    );
  }

  Widget _buildTwoColumnLayout(
      List<DashboardWidgetInstance> widgets, bool isEditMode) {
    final leftZone = widgets.where((w) => widgets.indexOf(w) % 2 == 0).toList();
    final rightZone =
        widgets.where((w) => widgets.indexOf(w) % 2 == 1).toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ZoneColumn(
            title: "CORE WORKSPACE",
            icon: Icons.dashboard_rounded,
            widgets: leftZone,
            flex: 7,
            isEditMode: isEditMode),
        const SizedBox(width: 16),
        _ZoneColumn(
            title: "SIDEBAR",
            icon: Icons.info_outline_rounded,
            widgets: rightZone,
            flex: 3,
            isEditMode: isEditMode),
      ],
    );
  }

  Widget _buildMobileStack(
      List<DashboardWidgetInstance> widgets, bool isEditMode) {
    return _ZoneColumn(
        title: "DASHBOARD", widgets: widgets, isEditMode: isEditMode);
  }
}

class _ZoneColumn extends StatefulWidget {
  final String title;
  final IconData? icon;
  final List<DashboardWidgetInstance> widgets;
  final int flex;
  final bool isEditMode;

  const _ZoneColumn({
    required this.title,
    this.icon,
    required this.widgets,
    this.flex = 1,
    this.isEditMode = false,
  });

  @override
  State<_ZoneColumn> createState() => _ZoneColumnState();
}

class _ZoneColumnState extends State<_ZoneColumn> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    return Expanded(
      flex: widget.flex,
      child: Column(
        children: [
          ZenoSectionHeader(
            title: widget.title,
            icon: widget.icon,
            collapsible: true,
            initiallyExpanded: _isExpanded,
            onToggle: (v) => setState(() => _isExpanded = v),
          ),
          if (_isExpanded)
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.widgets.length,
              onReorder: (oldIndex, newIndex) {
                // For demo, we just print as reordering across filtered lists is complex
                // In production, you'd update the master list in the Cubit
                debugPrint("Reordered: $oldIndex -> $newIndex");
              },
              itemBuilder: (context, index) {
                final instance = widget.widgets[index];
                return Padding(
                  key: ValueKey(instance.id),
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ZenoDashboardWidget(
                    instance: instance,
                    isEditMode: widget.isEditMode,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
