import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

class StoreSetupStep4 extends StatelessWidget {
  final StoreBranch editingStore;
  final ValueChanged<bool?> onAutoPrintChange;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep4({
    super.key,
    required this.editingStore,
    required this.onAutoPrintChange,
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

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF666666),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Store Access
        SizedBox(
          width: 250,
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: _sectionDecoration(),
            child: Column(
              children: [
                _buildSectionTitle("Store Access"),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.qr_code_2, size: 60, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "QR Code",
                  style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 25),

        // Right: Digital Sync
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: _sectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("Digital Sync"),
                _buildFormLabel("System Generated ID"),
                const ZenoTextField(
                  initialValue: "STR-9821-IND",
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                _buildFormLabel("Digital Store URL (Auto-Synced)"),
                const ZenoTextField(
                  initialValue: "https://zeno.store/str-9821-ind",
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Checkbox(
                      value: editingStore.autoPrintPos,
                      onChanged: onAutoPrintChange,
                      activeColor: _kPurplePrimary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Auto-Print POS Receipts",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
