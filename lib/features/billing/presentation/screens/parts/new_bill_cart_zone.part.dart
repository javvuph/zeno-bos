part of '../new_bill_screen.dart';

extension _NewBillScreenCartZone on NewBillScreen {
  Widget _buildSmartCartZone(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("SMART CART",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: colors.textPrimary,
                      letterSpacing: 1)),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.accentPrimary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text("4 ITEMS",
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: colors.accentPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colors.bgTier3,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text("PRODUCT DETAILS",
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900))),
                Expanded(
                    flex: 2,
                    child: Text("QTY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900))),
                Expanded(
                    flex: 2,
                    child: Text("UNIT PRICE",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900))),
                Expanded(
                    flex: 2,
                    child: Text("TOTAL",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900))),
                SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderSubtle),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8)),
              ),
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (_, __) => Divider(
                    height: 1, color: colors.borderSubtle),
                itemBuilder: (context, index) =>
                    const _PosCartItem(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
