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

part 'parts/smart_cart_grid_cells.part.dart';

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
                    color: colors.accentPrimary,
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
