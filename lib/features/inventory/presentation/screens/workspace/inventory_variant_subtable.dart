import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';

class InventoryVariantSubtable extends StatelessWidget {
  final ProductMaster product;

  const InventoryVariantSubtable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.isStandalone || product.variants.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final surface = colors?.bgSurface ?? Colors.white;
    final tier2 = colors?.bgTier2 ?? const Color(0xFFF3F6FF);
    final textSecondary = colors?.textSecondary ?? const Color(0xFF64748B);
    final accent = colors?.accentPrimary ?? const Color(0xFF6366F1);

    return Container(
      color: tier2.withValues(alpha: 0.72),
      padding: const EdgeInsets.only(left: 50, right: 18, top: 12, bottom: 16),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: accent, width: 2)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: surface.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: surface.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              child: Wrap(
                spacing: 22,
                runSpacing: 6,
                children: [
                  Text("CATEGORY  " + (product.category.isEmpty ? '—' : product.category), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors?.textPrimary ?? const Color(0xFF26324A))),
                  Text("BRAND  " + (product.brand.isEmpty ? '—' : product.brand), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary)),
                  Text("COST  ₹" + product.cost.toStringAsFixed(0), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary)),
                  Text("MARGIN  " + product.marginPercentage.toStringAsFixed(0) + "%", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary)),
                  Text("REORDER  " + product.reorderLevel.toStringAsFixed(0) + " PCS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: colors.textPrimary)),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
            columnSpacing: 18,
            headingRowHeight: 32,
            dataRowMinHeight: 34,
            dataRowMaxHeight: 38,
            headingRowColor: WidgetStateProperty.all(tier2.withValues(alpha: 0.82)),
            columns: const [
              DataColumn(label: Text("COLOUR / SIZE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textSecondary))),
              DataColumn(label: Text("SKU", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textSecondary))),
              DataColumn(label: Text("BARCODE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textSecondary))),
              DataColumn(label: Text("STOCK", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textSecondary))),
              DataColumn(label: Text("STATUS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textSecondary))),
            ],
            rows: product.variants.map((variant) {
              String statusLabel = "IN STOCK";
              Color statusBg = (colors?.statusSuccess ?? const Color(0xFF16A34A)).withValues(alpha: 0.12);
              Color statusText = colors?.statusSuccess ?? const Color(0xFF16A34A);

              if (variant.qty == 0) {
                statusLabel = "OUT OF STOCK";
                statusBg = (colors?.statusDanger ?? const Color(0xFFDC2626)).withValues(alpha: 0.12);
                statusText = colors?.statusDanger ?? const Color(0xFFDC2626);
              } else if (variant.qty <= product.reorderLevel) {
                statusLabel = "LOW STOCK";
                statusBg = (colors?.statusWarning ?? const Color(0xFFD97706)).withValues(alpha: 0.14);
                statusText = colors?.statusWarning ?? const Color(0xFFD97706);
              }

              return DataRow(
                cells: [
                  DataCell(Text("${variant.color} / ${variant.size}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: accent))),
                  DataCell(Text(variant.sku, style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Color(0xFF64748B)))),
                  DataCell(Text(variant.barcode, style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Color(0xFF64748B)))),
                  DataCell(Text("${variant.qty.toStringAsFixed(0)} PCS", style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.w700))),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: statusText,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
