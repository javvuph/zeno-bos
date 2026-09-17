part of '../new_bill_screen.dart';

class _PosCartItem extends StatelessWidget {
  const _PosCartItem();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: colors.bgTier3,
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(Icons.inventory_2_outlined,
                      size: 18, color: colors.textDisabled),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("PREMIUM COTTON SHIRT",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 12)),
                      Text("SKU: SHRT-002-BL • BLUE / LARGE",
                          style: TextStyle(
                              fontSize: 9, color: colors.textDisabled)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(child: _QuantitySpinner(colors: colors)),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("₹850.00",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary)),
                Text("TAX: 18%",
                    style: TextStyle(fontSize: 8, color: colors.textDisabled)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text("₹850.00",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: colors.accentPrimary,
                      fontFamily: ZenoTypography.monoFamily)),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  size: 18, color: Colors.red),
              onPressed: () {}),
        ],
      ),
    );
  }
}

class _QuantitySpinner extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _QuantitySpinner({required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: const Icon(Icons.remove, size: 12),
              onPressed: () {},
              visualDensity: VisualDensity.compact),
          const Text("1",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
          IconButton(
              icon: const Icon(Icons.add, size: 12),
              onPressed: () {},
              visualDensity: VisualDensity.compact),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _SummaryRow({required this.label, required this.value, this.color});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: colors.textSecondary.withValues(alpha: 0.7))),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: color ?? colors.textPrimary,
                  fontFamily: ZenoTypography.monoFamily)),
        ],
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hotkey;
  final ZenoSemanticColors colors;
  const _PayButton(
      {required this.icon,
      required this.label,
      required this.hotkey,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: colors.bgTier1,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: colors.accentPrimary),
            const SizedBox(height: 6),
            Text(label,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
            const SizedBox(height: 2),
            Text(hotkey,
                style: TextStyle(fontSize: 8, color: colors.textDisabled)),
          ],
        ),
      ),
    );
  }
}
