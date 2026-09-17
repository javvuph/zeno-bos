import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

class StoreSetupStep3Hardware extends StatelessWidget {
  final StoreBranch editingStore;
  final StoreSetupController controller;
  final VoidCallback onStateChanged;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep3Hardware({
    super.key,
    required this.editingStore,
    required this.controller,
    required this.onStateChanged,
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
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: _sectionDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Terminal & Hardware"),
          _buildFormLabel("Operation Mode", isRequired: true),
          ZenoDropdown<String>(
            label: "",
            value: editingStore.operationMode,
            items: controller.operationModes
                .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (v) {
              editingStore.operationMode = v!;
              onStateChanged();
            },
          ),
          const SizedBox(height: 15),
          _buildFormLabel("Receipt Template", isRequired: true),
          ZenoDropdown<String>(
            label: "",
            value: editingStore.receiptTemplate,
            items: controller.receiptTemplates
                .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (v) {
              editingStore.receiptTemplate = v!;
              onStateChanged();
            },
          ),
          const SizedBox(height: 15),
          _buildFormLabel("Barcode Template", isRequired: true),
          ZenoDropdown<String>(
            label: "",
            value: editingStore.barcodeTemplate,
            items: controller.barcodeTemplates
                .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (v) {
              editingStore.barcodeTemplate = v!;
              onStateChanged();
            },
          ),
        ],
      ),
    );
  }
}
