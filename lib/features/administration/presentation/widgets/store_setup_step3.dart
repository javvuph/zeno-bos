import 'package:flutter/material.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';
import 'store_setup_step3_hardware.dart';
import 'store_setup_step3_accounting.dart';

class StoreSetupStep3 extends StatelessWidget {
  final StoreBranch editingStore;
  final StoreSetupController controller;
  final TextEditingController invoicePrefixController;
  final TextEditingController orderPrefixController;
  final TextEditingController receiptPrefixController;
  final TextEditingController purchasePrefixController;
  final VoidCallback onStateChanged;

  const StoreSetupStep3({
    super.key,
    required this.editingStore,
    required this.controller,
    required this.invoicePrefixController,
    required this.orderPrefixController,
    required this.receiptPrefixController,
    required this.purchasePrefixController,
    required this.onStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StoreSetupStep3Hardware(
                editingStore: editingStore,
                controller: controller,
                onStateChanged: onStateChanged,
              ),
              const SizedBox(height: 25),
              StoreSetupStep3Accounting(
                editingStore: editingStore,
                invoicePrefixController: invoicePrefixController,
                orderPrefixController: orderPrefixController,
                receiptPrefixController: receiptPrefixController,
                purchasePrefixController: purchasePrefixController,
                onStateChanged: onStateChanged,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StoreSetupStep3Hardware(
                editingStore: editingStore,
                controller: controller,
                onStateChanged: onStateChanged,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: StoreSetupStep3Accounting(
                editingStore: editingStore,
                invoicePrefixController: invoicePrefixController,
                orderPrefixController: orderPrefixController,
                receiptPrefixController: receiptPrefixController,
                purchasePrefixController: purchasePrefixController,
                onStateChanged: onStateChanged,
              ),
            ),
          ],
        );
      },
    );
  }
}
