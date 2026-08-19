import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/models/grn.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../controllers/grn_controller.dart';
import 'package:uuid/uuid.dart';

import 'package:zeno/features/inventory/domain/repositories/i_inventory_repository.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_controller.dart';

class GRNFormScreen extends StatefulWidget {
  final PurchaseOrder po;
  const GRNFormScreen({super.key, required this.po});

  @override
  State<GRNFormScreen> createState() => _GRNFormScreenState();
}

class _GRNFormScreenState extends State<GRNFormScreen> {
  late GRNController _controller;
  late InventoryController _inventoryController;
  final _idController = TextEditingController();
  final Map<String, double> _receivedQtys = {};
  String? _selectedWarehouse;

  @override
  void initState() {
    super.initState();
    _controller = GRNController(sl<IPurchaseRepository>());
    _inventoryController = InventoryController(sl<IInventoryRepository>());
    _inventoryController.refreshAll().then((_) {
      if (mounted && _inventoryController.warehouses.isNotEmpty) {
        setState(() =>
            _selectedWarehouse = _inventoryController.warehouses.first.id);
      }
    });

    _idController.text =
        "GRN-${const Uuid().v4().substring(0, 8).toUpperCase()}";
    for (var item in widget.po.items) {
      _receivedQtys[item.productId] = item.quantity;
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _inventoryController,
        builder: (context, _) {
          return ZenoInputFormTemplate(
            title: "Receive Goods (GRN)",
            breadcrumbs: const ["Procurement", "GRN", "New"],
            onSave: () async {
              final grn = GRN(
                id: _idController.text,
                poId: widget.po.id,
                supplierId: widget.po.supplierId,
                warehouseId: _selectedWarehouse ?? 'WH-MAIN',
                branchId: widget.po.branchId,
                receivedDate: DateTime.now(),
                receivedById: 'admin',
                status: GRNStatus.completed,
                receivedItems: widget.po.items
                    .map((i) => GRNItem(
                          orderItem: i,
                          receivedQuantity: _receivedQtys[i.productId] ?? 0,
                          acceptedQuantity: _receivedQtys[i.productId] ?? 0,
                        ))
                    .toList(),
              );
              await _controller.saveGRN(grn);
              if (context.mounted) Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
            sections: [
              ZenoFormSection(
                title: "General Info",
                children: [
                  TextField(
                    controller: _idController,
                    decoration: const InputDecoration(
                        labelText: "GRN Number", border: OutlineInputBorder()),
                  ),
                  ZenoDropdown<String>(
                    label: "Destination Warehouse",
                    value: _selectedWarehouse,
                    items: _inventoryController.warehouses
                        .map((w) => DropdownMenuItem(
                              value: w.id,
                              child: Text(w.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedWarehouse = v),
                    isRequired: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text("Reference PO: ${widget.po.id}",
                        style: ZenoTypography.bodyLG(Colors.grey)),
                  ),
                ],
              ),
              ZenoFormSection(
                title: "Receive Items",
                columns: 1,
                children: widget.po.items
                    .map((item) => Card(
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text("Ordered: ${item.quantity}"),
                            trailing: SizedBox(
                              width: 100,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: "Qty Recv"),
                                onChanged: (v) =>
                                    _receivedQtys[item.productId] =
                                        double.tryParse(v) ?? 0,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          );
        });
  }
}
