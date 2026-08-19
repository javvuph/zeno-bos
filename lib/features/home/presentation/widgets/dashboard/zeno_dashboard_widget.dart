import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/domain/models/dashboard_models.dart';
import 'package:zeno/features/home/presentation/controllers/personalized_dashboard_cubit.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/widget_registry.dart';

class ZenoDashboardWidget extends StatelessWidget {
  final DashboardWidgetInstance instance;
  final bool isEditMode;

  const ZenoDashboardWidget({
    super.key,
    required this.instance,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Stack(
      children: [
        // THE ACTUAL WIDGET CONTENT
        WidgetRegistry.build(instance.widgetKey),

        // EDIT MODE OVERLAY
        if (isEditMode)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.accentPrimary, width: 2),
              ),
              child: Stack(
                children: [
                  // DRAG HANDLE
                  const Center(
                    child: Icon(Icons.drag_indicator_rounded,
                        color: Colors.white, size: 32),
                  ),

                  // REMOVE BUTTON
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.cancel_rounded, color: Colors.red),
                      onPressed: () => context
                          .read<DashboardCubit>()
                          .removeWidget(instance.id),
                    ),
                  ),

                  // SIZE TOGGLE
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.bgTier1,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: colors.borderSubtle),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(instance.size.name.toUpperCase(),
                              style: ZenoTypography.micro(colors.textPrimary)),
                          const SizedBox(width: 8),
                          const Icon(Icons.unfold_more_rounded, size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
