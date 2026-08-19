import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/rfq.dart';
import '../../domain/models/purchase_item.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../controllers/rfq_controller.dart';
import 'package:uuid/uuid.dart';

class RFQForm extends StatefulWidget {
  final RFQ? existingRFQ;
  const RFQForm({super.key, this.existingRFQ});

  @override
  State<RFQForm> createState() => _RFQFormState();
}

class _RFQFormState extends State<RFQForm> {
  late RFQController _controller;
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final List<PurchaseItem> _items = [];
  final List<String> _invitedSuppliers = [];

  @override
  void initState() {
    super.initState();
    _controller = RFQController(sl<IPurchaseRepository>());
    if (widget.existingRFQ != null) {
      _titleController.text = widget.existingRFQ!.title;
      _categoryController.text = widget.existingRFQ!.category;
      _items.addAll(widget.existingRFQ!.items);
      _invitedSuppliers.addAll(widget.existingRFQ!.invitedSupplierIds);
    }
  }

  void _addItem() {
    setState(() {
      _items.add(PurchaseItem(
        productId: 'PROD-${_items.length + 1}',
        variantId: '',
        name: 'Requirement ${_items.length + 1}',
        quantity: 100,
        unitId: 'pcs',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: widget.existingRFQ == null ? "Create New RFQ" : "Edit RFQ",
      breadcrumbs: const ["Procurement", "RFQ", "Form"],
      onSave: () async {
        final rfq = RFQ(
          id: widget.existingRFQ?.id ??
              "RFQ-${const Uuid().v4().substring(0, 8).toUpperCase()}",
          title: _titleController.text,
          category: _categoryController.text,
          requestedById: 'USER-CURRENT',
          department: 'Procurement',
          items: _items,
          invitedSupplierIds: _invitedSuppliers,
          createdAt: DateTime.now(),
          closingDate: DateTime.now().add(const Duration(days: 7)),
          status: RFQStatus.open,
          priority: RFQPriority.medium,
        );
        await _controller.saveRFQ(rfq);
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "General Information",
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: "RFQ Title", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                  labelText: "Requirement Category",
                  border: OutlineInputBorder()),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Line Items & Specifications",
          columns: 1,
          children: [
            ..._items.map((item) => Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                        "Quantity Required: ${item.quantity} ${item.unitId}"),
                    trailing: const Icon(Icons.edit_outlined),
                  ),
                )),
            ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text("ADD REQUIREMENT")),
          ],
        ),
      ],
    );
  }
}
