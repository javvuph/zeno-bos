import 'package:flutter/material.dart';
import 'package:zeno/core/localization/country_registry.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';

abstract class StoreSetupModalStateMixin<T extends StatefulWidget> extends State<T> {
  final controller = StoreSetupController();

  static const Color kPurplePrimary = Color(0xFF667EEA);
  static const Color kPurpleSecondary = Color(0xFF764BA2);

  int activeTab = 0;
  bool isNew = false;
  late StoreBranch editingStore;

  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final taxIdController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final staffPinController = TextEditingController();
  String selectedStaffRole = "Cashier";

  final invoicePrefixController = TextEditingController();
  final orderPrefixController = TextEditingController();
  final receiptPrefixController = TextEditingController();
  final purchasePrefixController = TextEditingController();

  bool isShelfPriceTaxInclusive = true;

  @override
  void initState() {
    super.initState();
    taxIdController.addListener(onTaxIdChanged);
    if (controller.stores.isNotEmpty) {
      loadStore(controller.stores.first);
    } else {
      resetForm();
    }
    controller.addListener(onControllerUpdate);
  }

  void onTaxIdChanged() {
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == editingStore.country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    if (countryProfile.code == 'IN') {
      final text = taxIdController.text.trim();
      final detectedState = CountryRegistry.getStateFromGSTIN(text);
      if (detectedState != null && detectedState != editingStore.state) {
        setState(() {
          editingStore.state = detectedState;
        });
      }
    }
  }

  void onControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    taxIdController.removeListener(onTaxIdChanged);
    staffPinController.dispose();
    controller.removeListener(onControllerUpdate);
    nameController.dispose();
    legalNameController.dispose();
    taxIdController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    invoicePrefixController.dispose();
    orderPrefixController.dispose();
    receiptPrefixController.dispose();
    purchasePrefixController.dispose();
    super.dispose();
  }

  void loadStore(StoreBranch store) {
    setState(() {
      isNew = false;
      editingStore = store.copy();
      nameController.text = editingStore.name;
      legalNameController.text = editingStore.legalName;
      taxIdController.text = editingStore.taxId;
      addressController.text = editingStore.address;
      cityController.text = editingStore.city;
      zipCodeController.text = editingStore.zipCode;
      phoneController.text = editingStore.phone;
      emailController.text = editingStore.email;

      invoicePrefixController.text =
          editingStore.numberingPrefixes['invoice'] ?? "";
      orderPrefixController.text =
          editingStore.numberingPrefixes['order'] ?? "";
      receiptPrefixController.text =
          editingStore.numberingPrefixes['receipt'] ?? "";
      purchasePrefixController.text =
          editingStore.numberingPrefixes['purchase'] ?? "";
    });
  }

  void resetForm() {
    setState(() {
      isNew = true;
      editingStore = StoreBranch(
        id: "PENDING",
        name: "Tagsole Main",
        legalName: "Tagsole Apparel Private Limited",
        industry: "FASHION",
        subType: "Clothing",
        country: "India",
        state: "Kerala",
        address: "",
        city: "",
        zipCode: "",
        phone: "+91",
        email: "branch@zeno.store",
        currency: "INR (₹)",
        taxEngine: "GST",
        taxId: "32AAAAAA000A1Z5",
        isTaxExempt: false,
        status: "Draft",
        qrUrl: "",
        businessSize: "SMALL",
        operationMode: "Counter-Service",
        barcodeTemplate: "EAN-13 Standard",
        receiptTemplate: "Thermal 80mm Standard",
        inventoryMethods: ["FIFO"],
        paymentMethods: ["Cash", "Credit/Debit Card"],
        aiConfig: [],
        workflowApprovals: [],
        numberingPrefixes: {
          "invoice": "INV",
          "order": "ORD",
          "receipt": "REC",
          "purchase": "PUR"
        },
      );
      editingStore.enabledSubTypes = ["Clothing", "Footwear"];
      nameController.text = editingStore.name;
      legalNameController.text = editingStore.legalName;
      taxIdController.text = editingStore.taxId;
      addressController.clear();
      cityController.clear();
      zipCodeController.text = "673001";
      phoneController.text = "+91";
      emailController.text = "branch@zeno.store";

      invoicePrefixController.text = "INV";
      orderPrefixController.text = "ORD";
      receiptPrefixController.text = "REC";
      purchasePrefixController.text = "PUR";

      activeTab = 0;
    });
  }

  void handleCountryChange(String? country) {
    if (country == null) return;
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == country.toLowerCase() || c.code.toLowerCase() == country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    setState(() {
      editingStore.country = countryProfile.name;
      editingStore.currency = "${countryProfile.currency.code} (${countryProfile.currency.symbol})";
      editingStore.taxEngine = countryProfile.tax.label;
      editingStore.timezone = countryProfile.defaultTimezone;

      final availableStates = GlobalSubdivisions.getForCountry(countryProfile.code);

      if (availableStates.isNotEmpty && !availableStates.contains(editingStore.state)) {
        editingStore.state = availableStates.first;
      }

      final code = countryProfile.code.toUpperCase();
      if (['IN', 'AE', 'SA', 'KW', 'OM', 'BH', 'QA', 'GB', 'SG', 'AU', 'DE', 'FR', 'ZA'].contains(code)) {
        isShelfPriceTaxInclusive = true;
      } else if (['US', 'CA', 'JP'].contains(code)) {
        isShelfPriceTaxInclusive = false;
      }

      if (isNew) {
        final newId = controller.generateStoreId(countryProfile.name);
        editingStore = editingStore.copy(
          id: newId,
          qrUrl: "https://zeno.store/${newId.toLowerCase()}",
        );
      }
    });
  }

  Future<void> saveStore() async {
    final nameText = nameController.text.trim();
    final phoneText = phoneController.text.trim();

    if (nameText.isEmpty) {
      setState(() => activeTab = 0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                "Store / Business Name is required",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    final storeToSave = editingStore.copy()
      ..name = nameText
      ..legalName = legalNameController.text.trim().isEmpty ? nameText : legalNameController.text.trim()
      ..taxId = taxIdController.text.trim()
      ..address = addressController.text.trim()
      ..city = cityController.text.trim()
      ..zipCode = zipCodeController.text.trim()
      ..phone = phoneText
      ..email = emailController.text.trim();

    String finalId = storeToSave.id;
    if (isNew && (finalId == "PENDING" || finalId.isEmpty)) {
      finalId = controller.generateStoreId(storeToSave.country);
    }

    final savedStore = storeToSave.copy(
      id: finalId,
      status: storeToSave.status == "Draft" ? "Active" : storeToSave.status,
      qrUrl: "https://zeno.store/${finalId.toLowerCase()}",
    );

    await controller.saveStore(savedStore);
    loadStore(savedStore);

    if (mounted) {
      final modelName = savedStore.industry.isNotEmpty ? savedStore.industry : "Retail";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "🎉 ${savedStore.name} successfully configured! Launching $modelName POS...",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          backgroundColor: kPurplePrimary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
}
