import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_search.dart';

/// ZenoHeader v2.1
/// Compact, high-density tactical header with clear visual hierarchy and action row.
class ZenoHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? titleSuffix;
  final List<Widget>? actions;
  final Widget? breadcrumbs;
  final ValueChanged<String>? onSearch;
  final String searchHint;

  const ZenoHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleSuffix,
    this.actions,
    this.breadcrumbs,
    this.onSearch,
    this.searchHint = "Search...",
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 72, // Fixed height for all workspaces
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: ZenoBorderWidth.hairline,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. IDENTITY & BREADCRUMBS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (breadcrumbs != null) ...[
                  breadcrumbs!,
                  const SizedBox(height: 2),
                ],
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title.toUpperCase(),
                        style: ZenoTypography.headlineSM(colors.textPrimary).copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (titleSuffix != null) ...[
                      const SizedBox(width: 12),
                      titleSuffix!,
                    ],
                  ],
                ),
                Text(
                  subtitle.toUpperCase(),
                  style: ZenoTypography.micro(colors.textSecondary).copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // 2. SEARCH (Optional)
          if (onSearch != null) ...[
            SizedBox(
              width: 280,
              height: 34,
              child: ZenoSearch(onChanged: onSearch, hint: searchHint),
            ),
            const SizedBox(width: ZenoSpacing.xl),
          ],

          // 3. ACTION RAIL
          if (actions != null && actions!.isNotEmpty) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!
                  .expand((w) => [w, const SizedBox(width: ZenoSpacing.md)])
                  .toList()
                ..removeLast(),
            ),
          ],
        ],
      ),
    );
  }
}
