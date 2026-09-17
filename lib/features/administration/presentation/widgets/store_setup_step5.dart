import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

class StoreSetupStep5 extends StatelessWidget {
  final StoreBranch editingStore;
  final TextEditingController staffPinController;
  final String selectedStaffRole;
  final ValueChanged<String?> onRoleChanged;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep5({
    super.key,
    required this.editingStore,
    required this.staffPinController,
    required this.selectedStaffRole,
    required this.onRoleChanged,
  });

  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0x14667EEA), Color(0x0D764BA2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: const Color(0x33667EEA)),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 18,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPurplePrimary, _kPurpleSecondary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kPurplePrimary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF666666),
              letterSpacing: 0.5,
            ),
          ),
          if (isRequired)
            const Text(
              " *",
              style: TextStyle(
                color: Colors.red,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Full Width: Branch Personnel
        Container(
          padding: const EdgeInsets.all(25),
          decoration: _sectionDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Branch Personnel"),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0x1A667EEA), Color(0x0D00D4FF)],
                  ),
                  border: const Border(
                    left: BorderSide(color: _kPurplePrimary, width: 3),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "Staff Accounts: 0 of 10 Used (GROWING Scale)",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _kPurplePrimary,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0x0D667EEA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "No staff members assigned yet. Add your first cashier below.",
                    style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        // Two Columns: Assign Staff & Roles
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: _sectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Assign Staff Member"),
                    _buildFormLabel("Staff Email / Username", isRequired: true),
                    const ZenoTextField(
                      hint: "cashier@zeno.store",
                    ),
                    const SizedBox(height: 15),
                    _buildFormLabel("4-Digit PIN", isRequired: true),
                    ZenoTextField(
                      controller: staffPinController,
                      hint: "1234",
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 25),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: _sectionDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Role & Permissions"),
                    _buildFormLabel("Role", isRequired: true),
                    ZenoDropdown<String>(
                      label: "",
                      value: selectedStaffRole,
                      items: const [
                        DropdownMenuItem(value: "Cashier", child: Text("Cashier (Billing Only)", style: TextStyle(fontSize: 13))),
                        DropdownMenuItem(value: "Manager", child: Text("Manager", style: TextStyle(fontSize: 13))),
                        DropdownMenuItem(value: "Accountant", child: Text("Accountant", style: TextStyle(fontSize: 13))),
                      ],
                      onChanged: onRoleChanged,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x1A4CAF50),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          "✓ Permission: Billing & Cash Management",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
