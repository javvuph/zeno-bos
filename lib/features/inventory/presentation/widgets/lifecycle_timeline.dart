import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/inventory/domain/models/product_studio_models.dart';

class LifecycleTimeline extends StatelessWidget {
  final ProductLifecycleState activeState;
  final Function(ProductLifecycleState) onStateChanged;

  const LifecycleTimeline({
    super.key,
    required this.activeState,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    const states = ProductLifecycleState.values;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: states.map((state) {
        final isCompleted = state.index < activeState.index;
        final isActive = state == activeState;
        final isLast = state == states.last;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNode(state, isActive, isCompleted, colors),
            if (!isLast) ...[
              const SizedBox(width: 4),
              Text("→",
                  style: TextStyle(color: colors.textDisabled, fontSize: 8)),
              const SizedBox(width: 4),
            ],
          ],
        );
      }).toList(),
    );
  }

  Widget _buildNode(ProductLifecycleState state, bool isActive,
      bool isCompleted, ZenoSemanticColors colors) {
    final color = isCompleted
        ? colors.statusSuccess
        : (isActive ? colors.accentPrimary : colors.textDisabled);

    return Tooltip(
      message: _getStateLabel(state),
      child: InkWell(
        onTap: () => onStateChanged(state),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12, height: 12, // Even smaller
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? color : Colors.transparent,
                border: Border.all(color: color, width: 1.2),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 7, color: Colors.black)
                  : (isActive
                      ? Center(
                          child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: color, shape: BoxShape.circle)))
                      : null),
            ),
            const SizedBox(width: 4),
            Text(
              _getStateLabel(state).toUpperCase(),
              style: TextStyle(
                fontSize: 7,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? colors.textPrimary : color,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStateLabel(ProductLifecycleState state) {
    switch (state) {
      case ProductLifecycleState.draft:
        return "Draft";
      case ProductLifecycleState.aiReviewed:
        return "AI Reviewed";
      case ProductLifecycleState.pendingApproval:
        return "Pending";
      case ProductLifecycleState.approved:
        return "Approved";
      case ProductLifecycleState.published:
        return "Published";
      case ProductLifecycleState.availablePOS:
        return "In POS";
      case ProductLifecycleState.availableOnline:
        return "Online";
      case ProductLifecycleState.discontinued:
        return "End-Life";
      case ProductLifecycleState.archived:
        return "Archived";
    }
  }
}
