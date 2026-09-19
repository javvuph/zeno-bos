import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_controller.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/billing_product_browser.dart';

part 'parts/smart_cart_grid_action_chip.part.dart';

class SmartCartGrid extends StatefulWidget {
  const SmartCartGrid({super.key});

  @override
  State<SmartCartGrid> createState() => SmartCartGridState();
}

class SmartCartGridState extends State<SmartCartGrid> {
  final TextEditingController _scanController = TextEditingController();
  final FocusNode _scanFocusNode = FocusNode();
  final ProductController _inventory = sl<ProductController>();

  @override
  void dispose() {
    _scanController.dispose();
    _scanFocusNode.dispose();
    super.dispose();
  }

  void focusQuickAdd() {
    _scanFocusNode.requestFocus();
  }

  void _onScan(String value) {
    if (value.isNotEmpty) {
      context.read<BillingStudioController>().add(AddItemRequested(value));
      _scanController.clear();
      _scanFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                border: Border.symmetric(
                    horizontal: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  const Icon(Icons.qr_code_scanner_rounded,
                      size: 18, color: Color(0xFF6366F1)),
                  const SizedBox(width: 10),
                  const Text("QUICK ADD:",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF475569))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _scanController,
                              focusNode: _scanFocusNode,
                              onSubmitted: _onScan,
                              decoration: const InputDecoration(
                                hintText: "SCAN OR TYPE PRODUCT SKU... (F3 / Ctrl+F)",
                                hintStyle:
                                    TextStyle(fontSize: 9, color: Colors.grey),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text("ITEMS: ${state.activeBill.items.length}",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E293B))),
                  const SizedBox(width: 16),
                  _ActionChip(
                      icon: Icons.pause_circle_outline,
                      label: "HOLD (F8)",
                      color: Colors.orange,
                      onTap: () => context
                          .read<BillingStudioController>()
                          .add(BillHoldRequested())),
                  _ActionChip(
                      icon: Icons.delete_outline_rounded,
                      label: "CLEAR",
                      color: Colors.red,
                      onTap: () => context
                          .read<BillingStudioController>()
                          .add(ClearCartRequested())),
                  const SizedBox(width: 6),
                  _ActionChip(
                      icon: Icons.grid_view_rounded,
                      label: "GRID",
                      color: const Color(0xFF6366F1),
                      onTap: () => _openInventoryGrid(context)),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.white,
                child: ZenoTable<BillItem>(
                  items: state.activeBill.items,
                  onDeleteRequested: (itemsToDelete) {
                    for (final item in itemsToDelete) {
                      context.read<BillingStudioController>().add(
                            RemoveItemRequested(item.productId),
                          );
                    }
                  },
                  columns: [
                    ZenoTableColumn(
                      label: '#',
                      width: 32,
                      textExtractor: (item) =>
                          '${state.activeBill.items.indexOf(item) + 1}',
                      builder: (item) => Text(
                          '${state.activeBill.items.indexOf(item) + 1}',
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                    ZenoTableColumn(
                      label: 'Item',
                      width: 280,
                      textExtractor: (item) => item.productName,
                      builder: (item) => Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Icon(Icons.image_outlined,
                                size: 14, color: Color(0xFF64748B)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.productName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Color(0xFF1E293B))),
                                Text("SKU: ${item.sku}",
                                    style: const TextStyle(
                                        fontSize: 7,
                                        color: Color(0xFF94A3B8),
                                        fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ZenoTableColumn(
                      label: 'Stock',
                      width: 80,
                      textExtractor: (item) => _stockFor(item).toString(),
                      builder: (item) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${_stockFor(item)}",
                              style: const TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold)),
                          Text(_stockFor(item) > 0 ? "In stock" : "Out of stock",
                              style: TextStyle(
                                  fontSize: 7,
                                  color: _stockFor(item) > 0 ? const Color(0xFF10B981) : const Color(0xFFDC2626),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    ZenoTableColumn(
                      label: 'Qty',
                      width: 100,
                      textExtractor: (item) => "${item.quantity}",
                      builder: (item) => Row(
                        children: [
                          _QtyBtn(
                              icon: Icons.remove,
                              onTap: () => _updateQty(context, item, -1)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text("${item.quantity}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                          _QtyBtn(
                              icon: Icons.add,
                              onTap: () => _updateQty(context, item, 1)),
                        ],
                      ),
                    ),
                    ZenoTableColumn(
                      label: 'Price',
                      width: 80,
                      isNumeric: true,
                      textExtractor: (item) => item.unitPrice.toStringAsFixed(2),
                      builder: (item) => Text(
                          "₹${item.unitPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                    ZenoTableColumn(
                      label: 'Tax',
                      width: 50,
                      isNumeric: true,
                      textExtractor: (item) => item.taxes.isEmpty ? "0%" : "${item.taxes.first.percentage}%",
                      builder: (item) => Text(
                          item.taxes.isEmpty ? "0%" : "${item.taxes.first.percentage}%",
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                    ZenoTableColumn(
                      label: 'Total',
                      width: 90,
                      isNumeric: true,
                      textExtractor: (item) => item.totalAmount.toStringAsFixed(2),
                      builder: (item) => Text(
                          "₹${item.totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1E293B),
                              fontSize: 12)),
                    ),
                    ZenoTableColumn(
                      label: '',
                      width: 32,
                      textExtractor: (item) => '',
                      builder: (item) => const Icon(Icons.more_vert_rounded,
                          size: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openInventoryGrid(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(28),
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 980,
            height: 680,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.grid_view_rounded,
                              size: 18, color: Color(0xFF6366F1)),
                          const SizedBox(width: 8),
                          const Text(
                            'INVENTORY PRODUCTS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: .8,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Select a product to add to the bill',
                            style: TextStyle(
                                fontSize: 9, color: Color(0xFF64748B)),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            tooltip: 'Close',
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            icon: const Icon(Icons.close_rounded,
                                size: 18, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: BillingProductBrowser()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _stockFor(BillItem item) {
    final product = _inventory.allProducts.cast<dynamic>().firstWhere(
      (p) => p.id == item.productId,
      orElse: () => null,
    );
    if (product == null) return 0;
    return product.stockLevel.round();
  }

  void _updateQty(BuildContext context, BillItem item, int delta) {
    context.read<BillingStudioController>().add(
        UpdateItemQuantityRequested(item.productId, item.quantity + delta));
  }
}
