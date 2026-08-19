import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../navigation_controller.dart';

class ZenoBreadcrumbBar extends StatelessWidget {
  const ZenoBreadcrumbBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        final items = nav.getBreadcrumbs();
        return Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ZenoTheme.background,
            border: Border(
                bottom:
                    BorderSide(color: ZenoTheme.border.withValues(alpha: 0.5))),
          ),
          child: Row(
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              final isLast = idx == items.length - 1;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (idx > 0)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(Icons.chevron_right,
                          size: 10, color: ZenoTheme.textSecondary),
                    ),
                  InkWell(
                    onTap: isLast ? null : () => nav.navigateTo(item.route!),
                    child: Row(
                      children: [
                        if (item.icon != null) ...[
                          Icon(item.icon,
                              size: 10,
                              color: isLast
                                  ? ZenoTheme.textPrimary
                                  : ZenoTheme.textSecondary),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                isLast ? FontWeight.w900 : FontWeight.normal,
                            letterSpacing: 0.5,
                            color: isLast
                                ? ZenoTheme.textPrimary
                                : ZenoTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
