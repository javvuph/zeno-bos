import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'zeno_inputs.dart';

class ZenoDropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final ZenoFieldWidth? width;
  final VoidCallback? onQuickAdd;

  const ZenoDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.isRequired = false,
    this.width,
    this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    double? pixelWidth;
    if (width != null) {
      switch (width!) {
        case ZenoFieldWidth.micro:
          pixelWidth = 100;
          break;
        case ZenoFieldWidth.short:
          pixelWidth = 160;
          break;
        case ZenoFieldWidth.medium:
          pixelWidth = 240;
          break;
        case ZenoFieldWidth.standard:
          pixelWidth = 380;
          break;
        case ZenoFieldWidth.full:
          pixelWidth = double.infinity;
          break;
      }
    }

    T? effectiveValue = value;
    if (value != null && !items.any((item) => item.value == value)) {
      effectiveValue = null;
    }

    return SizedBox(
      width: pixelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                  fontFamily: 'Inter',
                ),
              ),
              if (isRequired)
                Text(" *", style: TextStyle(color: colors.statusDanger, fontSize: 13)),
              if (onQuickAdd != null) ...[
                const Spacer(),
                InkWell(
                  onTap: onQuickAdd,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: colors.accentPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.add_rounded, size: 14, color: colors.accentPrimary),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colors.bgTier2,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: effectiveValue,
                items: items,
                onChanged: onChanged,
                isExpanded: true,
                dropdownColor: colors.bgTier1,
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: colors.textSecondary, size: 18),
                style: TextStyle(
                    fontSize: 13,
                    color: colors.textPrimary,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
