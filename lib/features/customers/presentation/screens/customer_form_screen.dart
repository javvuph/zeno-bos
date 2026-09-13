import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/customer_address.dart';
import '../../domain/models/customer_credit.dart';
import '../../domain/models/customer_loyalty.dart';
import '../controllers/customer_controller.dart';
import 'package:uuid/uuid.dart';

class CustomerFormScreen extends StatefulWidget {
  final Customer? customer;

  const CustomerFormScreen({
    super.key,
    this.customer,
  });

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final controller = CustomerController(sl<ICustomerRepository>());
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _creditLimitController = TextEditingController();

  CustomerType _type = CustomerType.individual;

  List<String> _groupIds = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    if (widget.customer != null) {
      final c = widget.customer!;
      _nameController.text = c.name;
      _companyController.text = c.companyName ?? '';
      _taxIdController.text = c.taxId ?? '';
      _emailController.text = c.email;
      _phoneController.text = c.phone;
      _type = c.type;
      _groupIds = List.from(c.groupIds);
      if (c.addresses.isNotEmpty) {
        _addressController.text = c.addresses.first.addressLine1;
        _cityController.text = c.addresses.first.city;
      }
      _creditLimitController.text = c.credit.creditLimit.toString();
    }
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _nameController.dispose();
    _companyController.dispose();
    _taxIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final customer = Customer(
      id: widget.customer?.id ?? const Uuid().v4(),
      customerCode: widget.customer?.customerCode ??
          'CUST-${const Uuid().v4().substring(0, 8).toUpperCase()}',
      type: _type,
      name: _nameController.text,
      companyName:
          _companyController.text.isNotEmpty ? _companyController.text : null,
      taxId: _taxIdController.text.isNotEmpty ? _taxIdController.text : null,
      email: _emailController.text,
      phone: _phoneController.text,
      addresses: [
        CustomerAddress(
          id: const Uuid().v4(),
          label: 'PRIMARY',
          addressLine1: _addressController.text,
          city: _cityController.text,
          state: '',
          country: 'US',
          zipCode: '',
          type: AddressType.office,
          isDefault: true,
        )
      ],
      credit: CustomerCredit(
        creditLimit: double.tryParse(_creditLimitController.text) ?? 0.0,
        currentBalance: widget.customer?.credit.currentBalance ?? 0.0,
      ),
      groupIds: _groupIds,
      loyalty: widget.customer?.loyalty ?? const CustomerLoyalty(),
      createdAt: widget.customer?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await controller.saveCustomer(customer);
    if (mounted && controller.error == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZenoInputFormTemplate(
        title: widget.customer == null
            ? "Register New Customer"
            : "Edit Customer Profile",
        breadcrumbs: const ["CRM", "CUSTOMERS", "REGISTRATION"],
        onSave: _handleSave,
        onCancel: () => Navigator.pop(context),
        isSaving: controller.isLoading,
        sections: [
          ZenoFormSection(
            title: "Identity & Classification",
            children: [
              ZenoDropdown<CustomerType>(
                label: "Customer Type",
                value: _type,
                isRequired: true,
                items: CustomerType.values
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              ZenoTextField(
                label: "Full Legal Name",
                controller: _nameController,
                isRequired: true,
                hint: "e.g. John Doe / Acme Corp",
              ),
              if (_type == CustomerType.business) ...[
                ZenoTextField(
                  label: "Company Registered Name",
                  controller: _companyController,
                  hint: "Trading name if different",
                ),
                ZenoTextField(
                  label: "Tax Identification (GST/VAT)",
                  controller: _taxIdController,
                  hint: "Registration number",
                ),
              ],
            ],
          ),
          ZenoFormSection(
            title: "Contact Intelligence",
            children: [
              ZenoTextField(
                label: "Email Address",
                controller: _emailController,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                hint: "primary@domain.com",
              ),
              ZenoTextField(
                label: "Phone Number",
                controller: _phoneController,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hint: "+1 000 000 000",
              ),
            ],
          ),
          ZenoFormSection(
            title: "Logistics & Location",
            children: [
              ZenoTextField(
                label: "Street Address",
                controller: _addressController,
                hint: "Building, Street, Area",
              ),
              ZenoTextField(
                label: "City / Region",
                controller: _cityController,
                hint: "Administrative district",
              ),
            ],
          ),
          ZenoFormSection(
            title: "Financial Governance",
            children: [
              ZenoTextField(
                label: "Credit Limit",
                controller: _creditLimitController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                hint: "0.00",
              ),
            ],
          ),
          ZenoFormSection(
            title: "Strategic Segmentation",
            children: [
              ZenoDropdown<String>(
                label: "Primary Segment / Group",
                value: _groupIds.isNotEmpty ? _groupIds.first : null,
                items: const [
                  DropdownMenuItem(value: "vip", child: Text("VIP PLATINUM")),
                  DropdownMenuItem(value: "corp", child: Text("CORPORATE")),
                  DropdownMenuItem(value: "retail", child: Text("RETAIL")),
                ],
                onChanged: (v) => setState(() {
                  if (v != null) _groupIds = [v];
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
