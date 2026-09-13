import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/employee.dart';
import '../controllers/staff_controller.dart';
import 'package:uuid/uuid.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Employee? existingEmployee;
  const EmployeeFormScreen({super.key, this.existingEmployee});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  late StaffController _controller;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedDept;
  final _desController = TextEditingController(text: 'DES_STAF');
  EmployeeStatus _status = EmployeeStatus.active;

  @override
  void initState() {
    super.initState();
    _controller = sl<StaffController>();
    _controller.addListener(_onUpdate);
    if (widget.existingEmployee != null) {
      _firstNameController.text = widget.existingEmployee!.firstName;
      _lastNameController.text = widget.existingEmployee!.lastName;
      _emailController.text = widget.existingEmployee!.email;
      _phoneController.text = widget.existingEmployee!.phone;
      _selectedDept = widget.existingEmployee!.departmentId;
      _desController.text = widget.existingEmployee!.designationId;
      _status = widget.existingEmployee!.status;
    }
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onUpdate);
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: widget.existingEmployee == null
          ? "Onboard Employee"
          : "Edit Personnel",
      breadcrumbs: const ["Staff", "Ledger", "Form"],
      onSave: () async {
        final employee = Employee(
          id: widget.existingEmployee?.id ??
              "EMP-${const Uuid().v4().substring(0, 5).toUpperCase()}",
          employeeCode: widget.existingEmployee?.employeeCode ?? 
              "ZEN-${const Uuid().v4().substring(0, 4).toUpperCase()}",
          companyId: 'comp_1',
          branchId: 'br_1',
          departmentId: _selectedDept ?? 'DEPT_GEN',
          designationId: _desController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          dateOfJoining: widget.existingEmployee?.dateOfJoining ?? DateTime.now(),
          status: _status,
          createdAt: widget.existingEmployee?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _controller.saveEmployee(employee);
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Personal Identity",
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                        labelText: "First Name", border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                        labelText: "Last Name", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: "Official Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                  labelText: "Contact Phone", border: OutlineInputBorder()),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Organizational Assignment",
          children: [
            DropdownButtonFormField<String>(
              value: _selectedDept,
              decoration: const InputDecoration(
                  labelText: "Department", border: OutlineInputBorder()),
              items: _controller.departments
                  .map((d) => DropdownMenuItem<String>(
                      value: d.id as String, child: Text(d.name.toString().toUpperCase())))
                  .toList(),
              onChanged: (v) => setState(() => _selectedDept = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _desController,
              decoration: const InputDecoration(
                  labelText: "Designation ID", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<EmployeeStatus>(
              value: _status,
              decoration: const InputDecoration(
                  labelText: "Employment Status", border: OutlineInputBorder()),
              items: EmployeeStatus.values
                  .map((s) => DropdownMenuItem(
                      value: s, child: Text(s.name.toUpperCase())))
                  .toList(),
              onChanged: (v) => setState(() => _status = v!),
            ),
          ],
        ),
      ],
    );
  }
}
