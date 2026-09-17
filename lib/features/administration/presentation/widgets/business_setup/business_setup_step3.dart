import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'business_setup_models.dart';
import 'business_setup_constants.dart';
import 'business_setup_theme.dart';

class BusinessSetupStep3 extends StatelessWidget {
  final BusinessSetupData setupData;
  final TextEditingController invoicePrefixController;
  final TextEditingController orderPrefixController;
  final TextEditingController receiptPrefixController;
  final TextEditingController purchasePrefixController;
  final VoidCallback onFieldChanged;

  const BusinessSetupStep3({
    super.key,
    required this.setupData,
    required this.invoicePrefixController,
    required this.orderPrefixController,
    required this.receiptPrefixController,
    required this.purchasePrefixController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Terminal & Hardware
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BusinessSetupTheme.sectionTitle("Terminal & Hardware"),
                BusinessSetupTheme.formLabel("Terminal Type", isRequired: true),
                ZenoDropdown<String>(
                  label: "",
                  value: setupData.terminalType,
                  items: BusinessSetupConstants.terminalTypes
                      .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setupData.terminalType = v;
                      onFieldChanged();
                    }
                  },
                ),
                const SizedBox(height: 10),
                BusinessSetupTheme.formLabel("Hardware Type", isRequired: true),
                ZenoDropdown<String>(
                  label: "",
                  value: setupData.hardwareType,
                  items: BusinessSetupConstants.hardwareTypes
                      .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setupData.hardwareType = v;
                      onFieldChanged();
                    }
                  },
                ),
                const SizedBox(height: 10),
                BusinessSetupTheme.formLabel("Operation Mode", isRequired: true),
                ZenoDropdown<String>(
                  label: "",
                  value: setupData.operationMode,
                  items: BusinessSetupConstants.operationModes
                      .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setupData.operationMode = v;
                      onFieldChanged();
                    }
                  },
                ),
                const SizedBox(height: 10),
                BusinessSetupTheme.formLabel("Receipt Template", isRequired: true),
                ZenoDropdown<String>(
                  label: "",
                  value: setupData.receiptTemplate,
                  items: BusinessSetupConstants.receiptTemplates
                      .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setupData.receiptTemplate = v;
                      onFieldChanged();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Right: Accounting & Payments & Prefixes
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BusinessSetupTheme.formSectionDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BusinessSetupTheme.sectionTitle("Accounting & Payments"),
                BusinessSetupTheme.formLabel("Inventory Costing Method", isRequired: true),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: BusinessSetupConstants.costingMethods.map((method) {
                    final isSelected = setupData.costingMethod == method;
                    return InkWell(
                      onTap: () {
                        setupData.costingMethod = method;
                        onFieldChanged();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: isSelected ? BusinessSetupTheme.bgGradient : null,
                          color: isSelected ? null : const Color(0x1A667EEA),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0x4D667EEA)),
                        ),
                        child: Text(
                          method,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : BusinessSetupTheme.primaryPurple,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                BusinessSetupTheme.formLabel("Supported Payment Methods", isRequired: true),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: BusinessSetupConstants.paymentMethodOptions.map((pm) {
                    final isSelected = setupData.paymentMethods.contains(pm);
                    return InkWell(
                      onTap: () {
                        if (isSelected) {
                          setupData.paymentMethods.remove(pm);
                        } else {
                          setupData.paymentMethods.add(pm);
                        }
                        onFieldChanged();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: isSelected ? BusinessSetupTheme.bgGradient : null,
                          color: isSelected ? null : const Color(0x1A667EEA),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0x4D667EEA)),
                        ),
                        child: Text(
                          pm,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : BusinessSetupTheme.primaryPurple,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                BusinessSetupTheme.sectionTitle("Document Numbering Prefixes"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BusinessSetupTheme.formLabel("Invoice"),
                          ZenoTextField(
                            controller: invoicePrefixController,
                            hint: "INV",
                            onChanged: (v) {
                              setupData.invoicePrefix = v;
                              onFieldChanged();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BusinessSetupTheme.formLabel("Order"),
                          ZenoTextField(
                            controller: orderPrefixController,
                            hint: "ORD",
                            onChanged: (v) {
                              setupData.orderPrefix = v;
                              onFieldChanged();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BusinessSetupTheme.formLabel("Receipt"),
                          ZenoTextField(
                            controller: receiptPrefixController,
                            hint: "REC",
                            onChanged: (v) {
                              setupData.receiptPrefix = v;
                              onFieldChanged();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BusinessSetupTheme.formLabel("Purchase"),
                          ZenoTextField(
                            controller: purchasePrefixController,
                            hint: "PUR",
                            onChanged: (v) {
                              setupData.purchasePrefix = v;
                              onFieldChanged();
                            },
                          ),
                        ],
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
