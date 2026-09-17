import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

export 'package:zeno/core/widgets/zeno_table.dart'
    show ZenoTable, ZenoTableColumn;

part 'parts/zeno_data_grid_toolbar.part.dart';

class ZenoDataGridTemplate<T> extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<T> items;
  final List<ZenoTableColumn<T>> columns;
  final String searchPlaceholder;
  final Widget? primaryAction;
  final List<Widget> bulkActions;
  final Function(T)? onRowTap;
  final ValueChanged<List<T>>? onDeleteRequested;
  final ValueChanged<List<List<String>>>? onPaste;
  final bool isLoading;
  final int totalCount;
  final Function(String)? onSearch;
  final VoidCallback? onRefresh;

  const ZenoDataGridTemplate({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
    required this.columns,
    this.searchPlaceholder = "Search...",
    this.primaryAction,
    this.bulkActions = const [],
    this.onRowTap,
    this.onDeleteRequested,
    this.onPaste,
    this.isLoading = false,
    this.totalCount = 0,
    this.onSearch,
    this.onRefresh,
  });

  @override
  State<ZenoDataGridTemplate<T>> createState() =>
      _ZenoDataGridTemplateState<T>();
}

class _ZenoDataGridTemplateState<T> extends State<ZenoDataGridTemplate<T>> {
  List<T> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      color: colors.bgTier1,
      child: Stack(
        children: [
          Column(
            children: [
              _buildHeader(colors),
              _buildToolbar(colors),
              Expanded(
                child: ZenoTable<T>(
                  items: widget.items,
                  columns: widget.columns,
                  isLoading: widget.isLoading,
                  selectedItems: _selectedItems,
                  onSelectionChanged: (selection) {
                    setState(() => _selectedItems = selection);
                  },
                  onDeleteRequested: widget.onDeleteRequested,
                  onPaste: widget.onPaste,
                  onRowTap: widget.onRowTap,
                ),
              ),
              _buildPagination(colors),
            ],
          ),
          if (_selectedItems.isNotEmpty) _buildBulkActionsOverlay(colors),
        ],
      ),
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                  letterSpacing: 0.05 * 16,
                ),
              ),
              if (widget.subtitle != null)
                Text(
                  widget.subtitle!,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Inter',
                    color: colors.textSecondary,
                  ),
                ),
            ],
          ),
          const Spacer(),
          if (widget.primaryAction != null) widget.primaryAction!,
        ],
      ),
    );
  }

  Widget _buildToolbar(ZenoSemanticColors colors) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: [
          Container(
            width: 320,
            height: 28,
            decoration: BoxDecoration(
              color: colors.bgTier1,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: colors.borderSubtle),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Icons.search_rounded,
                    size: 14, color: colors.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: widget.onSearch,
                    decoration: InputDecoration(
                      hintText: widget.searchPlaceholder,
                      hintStyle:
                          TextStyle(fontSize: 12, color: colors.textDisabled),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                        fontSize: 12,
                        color: colors.textPrimary,
                        fontFamily: 'Inter'),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          _ToolbarIcon(
              icon: Icons.filter_list_rounded,
              colors: colors,
              tooltip: "Filter"),
          _ToolbarIcon(
              icon: Icons.file_download_outlined,
              colors: colors,
              tooltip: "Export"),
          _ToolbarIcon(
              icon: Icons.print_outlined, colors: colors, tooltip: "Print"),
          const SizedBox(width: 4),
          _VerticalDivider(colors: colors),
          const SizedBox(width: 4),
          _ToolbarIcon(
            icon: Icons.refresh_rounded,
            colors: colors,
            tooltip: "Refresh",
            onTap: widget.onRefresh,
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActionsOverlay(ZenoSemanticColors colors) {
    return Positioned(
      bottom: 64,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: colors.bgTier2,
            borderRadius: BorderRadius.circular(30),
            border:
                Border.all(color: colors.accentPrimary.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${_selectedItems.length} selected",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: colors.accentPrimary,
                ),
              ),
              const SizedBox(width: 16),
              _VerticalDivider(colors: colors),
              const SizedBox(width: 16),
              ...widget.bulkActions,
              IconButton(
                onPressed: () => setState(() => _selectedItems = []),
                icon: Icon(Icons.close_rounded,
                    size: 18, color: colors.textSecondary),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(ZenoSemanticColors colors) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(top: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: [
          Text(
            "1-50 of ${widget.totalCount} records",
            style: TextStyle(
                fontSize: 11, color: colors.textSecondary, fontFamily: 'Inter'),
          ),
          const Spacer(),
          _PageArrow(icon: Icons.chevron_left_rounded, colors: colors),
          const SizedBox(width: 8),
          _PageNumber(label: "1", isActive: true, colors: colors),
          _PageNumber(label: "2", colors: colors),
          _PageNumber(label: "3", colors: colors),
          const SizedBox(width: 8),
          _PageArrow(icon: Icons.chevron_right_rounded, colors: colors),
        ],
      ),
    );
  }
}
