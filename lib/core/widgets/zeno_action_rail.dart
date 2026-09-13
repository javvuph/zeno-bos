import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoActionRailItem {
  final IconData icon;
  final String label;
  final String? hint;
  final Color color;
  final VoidCallback onTap;

  const ZenoActionRailItem({
    required this.icon,
    required this.label,
    this.hint,
    required this.color,
    required this.onTap,
  });
}

class ZenoActionRailSection {
  final String title;
  final List<ZenoActionRailItem> items;

  const ZenoActionRailSection({
    required this.title,
    required this.items,
  });
}

/// ZenoActionRail v1.0
/// Left vertical action bar for tactical workspaces.
class ZenoActionRail extends StatelessWidget {
  final List<ZenoActionRailSection> sections;
  final bool isCollapsed;
  final double width;

  const ZenoActionRail({
    super.key,
    required this.sections,
    this.isCollapsed = false,
    this.width = ZenoSizing.actionRailWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      width: isCollapsed ? 64 : width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(
            right: BorderSide(
                color: colors.borderSubtle, width: ZenoBorderWidth.thin)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: ZenoSpacing.md),
              itemCount: sections.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ZenoSpacing.lg),
              itemBuilder: (context, index) =>
                  _buildSection(sections[index], colors),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      ZenoActionRailSection section, ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCollapsed)
          Padding(
            padding: const EdgeInsets.fromLTRB(
                ZenoSpacing.md, 0, ZenoSpacing.md, ZenoSpacing.sm),
            child: Text(
              section.title.toUpperCase(),
              style: ZenoTypography.micro(colors.textDisabled)
                  .copyWith(letterSpacing: 1.0),
            ),
          ),
        ...section.items.map((item) => _buildItem(item, colors)),
      ],
    );
  }

  Widget _buildItem(ZenoActionRailItem item, ZenoSemanticColors colors) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.md, vertical: ZenoSpacing.sm),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(ZenoSpacing.sm),
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(ZenoRadius.md),
                border: Border.all(color: item.color.withValues(alpha: 0.15)),
              ),
              child: Icon(item.icon, size: 16, color: item.color),
            ),
            if (!isCollapsed) ...[
              const SizedBox(width: ZenoSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      softWrap: true,
                    ),
                    if (item.hint != null)
                      Text(
                        item.hint!,
                        style: ZenoTypography.micro(colors.textDisabled)
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
