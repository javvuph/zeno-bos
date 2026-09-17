import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/controllers/personalized_dashboard_cubit.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/widget_library_dialog.dart';

part 'parts/workspace_control_bar_filters.part.dart';
part 'parts/workspace_control_bar_actions.part.dart';

class WorkspaceControlBar extends StatelessWidget {
  const WorkspaceControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.bgTier4,
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _WorkspaceTitle(),
          const _GlobalDateEngine(),
          _ActionCluster(),
        ],
      ),
    );
  }
}
