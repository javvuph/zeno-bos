import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';

class SmartCartGrid extends StatefulWidget {
  const SmartCartGrid({super.key});

  @override
  State<SmartCartGrid> createState() => _SmartCartGridState();
}

class _SmartCartGridState extends State<SmartCartGrid> {
  final TextEditingController _scanController = TextEditingController();
  final FocusNode _scanFocusNode = FocusNode();

  @override
  void dispose() {
    _scanController.dispose();
    _scanFocusNode.dispose();
    super.dispose();
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
            // --- 1. QUICK ADD & SCAN BAR (ACTIVATED) ---
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
                                hintText: "SCAN OR TYPE PRODUCT SKU...",
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
                      label: "HOLD",
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
                ],
              ),
            ),

            // --- 2. THE HIGH-DENSITY GRID ---
            Expanded(
              child: Container(
                color: Colors.white,
                child: ZenoTable<BillItem>(
                  items: state.activeBill.items,
                  columns: [
                    ZenoTableColumn(
                      label: '#',
                      width: 32,
                      builder: (item) => Text(
                          '${state.activeBill.items.indexOf(item) + 1}',
                          style: const TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                    ZenoTableColumn(
                      label: 'Item',
                      width: 280,
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
                      builder: (item) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("120",
                              style: TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold)),
                          const Text("Stock",
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    ZenoTableColumn(
                      label: 'Qty',
                      width: 100,
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
                      builder: (item) => Text(
                          "₹${item.unitPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                    ZenoTableColumn(
                        label: 'Tax',
                        width: 50,
                        isNumeric: true,
                        builder: (item) => const Text("5%",
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.bold))),
                    ZenoTableColumn(
                      label: 'Total',
                      width: 90,
                      isNumeric: true,
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

  void _updateQty(BuildContext context, BillItem item, int delta) {
    context.read<BillingStudioController>().add(
        UpdateItemQuantityRequested(item.productId, item.quantity + delta));
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionChip(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.2))),
        child: Row(
          children: [
            Icon(icon, size: 10, color: color),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    color: color, fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFCBD5E1))),
        child: Icon(icon, size: 10, color: const Color(0xFF1E293B)),
      ),
    );
  }
}
