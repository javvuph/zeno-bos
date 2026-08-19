import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/dialogs/manager_override_dialog.dart';
import 'package:zeno/features/billing/presentation/dialogs/item_details_dialog.dart';

class SmartCartGrid extends StatelessWidget {
  const SmartCartGrid({super.key});

  void _showItemDetails(BuildContext context, BillItem item) {
    showDialog(
      context: context,
      builder: (context) => ItemDetailsDialog(
        item: item,
        onSave: (serial, batch, expiry, notes) {
          context.read<BillingStudioController>().add(
                UpdateItemTrackingRequested(
                  item.productId,
                  serialNumber: serial,
                  batchNumber: batch,
                  expiryDate: expiry,
                ),
              );
          if (notes != null) {
            context.read<BillingStudioController>().add(
                  AddLineNoteRequested(item.productId, notes),
                );
          }
        },
      ),
    );
  }

  void _showPriceOverride(BuildContext context, BillItem item) {
    showDialog(
      context: context,
      builder: (context) => ManagerOverrideDialog(
        action: 'Price Override: ${item.productName}',
        onResult: (approved) {
          if (approved) {
            _promptNewPrice(context, item);
          }
        },
      ),
    );
  }

  void _promptNewPrice(BuildContext context, BillItem item) {
    final controller = TextEditingController(text: item.unitPrice.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter New Price'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(prefixText: '\$'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              final newPrice = double.tryParse(controller.text);
              if (newPrice != null) {
                context
                    .read<BillingStudioController>()
                    .add(PriceOverrideRequested(item.productId, newPrice));
              }
              Navigator.pop(context);
            },
            child: const Text('APPLY'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        if (state.activeBill.items.isEmpty) {
          return _buildEmptyState(colors);
        }

        return Container(
          color: colors.bgTier1,
          child: ZenoTable<BillItem>(
            items: state.activeBill.items,
            columns: [
              ZenoTableColumn(
                label: 'Product',
                width: 250,
                builder: (item) => _buildProductCell(context, item, colors),
              ),
              ZenoTableColumn(
                label: 'Details',
                width: 150,
                builder: (item) => _buildDetailsCell(item, colors),
              ),
              ZenoTableColumn(
                label: 'Price',
                width: 120,
                isNumeric: true,
                builder: (item) => _buildPriceCell(context, item, colors),
              ),
              ZenoTableColumn(
                label: 'Qty',
                width: 130,
                builder: (item) => _buildQtyCell(context, item, colors),
              ),
              ZenoTableColumn(
                label: 'Total',
                width: 120,
                isNumeric: true,
                builder: (item) => Text(
                  '\$${item.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: colors.accentPrimary, // Thematic total
                    fontSize: 15,
                  ),
                ),
              ),
              ZenoTableColumn(
                label: '',
                width: 100,
                builder: (item) => Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.info_outline,
                          color: colors.accentPrimary, size: 18),
                      onPressed: () => _showItemDetails(context, item),
                      tooltip: 'Item Details',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_sweep_outlined,
                          color: colors.statusDanger.withValues(alpha: 0.7),
                          size: 18),
                      onPressed: () => context
                          .read<BillingStudioController>()
                          .add(RemoveItemRequested(item.productId)),
                      tooltip: 'Remove Item',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: ZenoDuration.std);
      },
    );
  }

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

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  final bool isPrimary;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.colors,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZenoRadius.full),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isPrimary ? colors.accentPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            size: 14, color: isPrimary ? Colors.black : colors.textSecondary),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final ZenoSemanticColors colors;

  const _InfoBadge(
      {required this.label,
      this.icon,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 8, color: color),
            const SizedBox(width: 2)
          ],
          Text(label.toUpperCase(),
              style: TextStyle(
                  color: color, fontSize: 7, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
