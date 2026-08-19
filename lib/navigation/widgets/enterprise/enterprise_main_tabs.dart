import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class EnterpriseMainTabs extends StatelessWidget {
  final List<String> tabs;
  final String activeTab;
  final Function(String) onTabChanged;

  const EnterpriseMainTabs({
    super.key,
    required this.tabs,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: ZenoTheme.workspaceBackground,
        border: Border(bottom: BorderSide(color: ZenoTheme.border)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isActive = tab == activeTab;
            return InkWell(
              onTap: () => onTabChanged(tab),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? ZenoTheme.primary : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color:
                        isActive ? ZenoTheme.primary : ZenoTheme.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
