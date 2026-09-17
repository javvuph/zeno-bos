import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_sales_repository.dart';
import '../controllers/sales_controller.dart';
import '../../domain/models/sales_order.dart';
import '../../domain/models/sales_item.dart';
import '../../domain/models/sales_order_status.dart';
import 'package:uuid/uuid.dart';

part 'parts/sales_order_form_summary.part.dart';

class SalesOrderFormScreen extends StatefulWidget {
  final SalesOrder? existingOrder;
  const SalesOrderFormScreen({super.key, this.existingOrder});

  @override
  State<SalesOrderFormScreen> createState() => _SalesOrderFormScreenState();
}

class _SalesOrderFormScreenState extends State<SalesOrderFormScreen> {
  final controller = SalesController(sl<ISalesRepository>());

  final _customerIdController = TextEditingController();
  final _warehouseIdController = TextEditingController(text: 'wh_1');
  final _currencyController = TextEditingController(text: 'USD');
  final List<SalesItem> _items = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingOrder != null) {
      _customerIdController.text = widget.existingOrder!.customerId;
      _warehouseIdController.text = widget.existingOrder!.warehouseId;
      _currencyController.text = widget.existingOrder!.currency;
      _items.addAll(widget.existingOrder!.items);
    }
    controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _customerIdController.dispose();
    _warehouseIdController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _addItem() {
    setState(() {
      _items.add(SalesItem(
        productId: 'PROD-${_items.length + 1}',
        variantId: 'V-${_items.length + 1}',
        sku: 'SKU-${_items.length + 1}',
        description: 'New Product',
        quantity: 1,
        unit: 'Pc',
        unitPrice: 100.0,
        taxRate: 10.0,
      ));
    });
  }

  Future<void> _handleSave(SalesOrderStatus status) async {
    final order = SalesOrder(
      id: widget.existingOrder?.id ??
          'ORD-${const Uuid().v4().substring(0, 8).toUpperCase()}',
      customerId: _customerIdController.text,
      warehouseId: _warehouseIdController.text,
      items: _items,
      currency: _currencyController.text,
      orderDate: DateTime.now(),
      status: status,
      totalAmount: _items.fold(0.0, (sum, item) => sum + item.total),
      totalTax: _items.fold(0.0, (sum, item) => sum + item.taxAmount),
    );

    await controller.saveOrder(order);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Order ${status == SalesOrderStatus.draft ? 'drafted' : 'created'} successfully")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        ZenoHeader(
          title: widget.existingOrder == null
              ? "New Manual Order"
              : "Edit Sales Order",
          subtitle:
              "CREATE OR UPDATE SALES ORDERS FOR SPECIAL OR B2B REQUESTS.",
          actions: [
            _HeaderBtn(
                label: "Discard",
                icon: Icons.close,
                colors: colors,
                onPressed: () => Navigator.pop(context)),
            const SizedBox(width: 12),
            _HeaderBtn(
              label: "Draft Order",
              icon: Icons.save_outlined,
              colors: colors,
              onPressed: () => _handleSave(SalesOrderStatus.draft),
            ),
            const SizedBox(width: 12),
            _HeaderBtn(
              label: widget.existingOrder == null
                  ? "Create Order"
                  : "Update Order",
              icon: Icons.check,
              isPrimary: true,
              colors: colors,
              onPressed: () => _handleSave(SalesOrderStatus.confirmed),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ZenoCard(
                        title: "CUSTOMER & ORDER INFO",
                        child: Column(
                          children: [
                            ZenoTextField(
                                label: "Customer ID",
                                controller: _customerIdController,
                                hint: "Search or enter customer...",
                                isRequired: true),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                    child: ZenoTextField(
                                        label: "Warehouse ID",
                                        controller: _warehouseIdController,
                                        isRequired: true)),
                                const SizedBox(width: 24),
                                Expanded(
                                    child: ZenoTextField(
                                        label: "Currency",
                                        controller: _currencyController,
                                        isRequired: true)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ZenoCard(
                        title: "ORDER ITEMS",
                        child: Column(
                          children: [
                            if (_items.isEmpty)
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colors.bgTier3,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: colors.borderSubtle),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_shopping_cart,
                                          color: colors.textDisabled),
                                      const SizedBox(height: 8),
                                      Text("No items added yet",
                                          style: ZenoTypography.caption(
                                              colors.textDisabled)),
                                    ],
                                  ),
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _items.length,
                                itemBuilder: (context, index) {
                                  final item = _items[index];
                                  return ListTile(
                                    title: Text(item.description),
                                    subtitle: Text(
                                        "SKU: ${item.sku} | Qty: ${item.quantity}"),
                                    trailing: Text(
                                        "\$${item.total.toStringAsFixed(2)}"),
                                  );
                                },
                              ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  onPressed: _addItem,
                                  icon: const Icon(Icons.add),
                                  label: const Text("Add Product")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "ORDER SUMMARY",
                    child: Column(
                      children: [
                        _SummaryRow(
                            label: "Subtotal",
                            value:
                                "\$${_items.fold(0.0, (sum, i) => sum + i.subtotal).toStringAsFixed(2)}",
                            colors: colors),
                        _SummaryRow(
                            label: "Tax",
                            value:
                                "\$${_items.fold(0.0, (sum, i) => sum + i.taxAmount).toStringAsFixed(2)}",
                            colors: colors),
                        const Divider(height: 32),
                        _SummaryRow(
                            label: "TOTAL",
                            value:
                                "\$${_items.fold(0.0, (sum, i) => sum + i.total).toStringAsFixed(2)}",
                            isBold: true,
                            colors: colors),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
