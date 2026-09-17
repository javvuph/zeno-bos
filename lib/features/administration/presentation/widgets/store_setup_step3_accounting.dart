import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

class StoreSetupStep3Accounting extends StatelessWidget {
  final StoreBranch editingStore;
  final TextEditingController invoicePrefixController;
  final TextEditingController orderPrefixController;
  final TextEditingController receiptPrefixController;
  final TextEditingController purchasePrefixController;
  final VoidCallback onStateChanged;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupStep3Accounting({
    super.key,
    required this.editingStore,
    required this.invoicePrefixController,
    required this.orderPrefixController,
    required this.receiptPrefixController,
    required this.purchasePrefixController,
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

  Widget _buildPaymentChip(String label, {required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(colors: [_kPurplePrimary, _kPurpleSecondary]) : null,
          color: isSelected ? null : const Color(0x1A667EEA),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0x4D667EEA)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : _kPurplePrimary,
          ),
        ),
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
          _buildSectionTitle("Accounting & Payments"),
          _buildFormLabel("Inventory Costing Method", isRequired: true),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ["FIFO", "LIFO", "Weighted Average", "Manual"].map((method) {
              final isSelected = editingStore.inventoryMethods.contains(method);
              return InkWell(
                onTap: () {
                  editingStore.inventoryMethods = [method];
                  onStateChanged();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(colors: [_kPurplePrimary, _kPurpleSecondary])
                        : null,
                    color: isSelected ? null : const Color(0x1A667EEA),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0x4D667EEA)),
                  ),
                  child: Text(
                    method,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : _kPurplePrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          _buildFormLabel("Supported Payment Methods", isRequired: true),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPaymentChip("Cash ✓", isSelected: editingStore.paymentMethods.contains("Cash"), onTap: () {
                if (editingStore.paymentMethods.contains("Cash")) {
                  editingStore.paymentMethods.remove("Cash");
                } else {
                  editingStore.paymentMethods.add("Cash");
                }
                onStateChanged();
              }),
              _buildPaymentChip("Credit/Debit ✓", isSelected: editingStore.paymentMethods.contains("Credit/Debit Card"), onTap: () {
                if (editingStore.paymentMethods.contains("Credit/Debit Card")) {
                  editingStore.paymentMethods.remove("Credit/Debit Card");
                } else {
                  editingStore.paymentMethods.add("Credit/Debit Card");
                }
                onStateChanged();
              }),
              _buildPaymentChip("UPI/QR", isSelected: editingStore.paymentMethods.contains("UPI"), onTap: () {
                if (editingStore.paymentMethods.contains("UPI")) {
                  editingStore.paymentMethods.remove("UPI");
                } else {
                  editingStore.paymentMethods.add("UPI");
                }
                onStateChanged();
              }),
              _buildPaymentChip("Wallet", isSelected: editingStore.paymentMethods.contains("Wallet"), onTap: () {
                if (editingStore.paymentMethods.contains("Wallet")) {
                  editingStore.paymentMethods.remove("Wallet");
                } else {
                  editingStore.paymentMethods.add("Wallet");
                }
                onStateChanged();
              }),
              _buildPaymentChip("Bank Transfer", isSelected: editingStore.paymentMethods.contains("Bank Transfer"), onTap: () {
                if (editingStore.paymentMethods.contains("Bank Transfer")) {
                  editingStore.paymentMethods.remove("Bank Transfer");
                } else {
                  editingStore.paymentMethods.add("Bank Transfer");
                }
                onStateChanged();
              }),
              _buildPaymentChip("Credit", isSelected: editingStore.paymentMethods.contains("Credit"), onTap: () {
                if (editingStore.paymentMethods.contains("Credit")) {
                  editingStore.paymentMethods.remove("Credit");
                } else {
                  editingStore.paymentMethods.add("Credit");
                }
                onStateChanged();
              }),
            ],
          ),
          const SizedBox(height: 15),
          _buildSectionTitle("Document Numbering Prefixes"),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormLabel("Invoice"),
                    ZenoTextField(
                      controller: invoicePrefixController,
                      hint: "INV",
                      onChanged: (v) {
                        editingStore.numberingPrefixes['invoice'] = v;
                        onStateChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormLabel("Order"),
                    ZenoTextField(
                      controller: orderPrefixController,
                      hint: "ORD",
                      onChanged: (v) {
                        editingStore.numberingPrefixes['order'] = v;
                        onStateChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormLabel("Receipt"),
                    ZenoTextField(
                      controller: receiptPrefixController,
                      hint: "REC",
                      onChanged: (v) {
                        editingStore.numberingPrefixes['receipt'] = v;
                        onStateChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormLabel("Purchase"),
                    ZenoTextField(
                      controller: purchasePrefixController,
                      hint: "PUR",
                      onChanged: (v) {
                        editingStore.numberingPrefixes['purchase'] = v;
                        onStateChanged();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
