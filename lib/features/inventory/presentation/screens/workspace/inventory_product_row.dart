import 'package:flutter/material.dart';
import 'package:zeno/app/theme_colors.dart';
import 'package:zeno/features/inventory/domain/models/product_master_models.dart';
import 'inventory_variant_subtable.dart';

class InventoryProductRow extends StatelessWidget {
  final ProductMaster product;
  final bool isSelected;
  final ValueChanged<bool?> onSelectChanged;
  final VoidCallback onToggleExpand;
  final VoidCallback onEdit;
  final VoidCallback onAdjustStock;
  final VoidCallback onDelete;

  const InventoryProductRow({
    super.key,
    required this.product,
    required this.isSelected,
    required this.onSelectChanged,
    required this.onToggleExpand,
    required this.onEdit,
    required this.onAdjustStock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final aging = getAgingMeta(product.addedDate);
    final stock = product.totalStock;
    final colors = Theme.of(context).extension<ZenoSemanticColors>();
    final border = colors?.borderSubtle ?? const Color(0xFFD9DFF2);
    final textPrimary = colors?.textPrimary ?? const Color(0xFF26324A);
    final textSecondary = colors?.textSecondary ?? const Color(0xFF64748B);
    final status = stock <= 0
        ? ("OUT OF STOCK", colors?.statusDanger ?? const Color(0xFFDC2626), (colors?.statusDanger ?? const Color(0xFFDC2626)).withValues(alpha: 0.12))
        : (stock <= product.reorderLevel
            ? ("LOW STOCK", colors?.statusWarning ?? const Color(0xFFB45309), (colors?.statusWarning ?? const Color(0xFFD97706)).withValues(alpha: 0.14))
            : ("IN STOCK", colors?.statusSuccess ?? const Color(0xFF15803D), (colors?.statusSuccess ?? const Color(0xFF16A34A)).withValues(alpha: 0.12)));

    return Column(
      children: [
        // PARENT ROW (CLEAN TEXT IDENTITY)
        Container(
          height: 52,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: border.withValues(alpha: 0.72))),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              SizedBox(
                width: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: onSelectChanged,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const SizedBox(width: 12),

              // PRODUCT / STYLE CELL (Text-Only Identity + Aging Badge)
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: aging.bgColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: aging.borderColor),
                          ),
                          child: Text(
                            aging.tag,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: aging.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          product.sku,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: textSecondary,
                          ),
                        ),
                        const Text(" • ", style: TextStyle(color: Color(0xFF94A3B8))),
                        Text(
                          "Added ${formatDate(product.addedDate)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // RETAIL
              SizedBox(
                width: 120,
                child: Text(
                  "₹${product.retail.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),

              // STOCK
              SizedBox(
                width: 110,
                child: Text(
                  "${stock.toStringAsFixed(0)} PCS",
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),

              // STATUS
              SizedBox(width: 110, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: status.$3, borderRadius: BorderRadius.circular(999)), child: Text(status.$1, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: status.$2)))),

              // LOCATION
              SizedBox(
                width: 130,
                child: Text(
                  product.location,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),

              // VARIANTS CAPSULE PILL (Height 32, Radius 9999)
              SizedBox(
                width: 160,
                child: product.isStandalone
                    ? Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: (colors?.accentPurple ?? const Color(0xFF7C3AED)).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(color: (colors?.accentPurple ?? const Color(0xFF7C3AED)).withValues(alpha: 0.28), width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "STANDALONE",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF7C3AED),
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: onToggleExpand,
                        borderRadius: BorderRadius.circular(9999),
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: product.isExpanded
                                ? const Color(0xFF4338CA)
                                : const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(9999),
                            border: Border.all(
                              color: (colors?.accentPrimary ?? const Color(0xFF6366F1)).withValues(alpha: 0.28),
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.isExpanded ? "▼ " : "▶ ",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: product.isExpanded
                                      ? Colors.white
                                      : const Color(0xFF4338CA),
                                ),
                              ),
                              Text(
                                "${product.variants.length} VARIANTS",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: product.isExpanded
                                      ? Colors.white
                                      : const Color(0xFF4338CA),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),

              // 3-DOT ACTION MENU
              SizedBox(
                width: 60,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz_rounded,
                        color: Color(0xFF64748B)),
                    onSelected: (val) {
                      if (val == "edit") onEdit();
                      if (val == "adjust") onAdjustStock();
                      if (val == "delete") onDelete();
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "edit",
                        child: Text("✏️ Edit Product"),
                      ),
                      const PopupMenuItem(
                        value: "adjust",
                        child: Text("📦 Adjust Stock"),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text("🗑️ Delete Style",
                            style: TextStyle(color: Color(0xFFDC2626))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),

        // NESTED ACCORDION SUBTABLE
        if (!product.isStandalone && product.isExpanded)
          InventoryVariantSubtable(product: product),
      ],
    );
  }
}
