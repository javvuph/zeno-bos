import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';

class InventoryVariantSubtable extends StatelessWidget {
  final ProductMaster product;
  const InventoryVariantSubtable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.isStandalone || product.variants.isEmpty) return const SizedBox.shrink();
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 18, bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.bgTier3.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.bgSurface.withValues(alpha: 0.82),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: Wrap(
              spacing: 22,
              runSpacing: 6,
              children: [
                _Meta('CATEGORY', product.category, colors),
                _Meta('BRAND', product.brand, colors),
                _Meta('COST', '₹' + product.cost.toStringAsFixed(0), colors),
                _Meta('MARGIN', product.marginPercentage.toStringAsFixed(0) + '%', colors),
                _Meta('REORDER', product.reorderLevel.toStringAsFixed(0) + ' PCS', colors),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 22,
              headingRowHeight: 32,
              dataRowMinHeight: 34,
              dataRowMaxHeight: 38,
              headingRowColor: WidgetStateProperty.all(colors.bgTier2.withValues(alpha: 0.82)),
              columns: [
                DataColumn(label: Text('COLOUR / SIZE', style: _head(colors))),
                DataColumn(label: Text('SKU', style: _head(colors))),
                DataColumn(label: Text('BARCODE', style: _head(colors))),
                DataColumn(label: Text('STOCK', style: _head(colors))),
                DataColumn(label: Text('STATUS', style: _head(colors))),
              ],
              rows: product.variants.map((variant) {
                final out = variant.qty <= 0;
                final low = !out && variant.qty <= product.reorderLevel;
                final status = out ? 'OUT OF STOCK' : (low ? 'LOW STOCK' : 'IN STOCK');
                final statusColor = out ? colors.statusDanger : (low ? colors.statusWarning : colors.statusSuccess);
                return DataRow(cells: [
                  DataCell(Text(variant.color + ' / ' + variant.size, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: colors.accentPrimary))),
                  DataCell(Text(variant.sku, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: colors.textSecondary))),
                  DataCell(Text(variant.barcode, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: colors.textSecondary))),
                  DataCell(Text(variant.qty.toStringAsFixed(0) + ' PCS', style: TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: colors.textPrimary))),
                  DataCell(Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                    child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: statusColor)),
                  )),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle _head(ZenoSemanticColors colors) => TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: colors.textSecondary, letterSpacing: 0.35);

class _Meta extends StatelessWidget {
  final String label;
  final String value;
  final ZenoSemanticColors colors;
  const _Meta(this.label, this.value, this.colors);
  @override
  Widget build(BuildContext context) => RichText(
    text: TextSpan(children: [
      TextSpan(text: label + '  ', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: colors.textSecondary)),
      TextSpan(text: value.isEmpty ? '—' : value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary)),
    ]),
  );
}