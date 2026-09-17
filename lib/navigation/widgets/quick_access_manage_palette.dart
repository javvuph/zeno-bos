import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/quick_access_controller.dart';
import 'package:zeno/navigation/menu_registry.dart';

part 'parts/quick_access_manage_items.part.dart';

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
}
