import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

part 'parts/side_info_panel_tabs.part.dart';
part 'parts/side_info_panel_helpers.part.dart';

class ZenoSideInfoPanel extends StatefulWidget {
  final bool isOpen;
  const ZenoSideInfoPanel({super.key, required this.isOpen});

  @override
  State<ZenoSideInfoPanel> createState() => _ZenoSideInfoPanelState();
}

class _ZenoSideInfoPanelState extends State<ZenoSideInfoPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: widget.isOpen ? 400 : 0,
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        border: Border(
            left: BorderSide(
                color: ZenoTheme.border, width: widget.isOpen ? 1 : 0)),
      ),
      child: widget.isOpen ? _buildContent() : const SizedBox.shrink(),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              const Icon(Icons.analytics_outlined,
                  size: 18, color: ZenoTheme.accent),
              const SizedBox(width: 12),
              const Text("INTELLIGENT INSIGHTS",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2)),
              const Spacer(),
              _miniActionIcon(Icons.refresh),
              const SizedBox(width: 8),
              _miniActionIcon(Icons.settings_outlined),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          labelColor: ZenoTheme.accent,
          unselectedLabelColor: ZenoTheme.textSecondary,
          indicatorColor: ZenoTheme.accent,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "INFO"),
            Tab(text: "TIMELINE"),
            Tab(text: "FILES"),
            Tab(text: "NOTES"),
            Tab(text: "TASKS"),
            Tab(text: "PLAN"),
          ],
        ),
        const Divider(height: 1, color: ZenoTheme.border),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildInfoTab(),
              _buildTimelineTab(),
              _buildFilesTab(),
              _buildNotesTab(),
              _buildTasksTab(),
              _buildCalendarTab(),
            ],
          ),
        ),
      ],
    );
  }
}
