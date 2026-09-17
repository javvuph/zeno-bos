import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/account.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/finance_controller.dart';
import 'package:uuid/uuid.dart';

class AccountFormScreen extends StatefulWidget {
  final Account? existingAccount;
  const AccountFormScreen({super.key, this.existingAccount});

  @override
  State<AccountFormScreen> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends State<AccountFormScreen> {
  late FinanceController _controller;
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  AccountCategory _selectedCategory = AccountCategory.asset;
  AccountType _selectedType = AccountType.cash;
  final _currencyController = TextEditingController(text: 'USD');

  @override
  void initState() {
    super.initState();
    _controller = FinanceController(sl<IFinanceRepository>());
    if (widget.existingAccount != null) {
      _codeController.text = widget.existingAccount!.code;
      _nameController.text = widget.existingAccount!.name;
      _selectedCategory = widget.existingAccount!.category;
      _selectedType = widget.existingAccount!.type;
      _currencyController.text = widget.existingAccount!.currency;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: widget.existingAccount == null ? "Create Account" : "Edit Account",
      breadcrumbs: const ["Finance", "COA", "Form"],
      onSave: () async {
        final account = Account(
          id: widget.existingAccount?.id ?? const Uuid().v4(),
          code: _codeController.text,
          name: _nameController.text,
          category: _selectedCategory,
          type: _selectedType,
          currency: _currencyController.text,
        );
        await _controller.saveAccount(account);
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Account Details",
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                  labelText: "Account Code (e.g., 1000)",
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: "Account Name", border: OutlineInputBorder()),
            ),
            DropdownButtonFormField<AccountCategory>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                  labelText: "Category", border: OutlineInputBorder()),
              items: AccountCategory.values
                  .map((c) => DropdownMenuItem(
                      value: c, child: Text(c.name.toUpperCase())))
                  .toList(),
              onChanged: (v) => setState(() => _selectedCategory = v!),
            ),
            DropdownButtonFormField<AccountType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                  labelText: "Account Type", border: OutlineInputBorder()),
              items: AccountType.values
                  .map((t) => DropdownMenuItem(
                      value: t, child: Text(t.name.toUpperCase())))
                  .toList(),
              onChanged: (v) => setState(() => _selectedType = v!),
            ),
            TextField(
              controller: _currencyController,
              decoration: const InputDecoration(
                  labelText: "Currency", border: OutlineInputBorder()),
            ),
          ],
        ),
      ],
    );
  }
}
