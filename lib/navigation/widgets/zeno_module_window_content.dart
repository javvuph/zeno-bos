import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/zeno_router.dart';

class ZenoModuleWindowContent extends StatefulWidget {
  final ZenoMenuCategory category;
  final String? initialRoute;

  const ZenoModuleWindowContent({
    super.key,
    required this.category,
    this.initialRoute,
  });

  @override
  State<ZenoModuleWindowContent> createState() =>
      _ZenoModuleWindowContentState();
}

class _ZenoModuleWindowContentState extends State<ZenoModuleWindowContent>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<ZenoMenuItem> _allSubMenus;

  @override
  void initState() {
    super.initState();
    _allSubMenus = widget.category.columns
        .expand((c) => c.items)
        .where((i) => i.route != null)
        .toList();

    int initialIndex = 0;
    if (widget.initialRoute != null) {
      initialIndex =
          _allSubMenus.indexWhere((i) => i.route == widget.initialRoute);
      if (initialIndex == -1) initialIndex = 0;
    }

    _tabController = TabController(
      length: _allSubMenus.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getTabColor(String label) {
    final l = label.toUpperCase();
    if (l.contains('TERMINAL')) return const Color(0xFF6366F1); // Indigo
    if (l.contains('HISTORY')) return const Color(0xFF3B82F6); // Blue
    if (l.contains('CREDIT')) return const Color(0xFFF59E0B); // Amber
    if (l.contains('QUOTATION')) return const Color(0xFF10B981); // Emerald
    if (l.contains('PAYMENT')) return const Color(0xFF8B5CF6); // Purple
    if (l.contains('INSIGHTS')) return const Color(0xFFEC4899); // Pink
    if (l.contains('PRODUCTS')) return const Color(0xFF3B82F6);
    if (l.contains('VARIANTS')) return const Color(0xFF8B5CF6);
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        // STYLISH COLORFUL TAB BAR
        Container(
          height: 42, // Slimmer
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: colors.accentPrimary,
            indicatorWeight: 2,
            labelColor: const Color(0xFF1E293B),
            unselectedLabelColor: const Color(0xFF94A3B8),
            labelStyle: const TextStyle(
                fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8),
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: _allSubMenus.map((item) {
              final color = _getTabColor(item.label);
              return Tab(
                height: 42,
                child: Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(6), // Slightly larger padding
                      decoration: BoxDecoration(
                        color:
                            color.withValues(alpha: 0.15), // More vibrant tint
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: color.withValues(alpha: 0.1)),
                      ),
                      child: Icon(item.icon, size: 14, color: color),
                    ),
                    const SizedBox(width: 8),
                    Text(item.label.toUpperCase().replaceAll('⚡', '').trim()),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        // CONTENT
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: _allSubMenus.map((item) {
              return Container(
                color: Colors.white,
                child: ZenoRouter.getScreen(item.route!),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
