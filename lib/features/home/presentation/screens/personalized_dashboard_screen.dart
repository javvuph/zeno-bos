import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_kpi_hud.dart';
import '../controllers/personalized_dashboard_cubit.dart';
import '../widgets/dashboard/personalized_dashboard_grid.dart';

class PersonalizedDashboardScreen extends StatelessWidget {
  const PersonalizedDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DashboardView();
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return ZenoWorkspace(
          header: ZenoHeader(
            title: "Command Center".toUpperCase(),
            subtitle: "STRATEGIC OVERVIEW OF GLOBAL BUSINESS OPERATIONS AND NEURAL INTELLIGENCE.",
            actions: [
              IconButton(
                icon: Icon(state.isEditMode ? Icons.check_circle_outline_rounded : Icons.edit_note_rounded),
                onPressed: () => context.read<DashboardCubit>().toggleEditMode(),
                color: colors.accentPrimary,
              ),
            ],
          ),
          kpiHud: ZenoKpiHud(
            metrics: [
              const ZenoKpiData(
                label: "Revenue Today",
                value: "₹0",
                icon: Icons.payments_rounded,
                change: "0%",
              ),
              const ZenoKpiData(
                label: "Pending Approvals",
                value: "0",
                icon: Icons.verified_rounded,
                color: Colors.orange,
              ),
              const ZenoKpiData(
                label: "Inventory Health",
                value: "0%",
                icon: Icons.inventory_2_rounded,
                color: Colors.green,
              ),
              ZenoKpiData(
                label: "System Status",
                value: "OFFLINE",
                icon: Icons.monitor_heart_rounded,
                color: colors.accentPrimary,
              ),
            ],
          ),
          body: PersonalizedDashboardGrid(
            layout: state.activeLayout,
            authorizedWidgets: state.authorizedWidgets,
            isEditMode: state.isEditMode,
            onRemove: (id) => context.read<DashboardCubit>().removeWidget(id),
            onResize: (id, size) =>
                context.read<DashboardCubit>().resizeWidget(id, size),
            onRefresh: (id) => context.read<DashboardCubit>().refreshWidget(id),
          ),
        );
      },
    );
  }
}
