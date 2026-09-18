import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';

class InventoryControlsBar extends StatelessWidget {
  final String activeStatusFilter;
  final String activeTimeFilter;
  final ValueChanged<String> onStatusFilterChanged;
  final ValueChanged<String> onTimeFilterChanged;
  final ValueChanged<String> onSearchQueryChanged;

  const InventoryControlsBar({
    super.key,
    required this.activeStatusFilter,
    required this.activeTimeFilter,
    required this.onStatusFilterChanged,
    required this.onTimeFilterChanged,
    required this.onSearchQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final textPrimary = colors?.textPrimary ?? const Color(0xFF26324A);
    final textSecondary = colors?.textSecondary ?? const Color(0xFF64748B);
    final accent = colors?.accentPrimary ?? const Color(0xFF6366F1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildFilterTab("All Products", "ALL", accent, border, textSecondary),
            _buildFilterTab("In Stock", "IN_STOCK", accent, border, textSecondary),
            _buildFilterTab("Out of Stock", "OUT_OF_STOCK", accent, border, textSecondary),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: activeTimeFilter,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  onChanged: (val) {
                    if (val != null) onTimeFilterChanged(val);
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "ALL",
                      child: Text("🕒 All Added Dates"),
                    ),
                    DropdownMenuItem(
                      value: "NEW",
                      child: Text("🟢 Green: Latest (< 1 Mo)"),
                    ),
                    DropdownMenuItem(
                      value: "3M",
                      child: Text("🔵 Blue: 1–3 Months"),
                    ),
                    DropdownMenuItem(
                      value: "6M",
                      child: Text("🟡 Yellow: 3–6 Months"),
                    ),
                    DropdownMenuItem(
                      value: "12M",
                      child: Text("🟠 Orange: 6–12 Months"),
                    ),
                    DropdownMenuItem(
                      value: "1Y",
                      child: Text("🔴 Red: 1 Year+ Dead Stock"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // SEARCH INPUT
        Container(
          width: 320,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(Icons.search_rounded, size: 16, color: Color(0xFF94A3B8)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (q) => onSearchQueryChanged(q.trim().toLowerCase()),
                  style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A)),
                  decoration: const InputDecoration(
                    hintText: "Search product, style, SKU or barcode...",
                    hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(String label, String value, Color accent, Color border, Color textSecondary) {
    final isActive = activeStatusFilter == value;
    return InkWell(
      onTap: () => onStatusFilterChanged(value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? accent.withValues(alpha: 0.10) : Colors.white.withValues(alpha: 0.78),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? accent.withValues(alpha: 0.30) : border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isActive ? accent : textSecondary,
          ),
        ),
      ),
    );
  }
}
