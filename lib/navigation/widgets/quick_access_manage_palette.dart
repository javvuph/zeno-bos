import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/quick_access_controller.dart';
import 'package:zeno/navigation/menu_registry.dart';

class QuickAccessManagePalette extends StatefulWidget {
  const QuickAccessManagePalette({super.key});

  @override
  State<QuickAccessManagePalette> createState() =>
      _QuickAccessManagePaletteState();
}

class _QuickAccessManagePaletteState extends State<QuickAccessManagePalette> {
  final TextEditingController _searchController = TextEditingController();
  List<ZenoMenuItem> _searchResults = [];
  final QuickAccessController _controller = QuickAccessController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchResults = _controller.search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ZenoTheme.surface,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ZenoTheme.border)),
      child: Container(
        width: 600,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Manage Quick Access",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: ZenoTheme.textPrimary)),
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) => Text(
                        "Capacity: ${_controller.items.length} / ${QuickAccessController.maxItems} items",
                        style: const TextStyle(
                            fontSize: 12, color: ZenoTheme.textSecondary),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: ZenoTheme.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // SEARCH BOX
            TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Search for screens to add...",
                hintStyle: const TextStyle(
                    color: ZenoTheme.textSecondary, fontSize: 13),
                prefixIcon:
                    const Icon(Icons.search, size: 18, color: ZenoTheme.accent),
                filled: true,
                fillColor: ZenoTheme.background,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: ZenoTheme.border)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: ZenoTheme.border)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: ZenoTheme.accent)),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildCurrentItems()
                  : _buildSearchResults(),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ZenoTheme.accent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Done",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
      SnackBar(
        backgroundColor: ZenoTheme.danger,
        content: Text(
          "Maximum limit of ${QuickAccessController.maxItems} shortcuts reached.",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    setState(() {}); // Force local rebuild for search
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
                      setState(() {}); // Force local rebuild for search
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
