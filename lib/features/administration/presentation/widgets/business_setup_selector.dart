import 'package:flutter/material.dart';
import 'business_setup_selector_main_column.dart';
import 'business_setup_selector_sub_scale_columns.dart';

class BusinessSetupSelector extends StatefulWidget {
  final List<String> mainBusinesses;
  final List<String> subBusinesses;
  final List<String> scales;
  final String selectedMain;
  final List<String> enabledSubs;
  final String selectedScale;
  final Function(String) onMainChanged;
  final Function(String) onSubToggled;
  final Function(String) onScaleChanged;
  final bool isLocked;

  const BusinessSetupSelector({
    super.key,
    required this.mainBusinesses,
    required this.subBusinesses,
    required this.scales,
    required this.selectedMain,
    required this.enabledSubs,
    required this.selectedScale,
    required this.onMainChanged,
    required this.onSubToggled,
    required this.onScaleChanged,
    this.isLocked = false,
  });

  @override
  State<BusinessSetupSelector> createState() => _BusinessSetupSelectorState();
}

class _BusinessSetupSelectorState extends State<BusinessSetupSelector> {
  String _mainSearchQuery = "";

  String _getCategoryIcon(String category) {
    final name = category.toUpperCase();
    if (name.contains('FASHION')) return '👔';
    if (name.contains('RETAIL')) return '🏪';
    if (name.contains('FOOD') || name.contains('BEVERAGE') || name.contains('F&B')) return '🍔';
    if (name.contains('ELECTRONIC')) return '📱';
    if (name.contains('HEALTH')) return '⚕️';
    if (name.contains('SERVICE')) return '🔧';
    if (name.contains('WHOLESALE')) return '📦';
    if (name.contains('FURNITURE')) return '🛋️';
    if (name.contains('HARDWARE')) return '🧰';
    if (name.contains('AUTO')) return '🚗';
    if (name.contains('AGRI')) return '🌾';
    if (name.contains('PET')) return '🐾';
    if (name.contains('STATIONERY')) return '✏️';
    if (name.contains('BOOK')) return '📚';
    if (name.contains('TOY')) return '🧸';
    if (name.contains('SPORT')) return '⚽';
    if (name.contains('DECOR')) return '🖼️';
    return '🏪';
  }

  bool _isSubSelected(String subItem) {
    return widget.enabledSubs.contains(subItem);
  }

  void _handleSubToggle(String subItem) {
    widget.onSubToggled(subItem);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSubBusinesses = widget.subBusinesses;

    final filteredMain = widget.mainBusinesses
        .where((m) => m.toLowerCase().contains(_mainSearchQuery.toLowerCase()))
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BusinessSetupMainColumn(
                items: filteredMain,
                selectedMain: widget.selectedMain,
                isLocked: widget.isLocked,
                onSearchChanged: (v) => setState(() => _mainSearchQuery = v),
                onMainChanged: widget.onMainChanged,
                getCategoryIcon: _getCategoryIcon,
              ),
              const SizedBox(height: 16),
              BusinessSetupSubColumn(
                items: effectiveSubBusinesses,
                isLocked: widget.isLocked,
                isSubSelected: _isSubSelected,
                handleSubToggle: _handleSubToggle,
              ),
              const SizedBox(height: 16),
              BusinessSetupScaleColumn(
                selectedScale: widget.selectedScale,
                isLocked: widget.isLocked,
                onScaleChanged: widget.onScaleChanged,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BusinessSetupMainColumn(
                items: filteredMain,
                selectedMain: widget.selectedMain,
                isLocked: widget.isLocked,
                onSearchChanged: (v) => setState(() => _mainSearchQuery = v),
                onMainChanged: widget.onMainChanged,
                getCategoryIcon: _getCategoryIcon,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BusinessSetupSubColumn(
                items: effectiveSubBusinesses,
                isLocked: widget.isLocked,
                isSubSelected: _isSubSelected,
                handleSubToggle: _handleSubToggle,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BusinessSetupScaleColumn(
                selectedScale: widget.selectedScale,
                isLocked: widget.isLocked,
                onScaleChanged: widget.onScaleChanged,
              ),
            ),
          ],
        );
      },
    );
  }
}
