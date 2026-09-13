import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/administration_controller.dart';
import '../../domain/models/user_security.dart';
import 'package:uuid/uuid.dart';

class UserFormScreen extends StatefulWidget {
  final User? existingUser;
  const UserFormScreen({super.key, this.existingUser});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  late final AdministrationController controller;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  UserStatus _status = UserStatus.invited;
  List<String> _selectedRoles = [];
  List<String> _selectedBranches = [];

  @override
  void initState() {
    super.initState();
    controller = sl<AdministrationController>();
    if (widget.existingUser != null) {
      _emailController.text = widget.existingUser!.email;
      _nameController.text = widget.existingUser!.displayName;
      _status = widget.existingUser!.status;
      _selectedRoles = List.from(widget.existingUser!.roleIds);
      _selectedBranches = List.from(widget.existingUser!.branchPermissions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: widget.existingUser == null
          ? "Onboard Enterprise User"
          : "Update User Profile",
      breadcrumbs: const ["Admin", "Security", "Users"],
      onSave: () async {
        final user = User(
          id: widget.existingUser?.id ?? const Uuid().v4(),
          email: _emailController.text,
          displayName: _nameController.text,
          status: _status,
          roleIds: _selectedRoles,
          branchPermissions: _selectedBranches,
        );
        await controller.saveUser(user);
        if (context.mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Core Identity",
          children: [
            ZenoTextField(
                label: "Full Name",
                controller: _nameController,
                isRequired: true),
            ZenoTextField(
                label: "Corporate Email",
                controller: _emailController,
                isRequired: true,
                keyboardType: TextInputType.emailAddress),
            ZenoDropdown<UserStatus>(
              label: "Account Status",
              value: _status,
              items: UserStatus.values
                  .map((s) => DropdownMenuItem(
                      value: s, child: Text(s.name.toUpperCase())))
                  .toList(),
              onChanged: (v) => setState(() => _status = v!),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Access Control",
          children: [
            // Simplified role selection for demo
            ZenoDropdown<String>(
              label: "Assigned Role",
              value: _selectedRoles.isNotEmpty ? _selectedRoles.first : null,
              items: controller.roles
                  .map((r) => DropdownMenuItem(
                      value: r.id, child: Text(r.name.toUpperCase())))
                  .toList(),
              onChanged: (v) =>
                  setState(() => _selectedRoles = v != null ? [v] : []),
            ),
            ZenoDropdown<String>(
              label: "Primary Branch",
              value:
                  _selectedBranches.isNotEmpty ? _selectedBranches.first : null,
              items: controller.branches
                  .map((b) => DropdownMenuItem(
                      value: b.id, child: Text(b.name.toUpperCase())))
                  .toList(),
              onChanged: (v) =>
                  setState(() => _selectedBranches = v != null ? [v] : []),
            ),
          ],
        ),
      ],
    );
  }
}
