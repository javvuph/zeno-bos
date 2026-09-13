import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ProductReadinessHub extends StatelessWidget {
  final Map<String, bool> sectionStatus;

  const ProductReadinessHub({
    super.key,
    required this.sectionStatus,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: sectionStatus.entries
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _ReadinessNode(
                  label: e.key,
                  isComplete: e.value,
                  colors: colors,
                ),
              ))
          .toList(),
    );
  }
}

class _ReadinessNode extends StatelessWidget {
  final String label;
  final bool isComplete;
  final ZenoSemanticColors colors;

  const _ReadinessNode({
    required this.label,
    required this.isComplete,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "$label: ${isComplete ? 'Complete' : 'Pending'}",
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isComplete ? colors.statusSuccess : Colors.transparent,
              border: Border.all(
                  color:
                      isComplete ? colors.statusSuccess : colors.borderSubtle,
                  width: 1.5),
            ),
            child: isComplete
                ? const Icon(Icons.check, size: 8, color: Colors.black)
                : null,
          ),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.w500,
              color: isComplete ? colors.textPrimary : colors.textDisabled,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
