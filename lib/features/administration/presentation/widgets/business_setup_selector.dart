import 'package:flutter/material.dart';

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
    if (name.contains('FASHION')) return '👗';
    if (name.contains('RETAIL')) return '🛒';
    if (name.contains('FOOD') || name.contains('BEVERAGE') || name.contains('F&B')) return '🍕';
    if (name.contains('ELECTRONIC')) return '📱';
    if (name.contains('HEALTH')) return '💊';
    if (name.contains('SERVICE')) return '🛠️';
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

  List<String> _getFashionSubTypes() {
    return [
      "Clothing (Shirts, Pants, T-Shirts)",
      "Footwear",
      "Watches",
      "Eyewear",
      "Bags & Luggage",
      "Jewelry & Metals",
      "Perfumes & Cosmetics",
      "Boutique",
      "Bridal Wear",
      "Accessories",
      "Innerwear",
      "Kids Fashion",
      "Sportswear",
    ];
  }

  bool _isSubSelected(String subItem) {
    if (widget.enabledSubs.contains(subItem)) return true;
    if (subItem.startsWith("Clothing") &&
        (widget.enabledSubs.contains("Clothing") ||
         widget.enabledSubs.contains("Clothing (Shirts, Pants, T-Shirts)"))) {
      return true;
    }
    return false;
  }

  void _handleSubToggle(String subItem) {
    if (subItem.startsWith("Clothing")) {
      if (widget.enabledSubs.contains("Clothing")) {
        widget.onSubToggled("Clothing");
      } else if (widget.enabledSubs.contains("Clothing (Shirts, Pants, T-Shirts)")) {
        widget.onSubToggled("Clothing (Shirts, Pants, T-Shirts)");
      } else {
        widget.onSubToggled("Clothing (Shirts, Pants, T-Shirts)");
      }
    } else {
      widget.onSubToggled(subItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFashion = widget.selectedMain.toUpperCase() == "FASHION";
    final effectiveSubBusinesses = isFashion
        ? _getFashionSubTypes()
        : widget.subBusinesses;

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
              _buildMainBusinessColumn(filteredMain),
              const SizedBox(height: 12),
              _buildSubBusinessColumn(effectiveSubBusinesses),
              const SizedBox(height: 12),
              _buildScaleColumn(),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // COLUMN 1: MAIN BUSINESS (Single-Select)
            Expanded(
              child: _buildMainBusinessColumn(filteredMain),
            ),
            const SizedBox(width: 12),
            // COLUMN 2: SUB-BUSINESS TYPE (Multi-Select)
            Expanded(
              child: _buildSubBusinessColumn(effectiveSubBusinesses),
            ),
            const SizedBox(width: 12),
            // COLUMN 3: BUSINESS SCALE (Single-Select)
            Expanded(
              child: _buildScaleColumn(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainBusinessColumn(List<String> items) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MAIN BUSINESS *",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: Colors.blueGrey.shade700,
                    letterSpacing: 0.8,
                  ),
                ),
                Icon(Icons.radio_button_checked, size: 14, color: Colors.blue.shade600),
              ],
            ),
          ),
          // Search Filter for all 18 Master Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      onChanged: (v) => setState(() => _mainSearchQuery = v),
                      style: const TextStyle(fontSize: 11),
                      decoration: const InputDecoration(
                        hintText: "Search Category...",
                        hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Single-Select List with Radio Buttons
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = widget.selectedMain.toUpperCase() == item.toUpperCase();

                return InkWell(
                  onTap: widget.isLocked ? null : () => widget.onMainChanged(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                    child: Row(
                      children: [
                        // Radio Button Indicator
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.blue.shade600 : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade600,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Text(_getCategoryIcon(item), style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                              color: isSelected ? Colors.blue.shade800 : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubBusinessColumn(List<String> items) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SUB-BUSINESS TYPE (MULTI-SELECT)",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: Colors.blueGrey.shade700,
                    letterSpacing: 0.8,
                  ),
                ),
                Icon(Icons.check_box_outlined, size: 14, color: Colors.blue.shade600),
              ],
            ),
          ),
          // Checkbox List (Multi-Select)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = _isSubSelected(item);

                return InkWell(
                  onTap: widget.isLocked ? null : () => _handleSubToggle(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    color: isSelected ? Colors.blue.shade50.withValues(alpha: 0.5) : Colors.transparent,
                    child: Row(
                      children: [
                        // Checkbox Indicator
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue.shade600 : Colors.white,
                            border: Border.all(
                              color: isSelected ? Colors.blue.shade600 : Colors.grey.shade400,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, size: 12, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                              color: isSelected ? Colors.blue.shade900 : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaleColumn() {
    final scaleOptions = [
      {
        "key": "SMALL",
        "title": "SMALL",
        "subtitle": "1 Store / Village",
        "icon": Icons.storefront_outlined,
      },
      {
        "key": "GROWING",
        "title": "GROWING",
        "subtitle": "2-3 Branches",
        "icon": Icons.account_tree_outlined,
      },
      {
        "key": "ENTERPRISE",
        "title": "ENTERPRISE",
        "subtitle": "Multi-Chain & HQ",
        "icon": Icons.corporate_fare_outlined,
      },
    ];

    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BUSINESS SCALE *",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    color: Colors.blueGrey.shade700,
                    letterSpacing: 0.8,
                  ),
                ),
                Icon(Icons.tune_rounded, size: 14, color: Colors.blue.shade600),
              ],
            ),
          ),
          // Single-Select Cards for Scale
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: scaleOptions.length,
              itemBuilder: (context, index) {
                final option = scaleOptions[index];
                final key = option["key"] as String;
                final title = option["title"] as String;
                final subtitle = option["subtitle"] as String;
                final icon = option["icon"] as IconData;
                final isSelected = widget.selectedScale.toUpperCase() == key;

                return InkWell(
                  onTap: widget.isLocked ? null : () => widget.onScaleChanged(key),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade50 : Colors.grey.shade50,
                      border: Border.all(
                        color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Radio Button
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.blue.shade600 : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue.shade600,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          icon,
                          size: 20,
                          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.blue.shade900 : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
