part of '../quick_access_manage_palette.dart';

extension _QuickAccessManagePaletteItemsState
    on _QuickAccessManagePaletteState {
  Widget _buildCurrentItems() {
    return ListView.builder(
      itemCount: MenuRegistry.all.length,
      itemBuilder: (context, index) {
        final category = MenuRegistry.all[index];
        final categoryColor = category.columns.first.color ?? ZenoTheme.accent;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(category.icon, size: 16, color: categoryColor),
                  const SizedBox(width: 12),
                  Text(
                    category.label.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: categoryColor,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child:
                          Divider(color: categoryColor.withValues(alpha: 0.1))),
                ],
              ),
            ),
            ...category.columns.expand((col) => col.items).map((item) {
              if (item.route == null) return const SizedBox.shrink();

              return ListenableBuilder(
                listenable: _controller,
                builder: (context, _) {
                  final exists =
                      _controller.items.any((i) => i.route == item.route);
                  final itemColor = item.color ?? categoryColor;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: ZenoTheme.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: exists
                            ? itemColor.withValues(alpha: 0.3)
                            : ZenoTheme.border,
                        width: exists ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon,
                            size: 16,
                            color:
                                exists ? itemColor : ZenoTheme.textSecondary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  exists ? FontWeight.bold : FontWeight.normal,
                              color: exists
                                  ? ZenoTheme.textPrimary
                                  : ZenoTheme.textSecondary,
                            ),
                          ),
                        ),
                        if (exists)
                          IconButton(
                            onPressed: () =>
                                _controller.removeItem(item.route!),
                            icon: const Icon(Icons.remove_circle,
                                size: 20, color: ZenoTheme.danger),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          )
                        else
                          IconButton(
                            onPressed: () {
                              if (!_controller.addItem(item)) {
                                _showLimitError();
                              }
                            },
                            icon: Icon(Icons.add_circle_outline,
                                size: 20, color: itemColor),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  void _showLimitError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: ZenoTheme.danger,
        content: Text(
          "Maximum limit of ${QuickAccessController.maxItems} shortcuts reached.",
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
          child: Text("No results found",
              style: TextStyle(color: ZenoTheme.textSecondary)));
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        final exists = _controller.items.any((i) => i.route == item.route);
        final itemColor = item.color ?? ZenoTheme.accent;

        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ZenoTheme.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  exists ? itemColor.withValues(alpha: 0.3) : ZenoTheme.border,
              width: exists ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(item.icon,
                  size: 16,
                  color: exists ? itemColor : ZenoTheme.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: exists ? FontWeight.bold : FontWeight.normal,
                    color: exists
                        ? ZenoTheme.textPrimary
                        : ZenoTheme.textSecondary,
                  ),
                ),
              ),
              if (exists)
                IconButton(
                  onPressed: () {
                    _controller.removeItem(item.route!);
                    setState(() {});
                  },
                  icon: const Icon(Icons.remove_circle,
                      size: 20, color: ZenoTheme.danger),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              else
                IconButton(
                  onPressed: () {
                    if (_controller.addItem(item)) {
                      setState(() {});
                    } else {
                      _showLimitError();
                    }
                  },
                  icon: Icon(Icons.add_circle_outline,
                      size: 20, color: itemColor),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
        );
      },
    );
  }
}
