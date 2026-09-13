import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

class ZenoMasterDropdownField<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onQuickAdd;
  final bool isRequired;
  final double? width;

  const ZenoMasterDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.onQuickAdd,
    this.isRequired = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    T? effectiveValue = value;
    if (value != null && !items.any((item) => item.value == value)) {
      effectiveValue = null;
    }

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569),
                  fontFamily: 'Inter',
                ),
              ),
              if (isRequired)
                const Text(" *", style: TextStyle(color: Color(0xEF444444), fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      value: effectiveValue,
                      items: items,
                      onChanged: onChanged,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B), size: 18),
                      style: const TextStyle(
                        fontSize: 13, color: Color(0xFF0F172A), fontFamily: 'Inter', fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              if (onQuickAdd != null) ...[
                const SizedBox(width: 8),
                SizedBox(
                  width: 38,
                  height: 38,
                  child: ZenoButton(
                    label: "",
                    icon: Icons.add_rounded,
                    variant: ZenoButtonVariant.secondary,
                    onPressed: onQuickAdd,
                    size: ZenoButtonSize.sm,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
