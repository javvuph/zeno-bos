part of '../smart_cart_grid.dart';

extension SmartCartGridCells on SmartCartGrid {
  Widget _buildEmptyState(ZenoSemanticColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(ZenoSpacing.xl),
            decoration: BoxDecoration(
              color: colors.bgTier2,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shopping_basket_outlined,
                size: 64, color: colors.textDisabled),
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 2000.ms,
                  curve: Curves.easeInOut),
          const SizedBox(height: ZenoSpacing.lg),
          Text(
            'NO ITEMS IN CART',
            style: ZenoTypography.headlineMD(colors.textSecondary)
                .copyWith(letterSpacing: 2.0),
          ),
          const SizedBox(height: ZenoSpacing.sm),
          Text(
            'Scan a product or use the search panel to begin billing.',
            style: ZenoTypography.bodyMD(colors.textDisabled),
          ),
        ],
      ).animate().fadeIn().slideY(begin: 0.1),
    );
  }

  Widget _buildProductCell(
      BuildContext context, BillItem item, ZenoSemanticColors colors) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: colors.bgTier2,
            borderRadius: BorderRadius.circular(ZenoRadius.sm),
          ),
          child: Icon(Icons.inventory_2_outlined,
              size: 18, color: colors.textDisabled),
        ),
        const SizedBox(width: ZenoSpacing.md),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.productName,
                  style: ZenoTypography.bodyLG(colors.textPrimary)),
              Text(item.sku,
                  style: ZenoTypography.micro(colors.textSecondary)
                      .copyWith(fontFamily: 'monospace')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCell(BillItem item, ZenoSemanticColors colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.serialNumber != null)
          _InfoBadge(
              label: 'SN: ${item.serialNumber}',
              color: colors.accentPurple,
              colors: colors),
        if (item.batchNumber != null)
          _InfoBadge(
              label: 'BT: ${item.batchNumber}',
              color: colors.accentPrimary,
              colors: colors),
        if (item.notes != null)
          _InfoBadge(
              label: 'NOTE',
              icon: Icons.note_alt_outlined,
              color: colors.statusWarning,
              colors: colors),
        if (item.serialNumber == null &&
            item.batchNumber == null &&
            item.notes == null)
          Text('No extra info',
              style: ZenoTypography.micro(colors.textDisabled)),
      ],
    );
  }

  Widget _buildPriceCell(
      BuildContext context, BillItem item, ZenoSemanticColors colors) {
    return InkWell(
      onLongPress: () => _showPriceOverride(context, item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${item.unitPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: item.isPriceOverridden
                  ? colors.statusWarning
                  : colors.textPrimary,
            ),
          ),
          if (item.isPriceOverridden)
            Text(
              'ORIG: \$${item.originalPrice!.toStringAsFixed(2)}',
              style: ZenoTypography.micro(colors.textDisabled)
                  .copyWith(decoration: TextDecoration.lineThrough),
            ),
        ],
      ),
    );
  }

  Widget _buildQtyCell(
      BuildContext context, BillItem item, ZenoSemanticColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(ZenoRadius.full),
        border: Border.all(color: colors.borderSubtle),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(
            icon: Icons.remove,
            onTap: () => context.read<BillingStudioController>().add(
                  UpdateItemQuantityRequested(
                      item.productId, item.quantity - 1),
                ),
            colors: colors,
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
            ),
          ),
          _QtyButton(
            icon: Icons.add,
            onTap: () => context.read<BillingStudioController>().add(
                  UpdateItemQuantityRequested(
                      item.productId, item.quantity + 1),
                ),
            colors: colors,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}
