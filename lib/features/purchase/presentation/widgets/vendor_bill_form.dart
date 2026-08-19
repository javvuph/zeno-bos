import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';

class VendorBillForm extends StatefulWidget {
  const VendorBillForm({super.key});

  @override
  State<VendorBillForm> createState() => _VendorBillFormState();
}

class _VendorBillFormState extends State<VendorBillForm> {
  final _invoiceNumController = TextEditingController();
  final _supplierController = TextEditingController();
  final _poController = TextEditingController();
  final _grnController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _invoiceNumController.dispose();
    _supplierController.dispose();
    _poController.dispose();
    _grnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: "Register Vendor Bill",
      breadcrumbs: const ["Procurement", "Payables", "New Bill"],
      onSave: () async {
        // Mock save logic
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Invoice Identification",
          children: [
            TextField(
              controller: _invoiceNumController,
              decoration: const InputDecoration(
                  labelText: "Vendor Invoice #", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _supplierController,
              decoration: const InputDecoration(
                  labelText: "Supplier", border: OutlineInputBorder()),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Reference Documents",
          children: [
            TextField(
              controller: _poController,
              decoration: const InputDecoration(
                  labelText: "Purchase Order Ref",
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: _grnController,
              decoration: const InputDecoration(
                  labelText: "Goods Receipt Note (GRN)",
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      ],
    );
  }
}
