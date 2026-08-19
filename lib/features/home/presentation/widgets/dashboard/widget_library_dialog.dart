import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'widget_registry.dart';

class WidgetLibraryDialog extends StatefulWidget {
  const WidgetLibraryDialog({super.key});

  @override
  State<WidgetLibraryDialog> createState() => _WidgetLibraryDialogState();
}

class _WidgetLibraryDialogState extends State<WidgetLibraryDialog> {
  String searchQuery = "";
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categories = WidgetRegistry.getCategories();
    final filteredWidgets = WidgetRegistry.allWidgets.where((w) {
      final matchesSearch =
          w.label.toLowerCase().contains(searchQuery.toLowerCase()) ||
              w.category.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == null || w.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Dialog(
      backgroundColor: ZenoTheme.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ZenoTheme.border)),
      child: Container(
        width: 800,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryList(categories),
                  const VerticalDivider(width: 48, color: ZenoTheme.border),
                  Expanded(child: _buildWidgetGrid(filteredWidgets)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("WIDGET LIBRARY",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2)),
            Text("Add analytics and operations modules to your workspace",
                style: TextStyle(fontSize: 12, color: ZenoTheme.textSecondary)),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 250,
          child: TextField(
            onChanged: (v) => setState(() => searchQuery = v),
            decoration: InputDecoration(
              hintText: "Search widgets...",
              prefixIcon: const Icon(Icons.search, size: 18),
              isDense: true,
              filled: true,
              fillColor: ZenoTheme.surface,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(List<String> categories) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryItem(
            label: "All Widgets",
            isSelected: selectedCategory == null,
            onTap: () => setState(() => selectedCategory = null),
          ),
          ...categories.map((c) => _CategoryItem(
                label: c,
                isSelected: selectedCategory == c,
                onTap: () => setState(() => selectedCategory = c),
              )),
        ],
      ),
    );
  }

  Widget _buildWidgetGrid(List<WidgetMetadata> widgets) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        final w = widgets[index];
        return InkWell(
          onTap: () => Navigator.pop(context, w.key),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ZenoTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ZenoTheme.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ZenoTheme.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(w.icon, size: 20, color: ZenoTheme.accent),
                    ),
                    const Spacer(),
                    const Icon(Icons.add_circle_outline,
                        size: 18, color: ZenoTheme.textSecondary),
                  ],
                ),
                const SizedBox(height: 16),
                Text(w.label.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(w.description,
                    style: const TextStyle(
                        fontSize: 10, color: ZenoTheme.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem(
      {required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? ZenoTheme.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? ZenoTheme.accent : ZenoTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
