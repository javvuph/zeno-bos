import 'package:flutter/material.dart';

class InventoryBulkActionBar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onStockIn;
  final VoidCallback onStockOut;
  final VoidCallback onSetStock;
  final VoidCallback onTransfer;
  final VoidCallback onArchive;

  const InventoryBulkActionBar({
    super.key,
    required this.selectedCount,
    required this.onStockIn,
    required this.onStockOut,
    required this.onSetStock,
    required this.onTransfer,
    required this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCount <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC7D2FE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "$selectedCount SELECTED",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "Select products to perform batch operations",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4338CA)),
          ),
          const Spacer(),
          _actionBtn("STOCK IN", const Color(0xFFD1FAE5), const Color(0xFF047857), onStockIn),
          const SizedBox(width: 8),
          _actionBtn("STOCK OUT", const Color(0xFFFEE2E2), const Color(0xFFB91C1C), onStockOut),
          const SizedBox(width: 8),
          _actionBtn("SET STOCK", const Color(0xFFE0E7FF), const Color(0xFF3730A3), onSetStock),
          const SizedBox(width: 8),
          _actionBtn("TRANSFER", Colors.white, const Color(0xFF334155), onTransfer, hasBorder: true),
          const SizedBox(width: 8),
          _actionBtn("ARCHIVE", Colors.white, const Color(0xFF334155), onArchive, hasBorder: true),
          const SizedBox(width: 12),
          const Text(
            "Shift + Click • Ctrl + Click • Ctrl + A",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF6366F1)),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(String label, Color bg, Color text, VoidCallback onTap, {bool hasBorder = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: hasBorder ? Border.all(color: const Color(0xFFCBD5E1)) : null,
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: text, letterSpacing: 0.4),
        ),
      ),
    );
  }
}
