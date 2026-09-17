import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';

class ShortcutInfo {
  final String keys;
  final String description;
  final String category;

  const ShortcutInfo({
    required this.keys,
    required this.description,
    required this.category,
  });
}

class ZenoKeyboardShortcutsDialog extends StatefulWidget {
  const ZenoKeyboardShortcutsDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ZenoKeyboardShortcutsDialog(),
    );
  }

  @override
  State<ZenoKeyboardShortcutsDialog> createState() =>
      _ZenoKeyboardShortcutsDialogState();
}

class _ZenoKeyboardShortcutsDialogState
    extends State<ZenoKeyboardShortcutsDialog> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchQuery = '';

  static const List<ShortcutInfo> _allShortcuts = [
    // GENERAL
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + F',
      description: 'Focus Search / Find field',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + N',
      description: 'Create new record / open new tab',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + S',
      description: 'Save current form / record / draft',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + Shift + S',
      description: 'Save As / Save Draft',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + P',
      description: 'Print invoice, receipt, or report',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + K',
      description: 'Open Command Palette',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + W',
      description: 'Close active tab',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Ctrl + Tab',
      description: 'Switch to next tab',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'F1 or Ctrl + /',
      description: 'Open Shortcut Cheat-sheet',
    ),
    ShortcutInfo(
      category: 'GENERAL',
      keys: 'Esc',
      description: 'Cancel edit / close modal / clear search',
    ),

    // TABLES & DATA GRIDS
    ShortcutInfo(
      category: 'TABLES',
      keys: '↑  ↓  ←  →',
      description: 'Navigate row and cell selection',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Tab / Shift + Tab',
      description: 'Move to next / previous cell',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'F2',
      description: 'Enter inline cell editing mode',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Enter',
      description: 'Commit cell edit and move to row below',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Esc',
      description: 'Cancel cell editing and restore value',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Home / End',
      description: 'Jump to first / last column in row',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Ctrl + Home / End',
      description: 'Jump to top-left / bottom-right cell',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Shift + ↑ / ↓',
      description: 'Extend multi-row selection',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Ctrl + A',
      description: 'Select all visible table rows',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Ctrl + C',
      description: 'Copy selected rows as TSV (Excel/Sheets)',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Ctrl + V',
      description: 'Paste tabular data from clipboard',
    ),
    ShortcutInfo(
      category: 'TABLES',
      keys: 'Delete',
      description: 'Delete selected row(s) with confirmation',
    ),

    // PRODUCT STUDIO
    ShortcutInfo(
      category: 'PRODUCT STUDIO',
      keys: 'Tab / Shift + Tab',
      description: 'Move through Basic Info fields',
    ),
    ShortcutInfo(
      category: 'PRODUCT STUDIO',
      keys: 'Space / Enter',
      description: 'Toggle Colour or Size attribute selection',
    ),
    ShortcutInfo(
      category: 'PRODUCT STUDIO',
      keys: '↑  ↓ in Variant Grid',
      description: 'Navigate variant rows',
    ),
    ShortcutInfo(
      category: 'PRODUCT STUDIO',
      keys: 'F2 / Enter',
      description: 'Edit Quantity and move to next row',
    ),
    ShortcutInfo(
      category: 'PRODUCT STUDIO',
      keys: 'Ctrl + S',
      description: 'Save created Product with variants',
    ),

    // BILLING / POS
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'Ctrl + F or F3',
      description: 'Focus Quick Add Product Search',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: '↑  ↓ in Search',
      description: 'Navigate search results / cart lines',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'Enter in Search',
      description: 'Add highlighted item to cart',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'F2',
      description: 'Edit Quantity for selected cart line',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'F4',
      description: 'Focus Customer Search / Selector',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'F8',
      description: 'Park / Hold active cart',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'F9',
      description: 'Apply Bill Discount',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'F12 or Ctrl + Enter',
      description: 'Open Payment / Checkout modal',
    ),
    ShortcutInfo(
      category: 'BILLING / POS',
      keys: 'Ctrl + P',
      description: 'Print receipt or invoice preview',
    ),

    // INVENTORY & PURCHASING
    ShortcutInfo(
      category: 'INVENTORY',
      keys: 'Ctrl + F',
      description: 'Search stock by name, SKU, or Barcode',
    ),
    ShortcutInfo(
      category: 'INVENTORY',
      keys: 'F2',
      description: 'Edit stock adjustment quantity',
    ),
    ShortcutInfo(
      category: 'INVENTORY',
      keys: 'Ctrl + S',
      description: 'Save stock adjustment or receiving sheet',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    final filtered = _allShortcuts.where((s) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return s.keys.toLowerCase().contains(q) ||
          s.description.toLowerCase().contains(q) ||
          s.category.toLowerCase().contains(q);
    }).toList();

    final categories = [
      'GENERAL',
      'TABLES',
      'PRODUCT STUDIO',
      'BILLING / POS',
      'INVENTORY',
    ];

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).pop(),
      },
      child: FocusScope(
        autofocus: true,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Container(
            width: 780,
            constraints: const BoxConstraints(maxHeight: 650),
            decoration: BoxDecoration(
              color: colors.bgTier1,
              borderRadius: BorderRadius.circular(ZenoRadius.lg),
              border: Border.all(color: colors.borderSubtle),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // HEADER
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: colors.bgTier2,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(ZenoRadius.lg),
                    ),
                    border:
                        Border(bottom: BorderSide(color: colors.borderSubtle)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.keyboard_outlined,
                          size: 22, color: colors.accentPrimary),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "KEYBOARD SHORTCUTS CHEAT-SHEET",
                            style: ZenoTypography.headlineSM(colors.textPrimary)
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "F1 or Ctrl + /  — Press Esc to close",
                            style: ZenoTypography.caption(colors.textSecondary),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded, size: 20),
                        tooltip: "Close (Esc)",
                      ),
                    ],
                  ),
                ),

                // SEARCH BAR
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: colors.bgTier2,
                      borderRadius: BorderRadius.circular(ZenoRadius.md),
                      border: Border.all(color: colors.borderSubtle),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,
                            size: 16, color: colors.textSecondary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _focusNode,
                            onChanged: (val) =>
                                setState(() => _searchQuery = val),
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textPrimary,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  "Filter shortcuts... (e.g. Save, Print, Cart, Table)",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: colors.textDisabled,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 14),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                // CONTENT LIST
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories.map((category) {
                        final catShortcuts = filtered
                            .where((s) => s.category == category)
                            .toList();
                        if (catShortcuts.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 8),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: colors.accentPrimary,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: colors.bgTier2,
                                borderRadius:
                                    BorderRadius.circular(ZenoRadius.md),
                                border: Border.all(color: colors.borderSubtle),
                              ),
                              child: Column(
                                children: List.generate(
                                  catShortcuts.length,
                                  (idx) {
                                    final item = catShortcuts[idx];
                                    final isLast =
                                        idx == catShortcuts.length - 1;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: isLast
                                            ? null
                                            : Border(
                                                bottom: BorderSide(
                                                    color: colors.borderSubtle
                                                        .withValues(
                                                            alpha: 0.5)),
                                              ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.description,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: colors.textPrimary,
                                              ),
                                            ),
                                          ),
                                          _buildKeyBadge(item.keys, colors),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // FOOTER
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: colors.bgTier2,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(ZenoRadius.lg),
                    ),
                    border: Border(top: BorderSide(color: colors.borderSubtle)),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "ZENO Business Operating System — Keyboard-First Experience",
                          style: ZenoTypography.caption(colors.textDisabled),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.accentPrimary,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        child: const Text("Close",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyBadge(String keys, ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Text(
        keys,
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'Courier',
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
