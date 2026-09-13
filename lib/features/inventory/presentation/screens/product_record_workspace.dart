import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class ProductRecordWorkspace extends StatefulWidget {
  final bool isEdit;
  final String? productId;

  const ProductRecordWorkspace(
      {super.key, this.isEdit = false, this.productId});

  @override
  State<ProductRecordWorkspace> createState() => _ProductRecordWorkspaceState();
}

class _ProductRecordWorkspaceState extends State<ProductRecordWorkspace> {
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  String _category = "Electronics";
  String _brand = "Apple";
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _nameController.text = "iPhone 15 Pro";
      _skuController.text = widget.productId ?? "PHN-15-PRO";
      _priceController.text = "999.00";
      _stockController.text = "42";
    }
  }

  void _handleSave() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1)); // Mock network lag
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Product successfully synced to catalogue"),
            backgroundColor: Color(0xFF00FF88)),
      );
      NavigationController().navigateTo('inventory/products/list');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoInputFormTemplate(
      title: widget.isEdit ? "Edit Product Record" : "Create New Product",
      breadcrumbs: ["Inventory", "Catalogue", widget.isEdit ? "Edit" : "New"],
      saveLabel: widget.isEdit ? "UPDATE & SYNC" : "SAVE & CREATE",
      isSaving: _isSaving,
      onSave: _handleSave,
      onCancel: () =>
          NavigationController().navigateTo('inventory/products/list'),
      statusBadge: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: colors.statusSuccess.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border:
              Border.all(color: colors.statusSuccess.withValues(alpha: 0.3)),
        ),
        child: Text(
          widget.isEdit ? "ACTIVE" : "DRAFT",
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: colors.statusSuccess),
        ),
      ),
      sections: [
        ZenoFormSection(
          title: "General Identification",
          children: [
            ZenoTextField(
                label: "Product Name",
                controller: _nameController,
                hint: "e.g. MacBook Pro M3",
                isRequired: true),
            ZenoTextField(
                label: "SKU / Model Number",
                controller: _skuController,
                hint: "AUTO-GENERATE",
                isRequired: true),
            ZenoDropdown<String>(
              label: "Primary Category",
              value: _category,
              items: ["Electronics", "Apparel", "Hardware", "Services"]
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            ZenoDropdown<String>(
              label: "Brand / Manufacturer",
              value: _brand,
              items: ["Apple", "Samsung", "Nike", "Dell"]
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _brand = v!),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Pricing & Valuation",
          children: [
            ZenoTextField(
                label: "Base Selling Price",
                controller: _priceController,
                hint: "0.00",
                prefix: const Icon(Icons.attach_money),
                keyboardType: TextInputType.number),
            ZenoTextField(
                label: "Cost Price (Weighted)",
                controller: TextEditingController(text: "750.00"),
                readOnly: true,
                prefix: const Icon(Icons.account_balance_wallet_outlined)),
            ZenoDropdown<String>(
              label: "Tax Rule",
              value: "Standard 15%",
              items: ["Standard 15%", "Reduced 5%", "Exempt 0%"]
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) {},
            ),
            ZenoTextField(
                label: "Profit Margin (%)",
                controller: TextEditingController(text: "24.9%"),
                readOnly: true,
                suffix: const Text("%", style: TextStyle(fontSize: 10))),
          ],
        ),
        ZenoFormSection(
          title: "Inventory & Fulfillment",
          children: [
            ZenoTextField(
                label: "Initial Stock Level",
                controller: _stockController,
                hint: "0",
                keyboardType: TextInputType.number),
            ZenoTextField(
                label: "Reorder Point (Min)",
                controller: TextEditingController(text: "10"),
                keyboardType: TextInputType.number),
            ZenoDropdown<String>(
              label: "Default Warehouse",
              value: "Main HQ",
              items: ["Main HQ", "Regional Depot", "Retail Storefront"]
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) {},
            ),
            const ZenoTextField(label: "Storage Bin / Aisle", hint: "A-102-B"),
          ],
        ),
      ],
    );
  }
}
