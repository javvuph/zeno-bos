import 'package:flutter/material.dart';
import 'business_setup_models.dart';
import 'business_setup_theme.dart';
import 'business_setup_main_header.dart';
import 'business_setup_step1.dart';
import 'business_setup_step2.dart';
import 'business_setup_step3.dart';
import 'business_setup_step4.dart';
import 'business_setup_step5.dart';
import 'business_setup_step6.dart';

class BusinessSetupMain extends StatefulWidget {
  const BusinessSetupMain({super.key});

  @override
  State<BusinessSetupMain> createState() => _BusinessSetupMainState();
}

class _BusinessSetupMainState extends State<BusinessSetupMain> {
  final setupData = BusinessSetupData();
  int currentStep = 0;
  bool isSaving = false;

  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final taxIdController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final invoicePrefixController = TextEditingController(text: "INV");
  final orderPrefixController = TextEditingController(text: "ORD");
  final receiptPrefixController = TextEditingController(text: "REC");
  final purchasePrefixController = TextEditingController(text: "PUR");
  final staffPinController = TextEditingController(text: "1234");

  @override
  void initState() {
    super.initState();
    nameController.text = setupData.storeName;
    legalNameController.text = setupData.legalName;
    phoneController.text = setupData.phone;
    emailController.text = setupData.email;
    taxIdController.text = setupData.taxId;
    addressController.text = setupData.address;
    cityController.text = setupData.city;
    zipCodeController.text = setupData.zipCode;
  }

  @override
  void dispose() {
    nameController.dispose();
    legalNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    taxIdController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    invoicePrefixController.dispose();
    orderPrefixController.dispose();
    receiptPrefixController.dispose();
    purchasePrefixController.dispose();
    staffPinController.dispose();
    super.dispose();
  }

  int getTotalSteps() {
    switch (setupData.selectedScale) {
      case BusinessScale.small:
        return 4;
      case BusinessScale.growing:
        return 5;
      case BusinessScale.enterprise:
      case BusinessScale.none:
        return 6;
    }
  }

  String getStepTitle(int index) {
    switch (index) {
      case 0:
        return "Store & Business";
      case 1:
        return "Regional & Tax";
      case 2:
        return "Operations & POS";
      case 3:
        return "Online Store & QR";
      case 4:
        return "Team & Access";
      case 5:
        return "Enterprise Workflows";
      default:
        return "Store & Business";
    }
  }

  void onAnyFieldChanged() {
    setState(() {
      final total = getTotalSteps();
      if (currentStep >= total) {
        currentStep = total - 1;
      }
    });
  }

  Future<void> saveConfiguration() async {
    setState(() => isSaving = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() => isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                "🎉 Business Configuration successfully saved & synced!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: BusinessSetupTheme.primaryPurple,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalSteps = getTotalSteps();
    if (currentStep >= totalSteps) {
      currentStep = totalSteps - 1;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: BusinessSetupTheme.bgGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1600),
              decoration: BusinessSetupTheme.glassPanelDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BusinessSetupMainHeader(
                      setupData: setupData,
                      currentStep: currentStep,
                      totalSteps: totalSteps,
                      stepTitle: getStepTitle(currentStep),
                      onTabSelected: (index) => setState(() => currentStep = index),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: SingleChildScrollView(
                        child: _buildActiveStepContent(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (currentStep > 0) ...[
                          ElevatedButton(
                            onPressed: () => setState(() => currentStep--),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x1A667EEA),
                              foregroundColor: BusinessSetupTheme.primaryPurple,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              elevation: 0,
                            ),
                            child: const Text("← PREVIOUS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                          const SizedBox(width: 12),
                        ] else ...[
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x1A667EEA),
                              foregroundColor: BusinessSetupTheme.primaryPurple,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              elevation: 0,
                            ),
                            child: const Text("CANCEL", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Container(
                          decoration: BoxDecoration(
                            gradient: BusinessSetupTheme.bgGradient,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ElevatedButton(
                            onPressed: isSaving
                                ? null
                                : () {
                                    if (currentStep < totalSteps - 1) {
                                      setState(() => currentStep++);
                                    } else {
                                      saveConfiguration();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: isSaving
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Text("SAVE & SYNC CONFIGURATION", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveStepContent() {
    switch (currentStep) {
      case 0:
        return BusinessSetupStep1(
          setupData: setupData,
          nameController: nameController,
          legalNameController: legalNameController,
          phoneController: phoneController,
          emailController: emailController,
          onFieldChanged: onAnyFieldChanged,
        );
      case 1:
        return BusinessSetupStep2(
          setupData: setupData,
          taxIdController: taxIdController,
          addressController: addressController,
          cityController: cityController,
          zipCodeController: zipCodeController,
          onFieldChanged: onAnyFieldChanged,
        );
      case 2:
        return BusinessSetupStep3(
          setupData: setupData,
          invoicePrefixController: invoicePrefixController,
          orderPrefixController: orderPrefixController,
          receiptPrefixController: receiptPrefixController,
          purchasePrefixController: purchasePrefixController,
          onFieldChanged: onAnyFieldChanged,
        );
      case 3:
        return BusinessSetupStep4(
          setupData: setupData,
          onFieldChanged: onAnyFieldChanged,
        );
      case 4:
        return BusinessSetupStep5(
          setupData: setupData,
          staffPinController: staffPinController,
          onFieldChanged: onAnyFieldChanged,
        );
      case 5:
        return BusinessSetupStep6(
          setupData: setupData,
          onFieldChanged: onAnyFieldChanged,
        );
      default:
        return BusinessSetupStep1(
          setupData: setupData,
          nameController: nameController,
          legalNameController: legalNameController,
          phoneController: phoneController,
          emailController: emailController,
          onFieldChanged: onAnyFieldChanged,
        );
    }
  }
}
