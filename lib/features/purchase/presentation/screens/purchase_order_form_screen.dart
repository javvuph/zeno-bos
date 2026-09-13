import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/models/purchase_item.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../controllers/purchase_controller.dart';
import 'package:uuid/uuid.dart';

class PurchaseOrderFormScreen extends StatefulWidget {
  final PurchaseOrder? existingPO;
  const PurchaseOrderFormScreen({super.key, this.existingPO});

  @override
  State<PurchaseOrderFormScreen> createState() =>
      _PurchaseOrderFormScreenState();
}

class _PurchaseOrderFormScreenState extends State<PurchaseOrderFormScreen> {
  late PurchaseController _controller;
  final _idController = TextEditingController();
  final _supplierController = TextEditingController();
  final _currencyController = TextEditingController(text: 'USD');
  final List<PurchaseItem> _items = [];

  @override
  void initState() {
    super.initState();
    _controller = PurchaseController(sl<IPurchaseRepository>());
    if (widget.existingPO != null) {
      _idController.text = widget.existingPO!.id;
      _supplierController.text = widget.existingPO!.supplierId;
      _currencyController.text = widget.existingPO!.currency;
      _items.addAll(widget.existingPO!.items);
    } else {
      _idController.text =
          "PO-${const Uuid().v4().substring(0, 8).toUpperCase()}";
    }
  }

  void _addItem() {
    setState(() {
      _items.add(PurchaseItem(
        productId: 'PROD-${_items.length + 1}',
        variantId: '',
        name: 'New Product',
        quantity: 1,
        unitId: 'unit',
        unitPrice: 100.0,
        taxRate: 10.0,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoInputFormTemplate(
      title: widget.existingPO == null
          ? "Create Purchase Order"
          : "Edit Purchase Order",
      breadcrumbs: const ["Procurement", "Purchase Orders", "Form"],
      onSave: () async {
        final po = PurchaseOrder(
          id: _idController.text,
          poNumber: _idController.text,
          supplierId: _supplierController.text,
          buyerId: 'USER-ADMIN', // Standard default for form
          items: _items,
          currency: _currencyController.text,
          orderDate: DateTime.now(),
          expectedDeliveryDate: DateTime.now().add(const Duration(days: 7)),
          status: POStatus.draft,
          warehouseId: 'WH-MAIN', // Standard default
          branchId: 'B-NORTH', // Standard default
          totalAmount: _items.fold(0, (sum, item) => sum + item.total),
          totalTax: _items.fold(0, (sum, item) => sum + item.taxAmount),
        );
        await _controller.savePO(po);
        if (context.mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Header Information",
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                  labelText: "PO Number", border: OutlineInputBorder()),
              readOnly: widget.existingPO != null,
            ),
            TextField(
              controller: _supplierController,
              decoration: const InputDecoration(
                  labelText: "Supplier ID", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _currencyController,
              decoration: const InputDecoration(
                  labelText: "Currency", border: OutlineInputBorder()),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Order Items",
          columns: 1,
          children: [
            ..._items.map((item) {
              return Card(
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text("Qty: ${item.quantity} @ \$${item.unitPrice}"),
                  trailing: Text("Total: \$${item.total.toStringAsFixed(2)}"),
                ),
              );
            }),
            ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text("ADD PRODUCT"),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Financial Summary",
          children: [
            Text(
                "Total Tax: \$${_items.fold(0.0, (sum, item) => sum + item.taxAmount).toStringAsFixed(2)}",
                style: ZenoTypography.bodyLG(colors.textPrimary)),
            Text(
                "Total Amount: \$${_items.fold(0.0, (sum, item) => sum + item.total).toStringAsFixed(2)}",
                style: ZenoTypography.headlineSM(colors.accentPrimary)),
          ],
        ),
      ],
    );
  }
}
