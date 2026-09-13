import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoInspectorTab {
  final String label;
  final IconData icon;
  final Widget child;

  const ZenoInspectorTab({
    required this.label,
    required this.icon,
    required this.child,
  });
}

/// ZenoSmartInspector v2.1
/// High-performance record inspection panel with premium visual identity.
class ZenoSmartInspector extends StatefulWidget {
  final List<ZenoInspectorTab> tabs;
  final String? title;
  final String? subtitle;
  final bool isVisible;
  final VoidCallback? onClose;

  const ZenoSmartInspector({
    super.key,
    required this.tabs,
    this.title,
    this.subtitle,
    this.isVisible = true,
    this.onClose,
  });

  @override
  State<ZenoSmartInspector> createState() => _ZenoSmartInspectorState();
}

class _ZenoSmartInspectorState extends State<ZenoSmartInspector>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void didUpdateWidget(ZenoSmartInspector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != _tabController.length) {
      _tabController.dispose();
      _tabController = TabController(length: widget.tabs.length, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      width: 420, // Refined standard width
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(
          left: BorderSide(color: colors.borderSubtle),
        ),
      ),
      child: Column(
        children: [
          // 1. RECORD IDENTITY
          if (widget.title != null) _buildIdentityHeader(colors),

          // 2. TAB NAVIGATION
          _buildTabNavigator(colors),

          // 3. CONTENT AREA
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabs.map((t) => t.child).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(bottom: BorderSide(color: colors.borderSubtle.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!.toUpperCase(),
                  style: ZenoTypography.headlineSM(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: -0.2),
                ),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle!.toUpperCase(),
                    style: ZenoTypography.micro(colors.textDisabled)
                        .copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w700),
                  ),
                ],
              ],
            ),
          ),
          if (widget.onClose != null)
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: widget.onClose,
              color: colors.textDisabled,
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }

  Widget _buildTabNavigator(ZenoSemanticColors colors) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: ZenoBorderWidth.hairline,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: colors.accentPrimary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        labelColor: colors.accentPrimary,
        unselectedLabelColor: colors.textDisabled,
        labelStyle: ZenoTypography.micro(colors.accentPrimary)
            .copyWith(fontWeight: FontWeight.w900, fontSize: 9),
        tabs: widget.tabs
            .map((t) => Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(t.icon, size: 13),
                      const SizedBox(width: 8),
                      Text(t.label.toUpperCase()),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
