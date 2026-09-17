part of '../new_bill_screen.dart';

extension _NewBillScreenVessel on NewBillScreen {
  Widget _buildTopVessel(ZenoSemanticColors colors) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors.bgTier1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: colors.accentPrimary.withValues(alpha: 0.3),
                    width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: colors.accentPrimary.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded,
                      color: colors.accentPrimary, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText:
                            "COMMAND VESSEL: SCAN BARCODE, TYPE SKU, OR USE /SLASH COMMANDS...",
                        hintStyle:
                            TextStyle(fontSize: 12, letterSpacing: 0.5),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.bgTier3,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("CTRL + L",
                        style: TextStyle(
                            fontSize: 9, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
