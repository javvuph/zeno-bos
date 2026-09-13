import 'package:flutter/material.dart';

class BusinessSetupSelector extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumn("MAIN BUSINESS", mainBusinesses, [selectedMain], onMainChanged, isMulti: false),
        const SizedBox(width: 12),
        _buildColumn("SUB-BUSINESS TYPE", subBusinesses, enabledSubs, onSubToggled, isMulti: true),
        const SizedBox(width: 12),
        _buildColumn("BUSINESS SCALE", scales, [selectedScale], onScaleChanged, isMulti: false),
      ],
    );
  }

  Widget _buildColumn(String title, List<String> items, List<String> selectedValues, Function(String) onSelected, {required bool isMulti}) {
    return Expanded(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800, 
                      fontSize: 10, 
                      color: Colors.blueGrey.shade400,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Icon(isMulti ? Icons.checklist_rtl_rounded : Icons.keyboard_arrow_down, size: 14, color: Colors.blueGrey.shade300),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = selectedValues.any((v) => v.toUpperCase() == item.toUpperCase());
                  
                  return InkWell(
                    onTap: isLocked ? null : () => onSelected(item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.white,
                              border: Border.all(
                                color: isSelected ? Colors.blue : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: isSelected 
                              ? Icon(isLocked ? Icons.lock : Icons.check, size: 11, color: Colors.white)
                              : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? Colors.blue.shade700 : Colors.black87,
                              ),
                            ),
                          ),
                          if (isLocked && isSelected)
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text("🔒", style: TextStyle(fontSize: 10)),
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
      ),
    );
  }
}
