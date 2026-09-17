import 'package:flutter/material.dart';
import '../../domain/models/product.dart';
import '../../domain/models/product_variant.dart';

class InventoryProductRowAccordion extends StatefulWidget {
  final Product product;
  final bool isSelected;
  final ValueChanged<bool?> onSelectChanged;
  final Function(Product, ProductVariant?) onStockIn;
  final Function(Product, ProductVariant?) onStockOut;
  final Function(Product, ProductVariant?) onSetStock;

  const InventoryProductRowAccordion({
    super.key,
    required this.product,
    required this.isSelected,
    required this.onSelectChanged,
    required this.onStockIn,
    required this.onStockOut,
    required this.onSetStock,
  });

  @override
  State<InventoryProductRowAccordion> createState() => _InventoryProductRowAccordionState();
}

class _InventoryProductRowAccordionState extends State<InventoryProductRowAccordion> {
  bool _isExpanded = false;

  Product get p => widget.product;

  String _getVariantColor(ProductVariant v) {
    if (v.attributes.containsKey("Color") && v.attributes["Color"]!.isNotEmpty) {
      return v.attributes["Color"]!;
    }
    if (v.attributes.containsKey("Colour") && v.attributes["Colour"]!.isNotEmpty) {
      return v.attributes["Colour"]!;
    }
    return v.attributes.values.isNotEmpty ? v.attributes.values.first : "-";
  }

  String _getVariantSize(ProductVariant v) {
    if (v.attributes.containsKey("Size") && v.attributes["Size"]!.isNotEmpty) {
      return v.attributes["Size"]!;
    }
    if (v.attributes.values.length > 1) {
      return v.attributes.values.elementAt(1);
    }
    return "-";
  }

  @override
  Widget build(BuildContext context) {
    final totalStock = p.stockLevel.round();
    final isInStock = totalStock > 0;

    final colorsCount = p.variants.map((v) => _getVariantColor(v)).where((c) => c != "-").toSet().length;
    final sizesCount = p.variants.map((v) => _getVariantSize(v)).where((s) => s != "-").toSet().length;

    final cost = p.baseCost > 0 ? p.baseCost : p.basePrice * 0.6;
    final marginPct = p.basePrice > 0 ? (((p.basePrice - cost) / p.basePrice) * 100).round() : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isExpanded ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0),
          width: _isExpanded ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        children: [
          // PARENT ROW HEADER
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Checkbox(
                    value: widget.isSelected,
                    onChanged: widget.onSelectChanged,
                    visualDensity: VisualDensity.compact,
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
                    size: 18,
                    color: const Color(0xFF64748B),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.image_outlined, size: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                        Text(p.sku.value, style: const TextStyle(fontSize: 9, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("₹${p.basePrice.toStringAsFixed(0)}", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("$totalStock PCS", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isInStock ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isInStock ? "IN STOCK" : "OUT OF STOCK",
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: isInStock ? const Color(0xFF047857) : const Color(0xFFB91C1C)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      p.warehouseLocation.isNotEmpty ? p.warehouseLocation : "MAIN HQ",
                      style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      p.variants.isNotEmpty ? "${p.variants.length} variants" : "Standalone",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: p.variants.isNotEmpty ? const Color(0xFF4F46E5) : const Color(0xFF64748B)),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz_rounded, size: 18, color: Color(0xFF64748B)),
                    onSelected: (val) {
                      if (val == 'in') widget.onStockIn(p, null);
                      if (val == 'out') widget.onStockOut(p, null);
                      if (val == 'set') widget.onSetStock(p, null);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'in', child: Text("Stock In")),
                      PopupMenuItem(value: 'out', child: Text("Stock Out")),
                      PopupMenuItem(value: 'set', child: Text("Set Stock")),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // EXPANDED CONTENT
          if (_isExpanded) ...[
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Container(
              padding: const EdgeInsets.all(12),
              color: const Color(0xFFF8FAFC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // METADATA STRIP
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _metaItem("CATEGORY", p.category?.name ?? "Fashion"),
                        _metaItem("BRAND", p.brand?.name ?? "ZENO"),
                        _metaItem("COST", "₹${cost.toStringAsFixed(0)}"),
                        _metaItem("MARGIN", "$marginPct%", isGreen: true),
                        _metaItem("COLOURS", "${colorsCount > 0 ? colorsCount : 1}"),
                        _metaItem("SIZES", "${sizesCount > 0 ? sizesCount : 1}"),
                        _metaItem("UNITS", "$totalStock PCS"),
                        _metaItem("REORDER", "${p.reorderLevel.round()} PCS", isAmber: true),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(4)),
                          child: Text("${p.variants.length} VARIANTS", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF4F46E5))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // EMBEDDED VARIANTS TABLE
                  if (p.variants.isNotEmpty) ...[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                            ),
                            child: const Row(
                              children: [
                                Expanded(flex: 2, child: Text("COLOUR", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                                Expanded(flex: 1, child: Text("SIZE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                                Expanded(flex: 4, child: Text("VARIANT SKU", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                                Expanded(flex: 3, child: Text("BARCODE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                                Expanded(flex: 2, child: Text("QTY", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                                Expanded(flex: 2, child: Text("STATUS", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B)))),
                              ],
                            ),
                          ),
                          ...p.variants.map((v) {
                            final colorStr = _getVariantColor(v);
                            final sizeStr = _getVariantSize(v);
                            final vQty = v.stockLevel.round();
                            final vInStock = vQty > 0;
                            return Container(
                              height: 32,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                              ),
                              child: Row(
                                children: [
                                  Expanded(flex: 2, child: Text(colorStr, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))),
                                  Expanded(flex: 1, child: Text(sizeStr, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF475569)))),
                                  Expanded(flex: 4, child: Text(v.sku.value, style: const TextStyle(fontSize: 9, fontFamily: 'monospace', color: Color(0xFF334155)))),
                                  Expanded(flex: 3, child: Text(v.barcode?.value ?? "AUTO", style: const TextStyle(fontSize: 9, fontFamily: 'monospace', color: Color(0xFF64748B)))),
                                  Expanded(flex: 2, child: Text("$vQty PCS", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)))),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      vInStock ? "IN STOCK" : "OUT OF STOCK",
                                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: vInStock ? const Color(0xFF047857) : const Color(0xFFB91C1C)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _metaItem(String label, String value, {bool isGreen = false, bool isAmber = false}) {
    Color valColor = const Color(0xFF1E293B);
    if (isGreen) valColor = const Color(0xFF047857);
    if (isAmber) valColor = const Color(0xFFD97706);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Color(0xFF94A3B8), letterSpacing: 0.5)),
        const SizedBox(height: 1),
        Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: valColor)),
      ],
    );
  }
}
