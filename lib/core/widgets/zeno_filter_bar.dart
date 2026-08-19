import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_chip.dart';

class ZenoFilterBar extends StatelessWidget {
  final List<Widget> filters;
  final VoidCallback? onClear;
  final Widget? trailing;

  const ZenoFilterBar({
    super.key,
    required this.filters,
    this.onClear,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(
            bottom: BorderSide(
                color: colors.borderSubtle, width: ZenoBorderWidth.hairline)),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_list_rounded, size: 14, color: colors.textDisabled),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...filters.expand(
                      (w) => [w, const SizedBox(width: ZenoSpacing.sm)]),
                  if (onClear != null)
                    ZenoChip(
                      label: "Clear All",
                      icon: Icons.refresh,
                      onTap: onClear,
                      color: colors.statusDanger,
                    ),
                ],
              ),
            ),
          ),
          if (trailing != null) ...[
            const VerticalDivider(width: 24, indent: 12, endIndent: 12),
            trailing!,
          ],
        ],
      ),
    );
  }
}
