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
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: accent, width: 2),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: surface.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 18,
            headingRowHeight: 32,
            dataRowMinHeight: 34,
            dataRowMaxHeight: 38,
            headingRowColor: WidgetStateProperty.all(tier2.withValues(alpha: 0.82)),
            columns: const [
              DataColumn(label: Text("COLOUR / SIZE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: textSecondary))),
              DataColumn(label: Text("SKU", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("BARCODE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("STOCK", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("CATEGORY", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("BRAND", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("COST", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("MARGIN", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("REORDER", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              DataColumn(label: Text("STATUS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
            ],
            rows: product.variants.map((variant) {
              String statusLabel = "IN STOCK";
              Color statusBg = const Color(0xFFDCFCE7);
              Color statusText = const Color(0xFF166534);

              if (variant.qty == 0) {
                statusLabel = "OUT OF STOCK";
                statusBg = const Color(0xFFFEE2E2);
                statusText = const Color(0xFF991B1B);
              } else if (variant.qty <= product.reorderLevel) {
                statusLabel = "LOW STOCK";
                statusBg = const Color(0xFFFEF3C7);
                statusText = const Color(0xFF92400E);
              }

              return DataRow(
                cells: [
                  DataCell(Text("${variant.color} / ${variant.size}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: accent))),
                  DataCell(Text(variant.sku, style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Color(0xFF64748B)))),
                  DataCell(Text(variant.barcode, style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Color(0xFF64748B)))),
                  DataCell(Text("${variant.qty.toStringAsFixed(0)} PCS", style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.w700))),
                  DataCell(Text(product.category, style: const TextStyle(fontSize: 12))),
                  DataCell(Text(product.brand, style: const TextStyle(fontSize: 12))),
                  DataCell(Text("₹${product.cost.toStringAsFixed(0)}", style: const TextStyle(fontSize: 12, fontFamily: 'monospace'))),
                  DataCell(Text("${product.marginPercentage.toStringAsFixed(0)}%", style: const TextStyle(fontSize: 12, fontFamily: 'monospace'))),
                  DataCell(Text("${product.reorderLevel.toStringAsFixed(0)} PCS", style: const TextStyle(fontSize: 12, fontFamily: 'monospace'))),
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
