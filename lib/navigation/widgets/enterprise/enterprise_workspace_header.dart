import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class EnterpriseWorkspaceHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? selectors;
  final String? status;
  final String? version;
  final String? lastSaved;

  const EnterpriseWorkspaceHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.selectors,
    this.status,
    this.version,
    this.lastSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      decoration: const BoxDecoration(
        color: ZenoTheme.background,
        border: Border(bottom: BorderSide(color: ZenoTheme.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BREADCRUMB
          const _EnterpriseBreadcrumb(),
          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TITLE
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: ZenoTheme.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.info_outline,
                            size: 18, color: ZenoTheme.textSecondary),
                      ],
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                            fontSize: 13, color: ZenoTheme.textSecondary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // SELECTORS & METADATA (Scrollable if needed)
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (selectors != null) ...[
                        ...selectors!.map((s) => Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: s,
                            )),
                      ],

                      const SizedBox(width: 12),

                      // STATUS & METADATA
                      if (status != null)
                        _MetaItem(
                            label: "Status", value: status!, isStatus: true),
                      if (version != null)
                        _MetaItem(label: "Version", value: version!),
                      if (lastSaved != null)
                        _MetaItem(label: "Last Saved", value: lastSaved!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EnterpriseBreadcrumb extends StatelessWidget {
  const _EnterpriseBreadcrumb();

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();
    final items = nav.getBreadcrumbs();

    return Row(
      children: items.asMap().entries.map((entry) {
        final idx = entry.key;
        final item = entry.value;
        final isLast = idx == items.length - 1;

        return Row(
          children: [
            if (idx > 0)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.chevron_right,
                    size: 14, color: ZenoTheme.textSecondary),
              ),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: isLast ? ZenoTheme.accent : ZenoTheme.textSecondary,
                fontWeight: isLast ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isStatus;

  const _MetaItem(
      {required this.label, required this.value, this.isStatus = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  color: ZenoTheme.textSecondary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              if (isStatus) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: ZenoTheme.success, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ZenoTheme.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
