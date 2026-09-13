import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_supplier_repository.dart';
import '../../domain/models/supplier.dart';
import '../../domain/models/supplier_address.dart';
import '../controllers/supplier_controller.dart';
import 'package:uuid/uuid.dart';

class SupplierFormScreen extends StatefulWidget {
  final Supplier? supplier;

  const SupplierFormScreen({
    super.key,
    this.supplier,
  });

  @override
  State<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends State<SupplierFormScreen> {
  final controller = SupplierController(sl<ISupplierRepository>());
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _legalNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _currencyController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _creditLimitController = TextEditingController();

  SupplierType _type = SupplierType.company;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    if (widget.supplier != null) {
      final s = widget.supplier!;
      _nameController.text = s.name;
      _codeController.text = s.supplierCode;
      _legalNameController.text = s.legalName ?? '';
      _categoryController.text = s.category;
      _emailController.text = s.email;
      _phoneController.text = s.phone;
      _currencyController.text = s.currency;
      _type = s.type;
      if (s.addresses.isNotEmpty) {
        _addressController.text = s.addresses.first.street;
        _cityController.text = s.addresses.first.city;
      }
      _creditLimitController.text = s.creditLimit.toString();
    } else {
      _currencyController.text = 'USD';
      _codeController.text =
          "VND-${const Uuid().v4().substring(0, 4).toUpperCase()}";
    }
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _nameController.dispose();
    _codeController.dispose();
    _legalNameController.dispose();
    _categoryController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currencyController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final supplier = Supplier(
      id: widget.supplier?.id ?? const Uuid().v4(),
      supplierCode: _codeController.text,
      type: _type,
      name: _nameController.text,
      legalName: _legalNameController.text.isNotEmpty
          ? _legalNameController.text
          : null,
      category: _categoryController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      currency: _currencyController.text,
      creditLimit: double.tryParse(_creditLimitController.text) ?? 0.0,
      addresses: [
        SupplierAddress(
          id: widget.supplier?.addresses.firstOrNull?.id ?? const Uuid().v4(),
          label: 'PRIMARY',
          street: _addressController.text,
          city: _cityController.text,
          state: '',
          country: '',
          postalCode: '',
          type: SupplierAddressType.office,
          isDefault: true,
        )
      ],
      createdAt: widget.supplier?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await controller.saveSupplier(supplier);
    if (mounted && controller.error == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZenoInputFormTemplate(
        title: widget.supplier == null
            ? "Onboard New Supplier"
            : "Edit Supplier Profile",
        breadcrumbs: const ["PROCUREMENT", "SUPPLIERS", "ONBOARDING"],
        onSave: _handleSave,
        onCancel: () => Navigator.pop(context),
        isSaving: controller.isLoading,
        sections: [
          ZenoFormSection(
            title: "Business Identity",
            children: [
              Row(
                children: [
                  Expanded(
                    child: ZenoDropdown<SupplierType>(
                      label: "Entity Type",
                      value: _type,
                      isRequired: true,
                      items: SupplierType.values
                          .map((t) => DropdownMenuItem(
                                value: t,
                                child: Text(t.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _type = v!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ZenoTextField(
                      label: "Supplier Code",
                      controller: _codeController,
                      isRequired: true,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              ZenoTextField(
                label: "Supplier Name (Display)",
                controller: _nameController,
                isRequired: true,
                hint: "Common trading name",
              ),
              ZenoTextField(
                label: "Legal Entity Name",
                controller: _legalNameController,
                hint: "Full registered business name",
              ),
              ZenoTextField(
                label: "Industry Category",
                controller: _categoryController,
                isRequired: true,
                hint: "e.g. Raw Materials, Electronics",
              ),
            ],
          ),
          ZenoFormSection(
            title: "Communication Data",
            children: [
              ZenoTextField(
                label: "Corporate Email",
                controller: _emailController,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                hint: "procurement@supplier.com",
              ),
              ZenoTextField(
                label: "Primary Phone",
                controller: _phoneController,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hint: "+1 000 000 000",
              ),
            ],
          ),
          ZenoFormSection(
            title: "Logistics & Finance",
            children: [
              ZenoTextField(
                label: "Base Currency",
                controller: _currencyController,
                isRequired: true,
                hint: "e.g. USD, EUR, GBP",
              ),
              ZenoTextField(
                label: "Credit Limit",
                controller: _creditLimitController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                hint: "0.00",
              ),
              ZenoTextField(
                label: "Warehouse/Office Address",
                controller: _addressController,
                hint: "Street, Building",
              ),
              ZenoTextField(
                label: "City / District",
                controller: _cityController,
                hint: "Operational region",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
